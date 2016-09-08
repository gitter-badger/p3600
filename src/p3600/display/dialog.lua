return function(data)
  p3600.clear_love_callbacks()
  p3600.slowness = 0.1

  p3600.state = {
    text = data.text,
    choices = data.choices,
    selection = 1,
    changed = true,
    _p = require('p3600.display.print'),
  }

  if (p3600._dialog_buffer == nil) then
    p3600._dialog_buffer = p3600.display.buffer
    p3600.display.buffer = love.graphics.newCanvas(800, 600, 'rgb5a1', 0)
  end

  p3600.keypressed = function(key)
    local tbl = {
      ['up'] = function()
        if (p3600.state.selection > 1) then
          p3600.state.selection = p3600.state.selection - 1
          p3600.state.changed = true
        end
      end,

      ['down'] = function()
        if (p3600.state.selection < #p3600.state.choices) then
          p3600.state.selection = p3600.state.selection + 1
          p3600.state.changed = true
        end
      end,

      ['select'] = function()
        p3600.state.changed = true
        p3600.state.choices[p3600.state.selection].action()
      end,
    }
    tbl['right'] = tbl['select']
    if not (p3600.kb.m[key] == nil) then
      if not (tbl[p3600.kb.m[key]] == nil) then
        tbl[p3600.kb.m[key]]()
      end
    end
  end

  p3600.draw = function()
    if (p3600.state.changed) then
      love.graphics.clear()
      love.graphics.draw(p3600._dialog_buffer)
      local _p = p3600.state._p
      for y,t in pairs(p3600.state.text) do
        _p(14 + y, 1, t)
      end

      do
        local y = 16 + #p3600.state.text
        if (p3600.state.selection > 1) then
          _p(y, 4, p3600.state.choices[p3600.state.selection - 1].label)
        end
        _p(y + 1, 2, '> '..p3600.state.choices[p3600.state.selection].label)
        if (p3600.state.selection < #p3600.state.choices) then
          _p(y + 2, 4, p3600.state.choices[p3600.state.selection + 1].label)
        end
      end
      p3600.state.changed = false
      p3600.display.changed = true
    end
  end
end
