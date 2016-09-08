-- probably better ways to do this
return function()
  p3600.clear_love_callbacks()

  p3600.slowness = 0.5

  p3600.state = {
    frame = 0,
    prev_frame = -1,
    to_next_frame = 1.0,
    init_frame = function() -- declared here instead of every 0.5 seconds
      if (p3600.state.frame == 3) then
        require('p3600.area')('clearing', true)
      else
        p3600.state.to_next_frame = 1.0
      end
    end,
  }

  p3600.update = function(dt)
    p3600.state.to_next_frame = p3600.state.to_next_frame - dt
    if (p3600.state.to_next_frame <= 0) then
      p3600.state.frame = p3600.state.frame + 1
      p3600.state.init_frame()
    end
  end

  p3600.draw = function()
    if not (p3600.state.frame == p3600.state.prev_frame) then
      love.graphics.clear(love.graphics.getBackgroundColor())
      require('p3600.display.print')(8, 1,
                                     'frame #'..tostring(p3600.state.frame))
      p3600.display.changed = true
      p3600.state.prev_frame = p3600.state.frame
    end
  end
end
