-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.keys = {
  -- This will create a new split and run your default program inside it
  {
    key = '-',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '\\',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 't',
    mods = 'CMD|SHIFT',
    action = wezterm.action_callback(function(win, pane)
      local tab, window = pane:move_to_new_tab()
    end),
  },
}

config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14.0
config.initial_rows = 48
config.initial_cols = 160

config.use_fancy_tab_bar = true 
config.tab_bar_at_bottom = false 
config.window_decorations = "INTEGRATED_BUTTONS"


-- Function to determine the color scheme based on appearance
local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Cobalt2" -- Replace with your preferred dark scheme
	else
		return 'Tokyo Night Day' -- Replace with your preferred light scheme
	end
end

-- Reload the configuration when the system appearance changes
wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)

	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)


local known_shells = {
  pwsh = true, powershell = true, cmd = true,
  bash = true, zsh = true, fish = true,
  sh = true, csh = true, tcsh = true,
  nu = true, elvish = true, xonsh = true,
}

local function basename(path)
  return path:gsub('(.*[/\\])(.*)', '%2'):gsub('[%.][eE][xX][eE]$', '')
end

local function ternary(a, b)
  if a and a ~= '' then
    return a
  end
  return b
end

local function get_title(tab, foreground)
  -- Figure out what title to show
  local pane = tab.active_pane
  local raw_title = tab.tab_title
  local ran_cmd = pane.user_vars.WEZTERM_CMD or ''
  local pane_title = pane.title
  local base_pane_title = basename(pane_title)
  local is_shell = base_pane_title ~= '' and known_shells[base_pane_title]
  local proc_name = basename(pane.foreground_process_name)
  if raw_title == '' then
    if pane_title == '' then
      raw_title = ternary(ran_cmd, proc_name)
    elseif ran_cmd == '' then
      if is_shell then
        raw_title = ternary(proc_name, base_pane_title)
      else
        raw_title = ternary(pane_title, proc_name)
      end
    else
      if is_shell then
        raw_title = ternary(ran_cmd, base_pane_title)
      else
        raw_title = ternary(pane_title, ran_cmd)
      end
    end
  end
  if raw_title == '' then
    raw_title = ternary(proc_name, basename(os.getenv('WEZTERM_EXECUTABLE')))
  else
    raw_title = raw_title:gsub('[%.][eE][xX][eE]$', '')
  end

  -- If there is progress, show that as well
  return get_progress(pane, raw_title, foreground)
end

-- and finally, return the configuration to wezterm
return config