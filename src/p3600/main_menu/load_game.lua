return function()
  local files = love.filesystem.getDirectoryItems('/save')

  if (#files == 0) then
    p3600.state.menu_items[p3600.state.selection].label = '(no saves)'
    return
  end

  p3600.push_state()

  local load_file = function()
    local n = '/save/'..p3600.state.menu_items[p3600.state.selection].label
    p3600.pop_state()
    p3600.load_game(n)
  end

  local m = {
    back = function()
      p3600.pop_state()
    end,
  }

  for i,f in pairs(files) do
    m[i] = {
      label = f,
      action = load_file,
    }
  end

  p3600.display.menu(m)
end
