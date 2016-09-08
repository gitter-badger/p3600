return function()
  p3600.push_state()

  p3600.clear_love_callbacks()
  p3600.slowness = 0.1
  p3600.state = {
    r = p3600.state_stack.state.r,
    race = p3600.state_stack.state.race,
    changed = true,
  }

  p3600.keypressed = function(key)
    local tbl = {
      ['left'] = function()
        repeat
          if (p3600.state.race > 0) then
            p3600.state.race = p3600.state.race - 1
          else
            p3600.state.race = #p3600.state.r
          end
        until (p3600.state.r[p3600.state.race].playable)
        p3600.state.changed = true
      end,

      ['right'] = function()
        repeat
          if (p3600.state.race < #p3600.state.r) then
            p3600.state.race = p3600.state.race + 1
          else
            p3600.state.race = 0
          end
        until (p3600.state.r[p3600.state.race].playable)
        p3600.state.changed = true
      end,

      ['select'] = function()
        p3600.state_stack.state.race = p3600.state.race
        while
         not p3600.state.r[p3600.state.race].sexes[p3600.state_stack.state.sex]
        do
          p3600.state_stack.state.sex = p3600.state_stack.state.sex + 1
          if (p3600.state_stack.state.sex > 3) then
            p3600.state_stack.state.sex = 0
          end
        end
        p3600.pop_state()
      end,

      ['back'] = function()
        p3600.pop_state()
      end,
    }
    if not (p3600.kb.m[key] == nil) then
      if not (tbl[p3600.kb.m[key]] == nil) then
        tbl[p3600.kb.m[key]]()
      end
    end
  end

  p3600.draw = function()
    if (p3600.state.changed) then
      love.graphics.clear()
      local p = p3600.display.print
      p(1, 3, 'Race: '..p3600.state.r[p3600.state.race].singular)
      p(3, 1, p3600.state.r[p3600.state.race].description)
      p3600.display.changed = true
      p3600.state.changed = false
    end
  end
end
