local p3600 = {}
package.nogc[#package.nogc + 1] = p3600

p3600.state = {}

p3600.state_stack = {}

-- Sleep this many seconds every tick.
p3600.slowness = 0.001

p3600.display = {
  buffer = {},

  -- If true, screen will be redrawn.
  changed = true,

  -- Automatic values. Don't mess with these.
  width = 800,
  height = 600,
}

p3600.font = {}

p3600.sprite_refs = {}

function p3600.push_state()
  p3600.state_stack = {
    draw          = p3600.draw,
    focus         = p3600.focus,
    font          = p3600.font,
    has_textinput = love.keyboard.hasTextInput(),
    keypressed    = p3600.keypressed,
    keyreleased   = p3600.keyreleased,
    quit          = p3600.quit,
    resize        = p3600.resize,
    slowness      = p3600.slowness,
    state         = p3600.state,
    textinput     = p3600.textinput,
    update        = p3600.update,

    state_stack   = p3600.state_stack,
  }
end

function p3600.pop_state()
  if not (p3600.state._sprites_used == nil) then
    require('p3600.unuse_sprites')()
  end

  p3600.draw          = p3600.state_stack.draw
  p3600.focus         = p3600.state_stack.focus
  p3600.font          = p3600.state_stack.font
  p3600.keypressed    = p3600.state_stack.keypressed
  p3600.keyreleased   = p3600.state_stack.keyreleased
  p3600.quit          = p3600.state_stack.quit
  p3600.resize        = p3600.state_stack.resize
  p3600.slowness      = p3600.state_stack.slowness
  p3600.state         = p3600.state_stack.state
  p3600.textinput     = p3600.state_stack.textinput
  p3600.update        = p3600.state_stack.update

  love.keyboard.setTextInput(p3600.state_stack.has_textinput)

  p3600.state_stack = p3600.state_stack.state_stack

  love.graphics.setFont(p3600.font)

  p3600.display.changed = true
end

function p3600.init_state_stack()
  local endf = function()
    love.event.quit(0)
  end

  p3600.state_stack = {
    draw          = endf,
    focus         = endf,
    font          = p3600.font,
    has_textinput = false,
    keypressed    = endf,
    keyreleased   = endf,
    quit          = function()
    end,
    resize        = endf,
    slowness      = 0.1,
    state         = {},
    textinput     = endf,
    update        = endf,
    state_stack   = nil,
  }
end

function p3600.clear_love_callbacks()
  p3600.draw = function()
  end
  p3600.focus = function(f)
  end
  p3600.keypressed = function(key)
  end
  p3600.keyreleased = function(key)
  end
  p3600.quit = function()
  end
  p3600.resize = function(w, h)
  end
  p3600.textinput = function(text)
  end
  p3600.update = function(dt)
  end
end

-- p3600.control_down is called often, so use multiplication instead of division
function p3600.control_down(id, nest)
  for i, t in pairs(p3600.kb) do
    for k, v in pairs(t) do
      if (v == id) then
        if (love.keyboard.isDown(k)) then
          return true
        elseif (not nest) then
          if (p3600.control_down(k, true)) then
            return true
          end
        end
      end
    end
  end

  do
    local h = love.graphics.getHeight()
    local w = love.graphics.getWidth()

    if not (love.touch == nil) then
      local cx = w * 0.5
      local cy = h * 0.5

      for i, t in pairs(love.touch.getTouches()) do
        local x, y = love.touch.getPosition(t)
        if
         ((x > (cx + (cx * 0.5))) and (id == 'right')) or
         ((x < (cx - (cx * 0.5))) and (id == 'left')) or
         ((y > (cy + (cy * 0.5))) and (id == 'down')) or
         ((y < (cy - (cy * 0.5))) and (id == 'up'))
        then
          return true
        end
      end
    end

    if not (love.mouse == nil) then
      if (id:find('mouse', 1, true)) then
        local s, i = id:gsub('mouse', '', 1)
        return love.mouse.isDown(tonumber(s))
      end

      if (love.mouse.isDown(1)) then
        local cx = w * 0.5
        local cy = h * 0.5
        local x, y = love.mouse.getPosition()
        if
         ((x > (cx + (cx * 0.25))) and (id == 'right')) or
         ((x < (cx - (cx * 0.25))) and (id == 'left')) or
         ((y > (cy + (cy * 0.25))) and (id == 'down')) or
         ((y < (cy - (cy * 0.25))) and (id == 'up'))
        then
          return true
        end
      end
    end
  end

  if not (love.joystick == nil) then
    for i, j in pairs(love.joystick.getJoysticks()) do
      for h = 1, j:getHatCount(), 1 do
        local d = j:getHat(h)
        if
         ((id == 'right') and (d:find('r', 1, true))) or
         ((id == 'left') and (d:find('l', 1, true))) or
         ((id == 'down') and (d:find('d', 1, true))) or
         ((id == 'up') and (d:find('u', 1, true)))
        then
          return true
        end
      end
    end
  end

  return false
end

function p3600.init()
  p3600.clear_love_callbacks()

  love.draw = function()
    love.graphics.setCanvas(p3600.display.buffer)
    p3600.draw()
    love.graphics.setCanvas()
    if (p3600.display.changed) then
      love.graphics.clear(love.graphics.getBackgroundColor())
      local ratio_w = p3600.display.width / 800
      local ratio_h = p3600.display.height / 600
      local ratio = 0
      if (ratio_w < ratio_h) then
        ratio = ratio_w
      else
        ratio = ratio_h
      end
      love.graphics.translate((p3600.display.width  / 2) - ((800 * ratio) / 2),
                              (p3600.display.height / 2) - ((600 * ratio) / 2))
      love.graphics.scale(ratio)
      love.graphics.draw(p3600.display.buffer)
    end
  end

  love.focus = function(f)
    p3600.focus(f)
    if (f) then
      p3600.display.changed = true
    end
  end

  love.keypressed = function(key)
    p3600.keypressed(key)
  end

  love.keyreleased = function(key)
    p3600.keyreleased(key)
  end

  love.mousepressed = function(x, y, button, istouch)
    local cy = love.graphics.getHeight() / 2
    local cx = love.graphics.getWidth() / 2

    love.event.push('keypressed', 'mouse'..button)

    if (button == 1) then
      if (x > (cx + (cx / 4))) then
        love.event.push('keypressed', 'right')
      end

      if (x < (cx - (cx / 4))) then
        love.event.push('keypressed', 'left')
      end

      if (y > (cy + (cy / 4))) then
        love.event.push('keypressed', 'down')
      end

      if (y < (cy - (cy / 4))) then
        love.event.push('keypressed', 'up')
      end
    end
  end

  love.mousereleased = function(x, y, button, istouch)
    local cy = love.graphics.getHeight() / 2
    local cx = love.graphics.getWidth() / 2

    love.event.push('keyreleased', 'mouse'..button)

    if (button == 1) then
      if (x > (cx + (cx / 4))) then
        love.event.push('keyreleased', 'right')
      end

      if (x < (cx - (cx / 4))) then
        love.event.push('keyreleased', 'left')
      end

      if (y > (cy + (cy / 4))) then
        love.event.push('keyreleased', 'down')
      end

      if (y < (cy - (cy / 4))) then
        love.event.push('keyreleased', 'up')
      end
    end
  end

  love.quit = function()
    p3600.quit()
  end

  love.resize = function(w, h)
    p3600.display.width = w
    p3600.display.height = h
    p3600.resize(w, h)
    p3600.display.changed = true
  end

  love.textinput = function(text)
    p3600.textinput(text)
  end

  love.update = function(dt)
    p3600.update(dt)
  end

  p3600.display.buffer = love.graphics.newCanvas(800, 600, 'rgb5a1', 0)

  p3600.font = love.graphics.newImageFont('/data/font.tga',
   ' 1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz`~!@#$%^'..
   '&*()-_=+[{]}\\|;:\'",<.>/?', 0)
  love.graphics.setFont(p3600.font)

  love.keyboard.setTextInput(false)

  p3600.init_state_stack()

  p3600.init = nil -- not needed anymore
end

return p3600
