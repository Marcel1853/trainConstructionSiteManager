local ManagerLayout = {}

function ManagerLayout.create()
  local layout = FLib.gui.layout.create("screen")

  local rootFrame = FLib.gui.layout.addFrame(layout, "root", "tcs_manager_main_frame", "vertical", {
    caption = ""
  })

  -- Header Flow
  local headerFlow = FLib.gui.layout.addFlow(layout, rootFrame, "header_flow", "horizontal")
  FLib.gui.layout.addLabel(layout, headerFlow, "title", {
    caption = {"tcs-manager.title"}
  })
  FLib.gui.layout.addEmptyWidget(layout, headerFlow, "dragger", {
    drag_target = rootFrame,
    style = "draggable_space_header"
  })
  FLib.gui.layout.addButton(layout, headerFlow, "coords_toggle_btn", {
    caption = "📍 X/Y: AUS",
    tooltip = "Standort-Koordinaten (Spalte) ein- oder ausblenden"
  })
  FLib.gui.layout.addButton(layout, headerFlow, "refresh_btn", {
    caption = "↻",
    tooltip = {"tcs-manager.refresh"}
  })
  FLib.gui.layout.addButton(layout, headerFlow, "close_btn", {
    caption = "X",
    tooltip = {"tcs-manager.close"}
  })

  -- Tabs (3 Stück)
  local pages = {
    { name = "depots", caption = {"tcs-manager.tab-depots"}, selected = true },
    { name = "builders", caption = {"tcs-manager.tab-builders"} },
    { name = "assemblers", caption = {"tcs-manager.tab-assemblers"} }
  }

  local contentFrame = FLib.gui.layout.addTabs(layout, rootFrame, "tcs_tabs", pages, {
    tabInsideFrameStyle = "inside_shallow_frame",
    tabContentFrameStyle = "inside_shallow_frame",
    buttonStyle = "button",
    buttonSelectedStyle = "button"
  })

  -- Tab 1: Depots
  local depotsFlowPath = FLib.gui.layout.getTabContentFrameFlow(layout, contentFrame, 1)
  FLib.gui.layout.addScrollPane(layout, depotsFlowPath, "depots_scroll")

  -- Tab 2: Builders
  local buildersFlowPath = FLib.gui.layout.getTabContentFrameFlow(layout, contentFrame, 2)
  FLib.gui.layout.addScrollPane(layout, buildersFlowPath, "builders_scroll")

  -- Tab 3: Assemblers
  local assemblersFlowPath = FLib.gui.layout.getTabContentFrameFlow(layout, contentFrame, 3)
  FLib.gui.layout.addScrollPane(layout, assemblersFlowPath, "assemblers_scroll")

  return layout
end

return ManagerLayout
