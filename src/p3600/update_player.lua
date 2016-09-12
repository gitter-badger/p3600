return function(dt)
  local pc = p3600.gstate.entity[0]

  do -- movement
    local speed
    local frame_time

    if (p3600.cfg.invert_run) then
      speed = (0.05 * pc.speed_mod) * 2
      frame_time = (speed * 6) / 2
      if (p3600.control_down('run')) then
        speed = speed / 2
        frame_time = frame_time * 2
      end
    else
      speed = 0.05 * pc.speed_mod
      frame_time = speed * 6
      if (p3600.control_down('run')) then
        speed = speed * 2
        frame_time = frame_time / 2
      end
    end

    local is_walking = false
    local just_started_walking = false

    if (pc.can_move) then
      local function start_walking()
        pc.walking = {
          frame = 1,
          next_frame = (speed * 6),
        }
        just_started_walking = true
      end

      if (p3600.control_down('up')) then
        if (p3600.control_down('left')) or
           (p3600.control_down('right'))
        then
          pc.pos.y = pc.pos.y - (speed / 2)
          if (p3600.collision(pc).obstacle) then
            pc.pos.y = pc.pos.y + (speed / 2)
          end
        else
          pc.pos.y = pc.pos.y - speed
          if (p3600.collision(pc).obstacle) then
            pc.pos.y = pc.pos.y + speed
          end
        end
        is_walking = true
        pc.dir = 2
        if (pc.walking == nil) then
          start_walking()
        end
        p3600.state.changed = true
      end

      if (p3600.control_down('down')) then
        if (p3600.control_down('left')) or
           (p3600.control_down('right'))
        then
          pc.pos.y = pc.pos.y + (speed / 2)
          if (p3600.collision(pc).obstacle) then
            pc.pos.y = pc.pos.y - (speed / 2)
          end
        else
          pc.pos.y = pc.pos.y + speed
          if (p3600.collision(pc).obstacle) then
            pc.pos.y = pc.pos.y - speed
          end
        end
        is_walking = true
        pc.dir = 0
        if (pc.walking == nil) then
          start_walking()
        end
        p3600.state.changed = true
      end

      if (p3600.control_down('left')) then
        is_walking = true
        if (p3600.control_down('up')) or (p3600.control_down('down')) then
          pc.pos.x = pc.pos.x - (speed / 2)
          if (p3600.collision(pc).obstacle) then
            pc.pos.x = pc.pos.x + (speed / 2)
          end
        else
          pc.pos.x = pc.pos.x - speed
          if (p3600.collision(pc).obstacle) then
            pc.pos.x = pc.pos.x + speed
          end
        end
        if (pc.walking == nil) then
          start_walking()
        end
        pc.dir = 1
        p3600.state.changed = true
      end

      if (p3600.control_down('right')) then
        is_walking = true
        if (p3600.control_down('up')) or
           (p3600.control_down('down'))
        then
          pc.pos.x = pc.pos.x + (speed / 2)
          if (p3600.collision(pc).obstacle) then
            pc.pos.x = pc.pos.x - (speed / 2)
          end
        else
          pc.pos.x = pc.pos.x + speed
          if (p3600.collision(pc).obstacle) then
            pc.pos.x = pc.pos.x - speed
          end
        end
        pc.dir = 3
        if (pc.walking == nil) then
          start_walking()
        end
        p3600.state.changed = true
      end
    end

    if (is_walking) then
      if not (just_started_walking) then
        pc.walking.next_frame = pc.walking.next_frame - dt
        if (pc.walking.next_frame <= 0) then
          pc.walking.next_frame = frame_time
          pc.walking.frame = pc.walking.frame + 1
          if (pc.walking.frame > 3) then
            pc.walking.frame = 0
          end
          p3600.state.changed = true
        end
      end
    else
      pc.walking = nil
      p3600.state.changed = true
    end
  end
end
