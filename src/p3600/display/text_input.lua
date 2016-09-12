--[[
Reads a line of text, displaying the cursor at (line, column).
Calls setstr(str), where str is the string that was read.

If initial_string is passed, that is what the buffer starts with.

Does not modify the state. (setstr can modify the current state)
Uses p3600.{push,pop}_state to change love callbacks only.
]]
return function(line, column, setstr, initial_string, bg)
  p3600.push_state()
  p3600.slowness = 0.1
  p3600.clear_love_callbacks()

  p3600.text_input_r = line
  p3600.text_input_c = column
  p3600.text_input_bg = bg
  p3600.text_input_is = initial_string or ''
  p3600.text_input_buffer = initial_string or ''
  p3600.text_input_buffer_changed = true
  p3600.text_input_buffer_max_sz = #p3600.text_input_buffer
  p3600.text_input_setstr = setstr
  p3600.text_input_old_buffer = p3600.display.buffer
  p3600.display.buffer = love.graphics.newCanvas(320, 240, 'rgb5a1', 0)

  love.keyboard.setTextInput(true)

  p3600.textinput = function(text)
    p3600.text_input_buffer = p3600.text_input_buffer..text
    p3600.text_input_buffer_changed = true
  end

  p3600.keypressed = function(key)
    local tbl = {
      ['backspace'] = function()
        local utf8 = require('utf8')
        local string = require('string')
        local offs = utf8.offset(p3600.text_input_buffer, -1)
        if (offs) then
          p3600.text_input_buffer = string.sub(p3600.text_input_buffer,
                                               1, offs - 1)
          p3600.text_input_buffer_changed = true
          if (#p3600.text_input_buffer > p3600.text_input_buffer_max_sz) then
            p3600.text_input_buffer_max_sz = #p3600.text_input_buffer
          end
        end
      end,

      ['return'] = function()
        p3600.display.buffer = p3600.text_input_old_buffer
        p3600.text_input_setstr(p3600.text_input_buffer)

        p3600.text_input_r = nil
        p3600.text_input_is = nil
        p3600.text_input_c = nil
        p3600.text_input_buffer = nil
        p3600.text_input_buffer_changed = nil
        p3600.text_input_setstr = nil
        p3600.text_input_old_buffer = nil
        p3600.text_input_bg = nil
        p3600.text_input_buffer_max_sz = nil

        local s = p3600.state
        p3600.pop_state()
        p3600.state = s
      end,

      ['escape'] = function()
        p3600.display.buffer = p3600.text_input_old_buffer
        p3600.text_input_setstr(p3600.text_input_is)
        p3600.text_input_is = nil
        p3600.text_input_r = nil
        p3600.text_input_c = nil
        p3600.text_input_buffer = nil
        p3600.text_input_buffer_changed = nil
        p3600.text_input_setstr = nil
        p3600.text_input_old_buffer = nil
        p3600.text_input_bg = nil
        p3600.text_input_buffer_max_sz = nil
        local s = p3600.state
        p3600.pop_state()
        p3600.state = s
      end,
    }
    if not (tbl[key] == nil) then
      tbl[key]()
    end
  end

  p3600.draw = function()
    if (p3600.text_input_buffer_changed) then
      love.graphics.clear()
      love.graphics.draw(p3600.text_input_old_buffer)
      if not (p3600.text_input_bg == nil) then
        local r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(p3600.text_input_bg.r, p3600.text_input_bg.g,
                               p3600.text_input_bg.b, p3600.text_input_bg.a)
        love.graphics.rectangle('fill', p3600.text_input_c * 8,
                                p3600.text_input_r * 8,
                                p3600.text_input_buffer_max_sz * 8, 8)
        love.graphics.setColor(r, g, b, a)
      end
      p3600.display.print(p3600.text_input_r, p3600.text_input_c,
                          p3600.text_input_buffer)
      p3600.text_input_buffer_changed = false
      p3600.display.changed = true
    end
  end
end
