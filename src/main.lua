function love.run()
  love.graphics.setDefaultFilter('nearest', 'nearest', 0)

  loadfile = love.filesystem.load -- seems like a good idea

  require('better_package')()

  -- set a handler for external libraries that don't require everything they use
  setmetatable(_G, {__index = require('package').loaded})

  -- LOVE provides some better versions of standard functions
  math.random = love.math.random

  if not (debug == nil) then
    debug.gcinfo = gcinfo
    debug.newproxy = newproxy
  end

  -- remove all unneeded global stuff
  bit = nil
  coroutine = nil
  debug = nil
  io = nil
  jit = nil
  math = nil
  os = nil
  string = nil
  table = nil

  gcinfo = nil -- undocumented = non-existant
  newproxy = nil -- also undocumented

  module = require('module') -- *drops mic*

  p3600 = require('p3600')

  do -- gc blacklist
    local package = require('package')

    package.gc_blacklist['sti'] = true -- not actually unsafe
  end

  do
    local os = require('os')
    love.math.setRandomSeed(os.time())
  end

  p3600.init()

  do
    local t = {
      modules = {},
      window = {},
    }
    love.conf(t)

    p3600.cfg = t.p3600

    p3600.kb = {
      w = t.p3600.keybinds.world,
      m = t.p3600.keybinds.menu,
    }
    p3600.cfg.keybinds = nil
  end

  p3600.main_menu.top()

  love.timer.step()

  arg = nil -- Can't do _this_ in C! (AFAIK)

  while true do
    if love.event then
      love.event.pump()
      for name, a,b,c,d,e,f in love.event.poll() do
        if name == 'quit' then
          if not love.quit or not love.quit() then
            return a
          end
        end
        love.handlers[name](a,b,c,d,e,f)
      end
    end

    love.timer.step()
    love.update(love.timer.getDelta())

    if (love.graphics.isActive()) then
      love.graphics.origin()

      love.draw()

      if (p3600.display.changed) then
        local a = true

        if not (love.window == nil) then
          a = love.window.isVisible()
        end

        if (a) then
          love.graphics.present()
        end

        p3600.display.changed = false
      end
    end

    love.timer.sleep(p3600.slowness)
    collectgarbage('step')
  end
end
