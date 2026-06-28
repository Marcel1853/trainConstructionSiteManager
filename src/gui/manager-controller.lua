---@diagnostic disable: undefined-field, missing-fields

local ManagerController = {}
local ManagerLayout = require("src.gui.manager-layout")

ManagerController.showCoordsState = ManagerController.showCoordsState or {}

local cachedLayout = nil

function ManagerController.getLayout()
  if not cachedLayout then
    cachedLayout = ManagerLayout.create()
  end
  return cachedLayout
end

local function getShowCoords(player)
  if ManagerController.showCoordsState[player.index] == nil then
    ManagerController.showCoordsState[player.index] = false
  end
  return ManagerController.showCoordsState[player.index]
end

function ManagerController.isOpen(player)
  return player.gui.screen["tcs_manager_main_frame"] ~= nil
end

function ManagerController.toggle(player)
  if ManagerController.isOpen(player) then
    ManagerController.close(player)
  else
    ManagerController.open(player)
  end
end

function ManagerController.close(player)
  if player.gui.screen["tcs_manager_main_frame"] then
    player.gui.screen["tcs_manager_main_frame"].destroy()
  end
  if player.gui.screen["tcs_rename_frame"] then
    player.gui.screen["tcs_rename_frame"].destroy()
  end
end

function ManagerController.open(player)
  ManagerController.close(player)
  local root = FLib.gui.create(player.index, ManagerController.getLayout())
  if root then
    player.opened = root
    local header = root["header_flow"]
    if header then
      header.drag_target = root
      local dragger = header["dragger"]
      if dragger then
        dragger.drag_target = root
        dragger.style.horizontally_stretchable = true
        dragger.style.minimal_width = 40
      end
      
      -- Kompakte, rechtsbündige Header Buttons
      for _, bname in pairs({"coords_toggle_btn", "refresh_btn", "close_btn"}) do
        local btn = header[bname]
        if btn then
          btn.style.height = 24
          btn.style.minimal_width = 24
          btn.style.top_padding = 0
          btn.style.bottom_padding = 0
          btn.style.left_padding = 4
          btn.style.right_padding = 4
          btn.style.font = "default-small"
        end
      end
    end
  end
  ManagerController.refresh(player)
end

