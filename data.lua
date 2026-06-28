data:extend({
  {
    type = "shortcut",
    name = "tcs-manager-shortcut",
    order = "b[train]-c[manager]",
    action = "lua",
    icon = "__trainConstructionSiteManager__/graphics/icons/tcs-manager-shortcut.png",
    icon_size = 256,
    small_icon = "__trainConstructionSiteManager__/graphics/icons/tcs-manager-shortcut-32.png",
    small_icon_size = 256,
    associated_control_input = "tcs-manager-toggle"
  },
  {
    type = "custom-input",
    name = "tcs-manager-toggle",
    key_sequence = "ALT + T",
    consuming = "none"
  }
})
