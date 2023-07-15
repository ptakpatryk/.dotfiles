local wezterm = require 'wezterm'
local mux = wezterm.mux

local c = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  c = wezterm.config_builder()
end

-- maximize on startup
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on('mux-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- This is where you actually apply your config choices
c.color_scheme = 'tokyonight_storm'
c.font = wezterm.font 'FiraCode Nerd Font'
c.font_size = 11
c.line_height = 1.1
c.font = wezterm.font 'FiraCode Nerd Font'
c.inactive_pane_hsb = {
  hue = 1,
  saturation = 0.7,
  brightness = 0.8,
}
c.window_background_opacity = 0.9
c.enable_scroll_bar = true
c.use_fancy_tab_bar = false
c.tab_bar_at_bottom = true
c.hide_tab_bar_if_only_one_tab = false
c.window_padding = {
  left = 0,
  bottom = 0,
  right = 0,
  top = 0,
}
c.window_close_confirmation = "NeverPrompt"
c.macos_window_background_blur = 40
--[[ c.default_workspace = "terminal" ]]

c.leader = { key = "b", mods = "CTRL" }
c.keys = {
  { key = "b", mods = "LEADER|CTRL",  action = wezterm.action { SendString = "\x01" } },
  { key = "-", mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "/", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "z", mods = "LEADER",       action = "TogglePaneZoomState" },
  { key = "c", mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
  { key = "h", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "j", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Down" } },
  { key = "k", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Up" } },
  { key = "l", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "H", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
  { key = "J", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
  { key = "K", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
  { key = "L", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
  { key = "1", mods = "LEADER",       action = wezterm.action { ActivateTab = 0 } },
  { key = "2", mods = "LEADER",       action = wezterm.action { ActivateTab = 1 } },
  { key = "3", mods = "LEADER",       action = wezterm.action { ActivateTab = 2 } },
  { key = "4", mods = "LEADER",       action = wezterm.action { ActivateTab = 3 } },
  { key = "5", mods = "LEADER",       action = wezterm.action { ActivateTab = 4 } },
  { key = "6", mods = "LEADER",       action = wezterm.action { ActivateTab = 5 } },
  { key = "7", mods = "LEADER",       action = wezterm.action { ActivateTab = 6 } },
  { key = "8", mods = "LEADER",       action = wezterm.action { ActivateTab = 7 } },
  { key = "9", mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
  { key = "&", mods = "LEADER|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
  { key = "x", mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
  { key = "n", mods = "LEADER",       action = wezterm.action { ActivateTabRelative = 1 } },
  { key = "p", mods = "LEADER",       action = wezterm.action { ActivateTabRelative = -1 } },
  --[[ { key = "t", mods = "LEADER",       action = wezterm.action { SwitchToWorkspace = {} } }, ]]
  { key = "s", mods = "LEADER",       action = wezterm.action { ShowLauncherArgs = { flags = "WORKSPACES" } } },
  { key = "m", mods = "LEADER",       action = wezterm.action { SwitchWorkspaceRelative = 1 } },
  { key = "[", mods = "LEADER",       action = wezterm.action { SwitchWorkspaceRelative = -1 } },
  { key = "a", mods = "LEADER",       action = "ShowTabNavigator" },
  --[[ { key = "c", mods = "CTRL",         action = wezterm.action { CopyTo = "Clipboard" } }, ]]
  --[[ { key = "v", mods = "CTRL",         action = wezterm.action { PasteFrom = "Clipboard" } } ]]
  -- Prompt for a name to use for a new workspace and switch to it.
  {
    key = "T",
    mods = "LEADER",
    action = wezterm.action.PromptInputLine { description = wezterm.format { { Attribute = { Intensity = 'Bold' } }, {
      Foreground = { AnsiColor = 'Fuchsia' } },
      { Text = 'Enter name for new workspace' },
    },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            wezterm.action.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },

}
-- and finally, return the configuration to wezterm
return c
