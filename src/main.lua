function love.run()
  loadfile = love.filesystem.load

  require('better_package')()

  p3600 = require('p3600')

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
      e = t.p3600.keybinds.editor,
      w = t.p3600.keybinds.world,
      m = t.p3600.keybinds.menu,
    }
    p3600.cfg.keybinds = nil
  end

  if (arg[2] == 'editor') then
    p3600.editor.run(arg[3], true)
  else
    p3600.main_menu.top()
  end

  love.timer.step()

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
