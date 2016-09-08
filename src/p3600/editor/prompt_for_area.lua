return function()
  p3600.push_state()
  p3600.clear_love_callbacks()

  p3600.state = {
    drawn = false,
    done = false,
  }

  p3600.slowness = 0.1

  p3600.draw = function()
    if (p3600.state.done) then
      return
    else
      love.graphics.clear()
      p3600.display.print(5, 5, 'Enter area: ')
      p3600.display.print(3, 6, '(leave blank for list)')
      p3600.state.drawn = true
      p3600.display.changed = true
    end
  end

  p3600.update = function(dt)
    if (p3600.state.done) then
      p3600.pop_state()
    elseif (p3600.state.list) then
      local areas = love.filesystem.getDirectoryItems('/p3600/area')
      local m = {}
      local load_area = function()
        local n = p3600.state.menu_items[p3600.state.selection].label
        p3600.pop_state()
        p3600.state.name = n
        p3600.state.map = loadfile('/p3600/area/'..n..'/data.lua')()
      end
      for i,n in pairs(areas) do
        if not ((n == 'init.lua') or (n == 'enter.lua')) then
          m[i] = {
            label = n,
            action = load_area,
          }
        end
      end
      p3600.display.menu(m)
    elseif (p3600.state.drawn) then
      local f = function(s)
        if (s == '') then
          p3600.state.list = true
        else
          p3600.state_stack.state_stack.state.name = s
          p3600.state_stack.state_stack.state.map =
           loadfile('/p3600/area/'..s..'/data.lua')()
          p3600.state.done = true
        end
      end
      p3600.display.text_input(5, 17, f, '', {r = 0, b = 0, g = 0})
    end
  end
end
