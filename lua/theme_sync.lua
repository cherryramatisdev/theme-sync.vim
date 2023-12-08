local M = {}

function M.switch_theme()
  local theme = {'defaults', 'read', '-g', 'AppleInterfaceStyle'}

  if vim.g.theme_sync_get_theme_cmd then
    theme = vim.g.theme_sync_get_theme_cmd
  end

  local on_exit = function(obj)
    local isDarkMode = false
    if string.match(obj.stdout, "[Dd]ark") or string.match(obj.stderr, "[Dd]ark") then
      isDarkMode = true
    else
      isDarkMode = false
    end

    -- TODO: this is *really* hacky
    vim.defer_fn(function()
      if isDarkMode then
        vim.api.nvim_set_option('background', 'dark')
      else
        vim.api.nvim_set_option('background', 'light')
      end
    end, 0)
  end

  vim.system(theme, { text = true }, on_exit)
end

return M
