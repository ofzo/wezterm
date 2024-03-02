-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font_with_fallback({
	-- brew install font-cascadia-mono-nf
	{ family = "Cascadia Mono NF", weight = 400 },
	{ family = "PingFang SC" },
})
config.dpi = 192
config.use_cap_height_to_scale_fallback_fonts = true
config.font_size = 12
config.line_height = 1.6
config.underline_position = -10
-- For example, changing the color scheme:
-- config.color_scheme = 'Heetch Light (base16) '

config.default_cwd = wezterm.home_dir .. "/codespace"
config.initial_cols = 140
config.initial_rows = 30
config.cursor_thickness = "3px"
config.default_cursor_style = "BlinkingBar"

-- config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = false

-- config.macos_window_background_blur = 20
-- config.window_background_opacity = 1

config.front_end = "WebGpu"
config.colors = {
	foreground = "black",
	background = "white",
	-- Overrides the cell background color when the current cell is occupied by the
	-- cursor and the cursor style is set to Block
	cursor_bg = "#52ad70",
	-- Overrides the text color when the current cell is occupied by the cursor
	cursor_fg = "black",
	-- Specifies the border color of the cursor when the cursor style is set to Block,
	-- or the color of the vertical or horizontal bar when the cursor style is set to
	-- Bar or Underline.
	cursor_border = "#52ad70",

	-- the foreground color of selected text
	selection_fg = "black",
	-- the background color of selected text
	selection_bg = "#fffacd",

	-- The color of the scrollbar "thumb"; the portion that represents the current viewport
	scrollbar_thumb = "#222222",

	-- The color of the split lines between panes
	split = "#f5f5f5",

	ansi = {
		"black", -- Black
		"#991b1b", -- Red
		"#166534", -- Green
		"#854d0e", -- Yellow
		"#1d4ed8", -- Blue
		"#6b21a8", -- Magenta
		"#0369a1", -- Cyan
		"white", -- White
	},
	brights = {
		"#9ca3af", -- Black
		"#ef4444", -- Red
		"#16a34a", -- Green
		"#eab308", -- Yellow
		"#0ea5e9", -- Blue
		"#d946ef", -- Magenta
		"#06b6d4", -- Cyan
		"white", -- White
	},

	-- Arbitrary colors of the palette in the range from 16 to 255
	-- indexed = { [136] = '#af8700' },

	-- Since: 20220319-142410-0fcdea07
	-- When the IME, a dead key or a leader key are being processed and are effectively
	-- holding input pending the result of input composition, change the cursor
	-- to this color to give a visual cue about the compose state.
	compose_cursor = "orange",

	-- Colors for copy_mode and quick_select
	-- available since: 20220807-113146-c2fee766
	-- In copy_mode, the color of the active text is:
	-- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
	-- 2. selection_* otherwise
	-- copy_mode_active_highlight_bg = { Color = '#000000' },
	-- use `AnsiColor` to specify one of the ansi color palette values
	-- (index 0-15) using one of the names "Black", "Maroon", "Green",
	--  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
	-- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
	copy_mode_active_highlight_fg = { AnsiColor = "Black" },
	copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
	copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

	quick_select_label_bg = { Color = "peru" },
	quick_select_label_fg = { Color = "#ffffff" },
	quick_select_match_bg = { AnsiColor = "Navy" },
	quick_select_match_fg = { Color = "#ffffff" },
}

config.window_padding = {
	left = "2pt",
	right = "0",
	top = "0",
	bottom = "0",
}
config.window_frame = {
	inactive_titlebar_bg = "#353535",
	active_titlebar_bg = "#ffffff",
	inactive_titlebar_fg = "#cccccc",
	active_titlebar_fg = "#ffffff",
}

config.command_palette_bg_color = "white"
config.command_palette_fg_color = "#111827"
config.command_palette_font_size = 10
config.command_palette_rows = 20

config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{
		key = "Enter",
		mods = "SUPER",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "D",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "k",
		mods = "SUPER",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
	{
		key = "p",
		mods = "SUPER",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "LeftArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "SUPER",
		action = wezterm.action.ActivatePaneByIndex(i - 1),
	})
	-- F1 through F8 to activate that tab
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = wezterm.action.ActivateTab(i - 1),
	})
end

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	return ""
end)
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- and finally, return the configuration to wezterm
return config