function ManagerController.onClick(event)
  local element = event.element
  if not element or not element.valid then return end
  local player = game.players[event.player_index]
  if not player then return end

  local name = element.name

  if name == "close_btn" then
    ManagerController.close(player)
    return
  elseif name == "refresh_btn" then
    ManagerController.refresh(player)
    return
  elseif name == "coords_toggle_btn" then
    ManagerController.showCoordsState[player.index] = not getShowCoords(player)
    ManagerController.refresh(player)
    return
  end

  -- Tab Switching
  local parent = element.parent
  if parent and parent.valid and parent.name == "tcs_tabs-buttons" then
    local contentFrame = parent.parent["tcs_tabs-content"]
    if contentFrame and contentFrame.valid then
      for _, flow in pairs(contentFrame.children) do
        if flow.valid then
          if flow.name == name then
            flow.visible = true
          else
            flow.visible = false
          end
        end
      end
      ManagerController.refresh(player)
    end
    return
  end

  -- Action Buttons
  if element.tags then
    local act = element.tags.action
    if act == "map" then
      local pos = {x = element.tags.pos_x, y = element.tags.pos_y}
      local surf = game.surfaces[element.tags.surface_index]
      if surf then
        pcall(function()
          player.set_controller{type = defines.controllers.remote, position = pos, surface = surf}
        end)
      end
    elseif act == "ping" then
      local pos = {x = element.tags.pos_x, y = element.tags.pos_y}
      local surf = game.surfaces[element.tags.surface_index]
      local ename = element.tags.ename or "Objekt"
      if surf then
        pcall(function()
          player.create_local_flying_text{text = "📍 Ping HIER!", position = pos, color = {r=1, g=0.9, b=0}}
          if rendering and rendering.draw_circle then
            rendering.draw_circle{
              color = {r=1, g=0.2, b=0, a=0.8},
              radius = 2.5,
              width = 4,
              target = pos,
              surface = surf,
              time_to_live = 300
            }
          end
          local gpsLink = string.format("[gps=%.1f,%.1f,%s]", pos.x, pos.y, surf.name)
          player.print("📍 Ping für " .. ename .. ": " .. gpsLink)
        end)
      end
    elseif act == "open_gui" then
      pcall(function()
        remote.call("trainConstructionSite", "open_entity_gui", player.index, element.tags.surface_index, element.tags.pos_x, element.tags.pos_y)
      end)
    elseif act == "open_rename" then
      local oldFrame = player.gui.screen["tcs_rename_frame"]
      if oldFrame then oldFrame.destroy() end

      local unum = element.tags.unit_number
      storage = storage or {}
      storage.customNames = storage.customNames or {}
      storage.customGroups = storage.customGroups or {}

      local oldN = storage.customNames[unum] or element.tags.default_name or ""
      local oldG = storage.customGroups[unum] or ""

      local rframe = player.gui.screen.add{
        type = "frame",
        name = "tcs_rename_frame",
        caption = "GUI Ordner & Name vergeben",
        direction = "vertical"
      }
      rframe.force_auto_center()

      local t = rframe.add{type="table", name="input_table", column_count=2}
      t.add{type="label", caption="Gruppe / Ordner:"}
      local gtxt = t.add{type="textfield", name="grp_input", text=oldG}
      
      t.add{type="label", caption="GUI Anzeigename:"}
      local ntxt = t.add{type="textfield", name="nam_input", text=oldN}
      gtxt.focus()

      local bflow = rframe.add{type="flow", direction="horizontal"}
      bflow.add{type="button", caption="✔ Speichern", tags={action="save_rename", unit_number=unum}}
      bflow.add{type="button", caption="✖ Zurücksetzen", tags={action="reset_rename", unit_number=unum}}
      bflow.add{type="button", caption="Abbrechen", tags={action="close_rename"}}
    elseif act == "save_rename" then
      local rframe = player.gui.screen["tcs_rename_frame"]
      if rframe and rframe.valid then
        local unum = element.tags.unit_number
        storage = storage or {}
        storage.customNames = storage.customNames or {}
        storage.customGroups = storage.customGroups or {}

        local t = rframe.input_table
        local g = t.grp_input.text
        local n = t.nam_input.text

        storage.customGroups[unum] = (g ~= "") and g or nil
        storage.customNames[unum] = (n ~= "") and n or nil

        rframe.destroy()
      end
      ManagerController.refresh(player)
    elseif act == "reset_rename" then
      local rframe = player.gui.screen["tcs_rename_frame"]
      if rframe and rframe.valid then
        local unum = element.tags.unit_number
        storage = storage or {}
        storage.customNames = storage.customNames or {}
        storage.customGroups = storage.customGroups or {}
        storage.customNames[unum] = nil
        storage.customGroups[unum] = nil
        rframe.destroy()
      end
      ManagerController.refresh(player)
    elseif act == "close_rename" then
      local rframe = player.gui.screen["tcs_rename_frame"]
      if rframe and rframe.valid then rframe.destroy() end
    end
  end
end

local function extractRecords(nestedTable)
  local res = {}
  for _, yMap in pairs(nestedTable or {}) do
    if type(yMap) == "table" then
      for _, xMap in pairs(yMap) do
        if type(xMap) == "table" then
          for _, rec in pairs(xMap) do
            if type(rec) == "table" and rec.entity and rec.entity.valid then
              table.insert(res, rec)
            end
          end
        end
      end
    end
  end
  return res
end

local function buildSortedList(records, defaultNamePrefix)
  local list = {}
  storage = storage or {}
  storage.customNames = storage.customNames or {}
  storage.customGroups = storage.customGroups or {}

  for _, rec in pairs(records) do
    local ent = rec.entity
    if ent and ent.valid then
      local unum = ent.unit_number or 0
      local defName = ent.backer_name or ent.name or defaultNamePrefix
      local cname = storage.customNames[unum]
      if not cname or cname == "" then
        cname = defName
      end
      
      local cgroup = storage.customGroups[unum]
      if not cgroup or cgroup == "" then
        cgroup = "📁 Allgemein / Standard"
      else
        cgroup = "📁 " .. cgroup
      end

      table.insert(list, {
        record = rec,
        entity = ent,
        unit_number = unum,
        default_name = defName,
        name = cname,
        group = cgroup
      })
    end
  end

  table.sort(list, function(a, b)
    if a.group ~= b.group then
      return a.group < b.group
    end
    return a.name < b.name
  end)

  return list
end

