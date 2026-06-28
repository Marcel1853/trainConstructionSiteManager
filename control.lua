---@diagnostic disable: undefined-field

require("__FactoryLib__/FactoryLib")
local ManagerController = require("src.gui.manager-controller")

script.on_init(function()
  storage = storage or {}
  storage.customNames = {}
  storage.customGroups = {}
end)

script.on_event(defines.events.on_lua_shortcut, function(event)
  if event.prototype_name == "tcs-manager-shortcut" then
    local player = game.players[event.player_index]
    if player then
      ManagerController.toggle(player)
    end
  end
end)

script.on_event("tcs-manager-toggle", function(event)
  ---@cast event {player_index: uint}
  local player = game.players[event.player_index]
  if player then
    ManagerController.toggle(player)
  end
end)

script.on_event(defines.events.on_gui_click, function(event)
  ManagerController.onClick(event)
end)

script.on_event(defines.events.on_gui_closed, function(event)
  local elem = event.element
  if elem and elem.valid then
    if elem.name == "tcs_manager_main_frame" then
      local player = game.players[event.player_index]
      if player then ManagerController.close(player) end
    elseif elem.name == "tcs_rename_frame" then
      elem.destroy()
      local player = game.players[event.player_index]
      if player then
        local mainGui = player.gui.screen["tcs_manager_main_frame"]
        if mainGui and mainGui.valid then player.opened = mainGui end
      end
    end
  end
end)