function ManagerController.refresh(player)
  if not remote.interfaces["trainConstructionSite"] or not remote.interfaces["trainConstructionSite"]["get_manager_data"] then
    return
  end

  local data = remote.call("trainConstructionSite", "get_manager_data")
  local root = player.gui.screen["tcs_manager_main_frame"]
  if not root or not root.valid then return end

  local showCoords = getShowCoords(player)
  local colCount = showCoords and 5 or 4

  local toggleBtn = root["header_flow"]["coords_toggle_btn"]
  if toggleBtn and toggleBtn.valid then
    toggleBtn.caption = showCoords and "📍 X/Y: AN" or "📍 X/Y: AUS"
  end

  local content = root["tcs_tabs"]["tcs_tabs-content"]

  -- 1. Depots
  local depScroll = content["tcs_tabsdepots"]["depots_scroll"]
  depScroll.clear()
  local depTable = depScroll.add{type="table", name="depots_table", column_count=colCount}
  
  depTable.add{type="label", caption={"tcs-manager.col-name"}, style="caption_label"}
  if showCoords then depTable.add{type="label", caption={"tcs-manager.col-location"}, style="caption_label"} end
  depTable.add{type="label", caption={"tcs-manager.col-status"}, style="caption_label"}
  depTable.add{type="label", caption={"tcs-manager.col-trains"}, style="caption_label"}
  depTable.add{type="label", caption={"tcs-manager.col-actions"}, style="caption_label"}

  local stats = data.TD_data and data.TD_data.depotStatistics or {}
  local depotRecords = extractRecords(data.TD_data and data.TD_data.depots)
  local depList = buildSortedList(depotRecords, "Depot")
  local curGroupDep = nil
  
  if #depList == 0 then
    depTable.add{type="label", caption={"tcs-manager.no-depots"}}
    for i=1, (colCount - 1) do depTable.add{type="label", caption=""} end
  else
    for _, item in pairs(depList) do
      if item.group ~= curGroupDep then
        curGroupDep = item.group
        depTable.add{type="label", caption=curGroupDep}
        for i=1, (colCount - 1) do depTable.add{type="label", caption=""} end
      end

      local ent = item.entity
      local pos = ent.position
      local sidx = ent.surface.index
      local posStr = string.format("X: %.0f, Y: %.0f", pos.x, pos.y)
      
      -- Exakte Zug-Zählung aus der Metatabelle
      local forceName = ent.force.name
      local statsMap = (((stats or {})[forceName] or {})[sidx] or {})[item.default_name] or {}
      local reqAmount = statsMap.requestAmount or statsMap.stationAmount or 0
      local trainsAtStop = ent.get_train_stop_trains()
      local tCount = trainsAtStop and #trainsAtStop or 0
      local trainStr = (reqAmount > 0) and string.format("%d / %d Züge", tCount, reqAmount) or tostring(tCount)
      
      depTable.add{type="label", caption="   └ " .. item.name}
      if showCoords then depTable.add{type="label", caption=posStr} end
      depTable.add{type="label", caption={"tcs-manager.status-ready"}}
      depTable.add{type="label", caption=trainStr}
      
      local actFlow = depTable.add{type="flow", direction="horizontal"}
      actFlow.add{type="button", caption="👁 Map", tooltip={"tcs-manager.btn-map"}, tags={action="map", surface_index=sidx, pos_x=pos.x, pos_y=pos.y}}
      actFlow.add{type="button", caption="📍 Ping", tooltip={"tcs-manager.btn-ping"}, tags={action="ping", surface_index=sidx, pos_x=pos.x, pos_y=pos.y, ename=item.name}}
      actFlow.add{type="button", caption="⚙ GUI", tooltip="Original Depot-GUI öffnen", tags={action="open_gui", surface_index=sidx, pos_x=pos.x, pos_y=pos.y}}
      actFlow.add{type="button", caption="✏ Tag", tooltip="GUI Ordner-Gruppe & Anzeigename vergeben", tags={action="open_rename", unit_number=item.unit_number, default_name=item.default_name}}
    end
  end

  -- 2. Builders
  local bldScroll = content["tcs_tabsbuilders"]["builders_scroll"]
  bldScroll.clear()
  local bldTable = bldScroll.add{type="table", name="builders_table", column_count=colCount}

  bldTable.add{type="label", caption={"tcs-manager.col-name"}, style="caption_label"}
  if showCoords then bldTable.add{type="label", caption={"tcs-manager.col-location"}, style="caption_label"} end
  bldTable.add{type="label", caption="Ziel-Depot", style="caption_label"}
  bldTable.add{type="label", caption={"tcs-manager.col-status"}, style="caption_label"}
  bldTable.add{type="label", caption={"tcs-manager.col-actions"}, style="caption_label"}

  local builderRecords = extractRecords(data.TC_data and data.TC_data.trainControllers)
  local bldList = buildSortedList(builderRecords, "Builder")
  local curGroupBld = nil

  if #bldList == 0 then
    bldTable.add{type="label", caption={"tcs-manager.no-builders"}}
    for i=1, (colCount - 1) do bldTable.add{type="label", caption=""} end
  else
    for _, item in pairs(bldList) do
      if item.group ~= curGroupBld then
        curGroupBld = item.group
        bldTable.add{type="label", caption=curGroupBld}
        for i=1, (colCount - 1) do bldTable.add{type="label", caption=""} end
      end

      local ent = item.entity
      local pos = ent.position
      local sidx = ent.surface.index
      local posStr = string.format("X: %.0f, Y: %.0f", pos.x, pos.y)
      
      -- Builder Status-Namen
      local stMap = { [1] = "Wartet auf Zug", [2] = "Baut Schienen", [3] = "Leerlauf / Bereit", [4] = "Dispatch" }
      local statusStr = stMap[item.record.controllerStatus] or "Aktiv"
      
      bldTable.add{type="label", caption="   └ " .. item.name}
      if showCoords then bldTable.add{type="label", caption=posStr} end
      bldTable.add{type="label", caption=item.default_name} -- Zeigt das versorgende Depot an!
      bldTable.add{type="label", caption=statusStr}
      
      local actFlow = bldTable.add{type="flow", direction="horizontal"}
      actFlow.add{type="button", caption="👁 Map", tooltip={"tcs-manager.btn-map"}, tags={action="map", surface_index=sidx, pos_x=pos.x, pos_y=pos.y}}
      actFlow.add{type="button", caption="📍 Ping", tooltip={"tcs-manager.btn-ping"}, tags={action="ping", surface_index=sidx, pos_x=pos.x, pos_y=pos.y, ename=item.name}}
      actFlow.add{type="button", caption="⚙ GUI", tooltip="Original Builder-GUI öffnen", tags={action="open_gui", surface_index=sidx, pos_x=pos.x, pos_y=pos.y}}
      actFlow.add{type="button", caption="✏ Tag", tooltip="GUI Ordner-Gruppe & Anzeigename vergeben", tags={action="open_rename", unit_number=item.unit_number, default_name=item.default_name}}
    end
  end

  -- 3. Assemblers
  local asmScroll = content["tcs_tabsassemblers"]["assemblers_scroll"]
  asmScroll.clear()
  local colCountAsm = showCoords and 4 or 3
  local asmTable = asmScroll.add{type="table", name="assemblers_table", column_count=colCountAsm}

  asmTable.add{type="label", caption={"tcs-manager.col-name"}, style="caption_label"}
  if showCoords then asmTable.add{type="label", caption={"tcs-manager.col-location"}, style="caption_label"} end
  asmTable.add{type="label", caption={"tcs-manager.col-status"}, style="caption_label"}
  asmTable.add{type="label", caption={"tcs-manager.col-actions"}, style="caption_label"}

  local asmRecords = extractRecords(data.TA_data and data.TA_data.trainAssemblers)
  local asmList = buildSortedList(asmRecords, "Zug-Werkstatt")
  local curGroupAsm = nil

  if #asmList == 0 then
    asmTable.add{type="label", caption={"tcs-manager.no-assemblers"}}
    for i=1, (colCountAsm - 1) do asmTable.add{type="label", caption=""} end
  else
    for _, item in pairs(asmList) do
      if item.group ~= curGroupAsm then
        curGroupAsm = item.group
        asmTable.add{type="label", caption=curGroupAsm}
        for i=1, (colCountAsm - 1) do asmTable.add{type="label", caption=""} end
      end

      local ent = item.entity
      local pos = ent.position
      local sidx = ent.surface.index
      local posStr = string.format("X: %.0f, Y: %.0f", pos.x, pos.y)
      local quality = tostring(item.record.pendingQuality or "normal")
      
      asmTable.add{type="label", caption="   └ " .. item.name}
      if showCoords then asmTable.add{type="label", caption=posStr} end
      asmTable.add{type="label", caption="Qualität: " .. quality}
      
      local actFlow = asmTable.add{type="flow", direction="horizontal"}
      actFlow.add{type="button", caption="👁 Map", tooltip={"tcs-manager.btn-map"}, tags={action="map", surface_index=sidx, pos_x=pos.x, pos_y=pos.y}}
      actFlow.add{type="button", caption="📍 Ping", tooltip={"tcs-manager.btn-ping"}, tags={action="ping", surface_index=sidx, pos_x=pos.x, pos_y=pos.y, ename=item.name}}
      actFlow.add{type="button", caption="⚙ GUI", tooltip="Original Assembler-GUI öffnen", tags={action="open_gui", surface_index=sidx, pos_x=pos.x, pos_y=pos.y}}
      actFlow.add{type="button", caption="✏ Tag", tooltip="GUI Ordner-Gruppe & Anzeigename vergeben", tags={action="open_rename", unit_number=item.unit_number, default_name=item.default_name}}
    end
  end
end

return ManagerController
