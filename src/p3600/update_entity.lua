require 'p3600'

return function(eid, v, dt)
  if (eid == 0) then
    return
  end

  if (v.special) then
    if (require('p3600.sp_entity.'..eid..'.update')(dt)) then
      return
    end
  end

  local is_walking = false
  local just_started_walking = false
  local delta_x = 0
  local delta_y = 0

  if not (v.following == nil) then
    local fx = math.floor(p3600.gstate.entity[v.following.id].pos.x)
    local fy = math.floor(p3600.gstate.entity[v.following.id].pos.y)

    if
     (math.abs(v.pos.x - fx) > v.following.distance) or
     (math.abs(v.pos.y - fy) > v.following.distance)
    then
      local path

      ::tryfollow::
      if not (v.following.prev == nil) then
        if (v.following.prev.dx == fx) and (v.following.prev.dy == fy) then
          path = v.following.prev.p
        else
          v.following.prev = nil
          if
           ((v.pos.x - math.floor(v.pos.x)) <
            (math.floor(v.pos.x + 1) - v.pos.x))
          then
            v.pos.x = math.floor(v.pos.x)
          else
            v.pos.x = math.floor(v.pos.x) + 1
          end
          if
           ((v.pos.y - math.floor(v.pos.y)) <
            (math.floor(v.pos.y + 1) - v.pos.y))
          then
            v.pos.y = math.floor(v.pos.y)
          else
            v.pos.y = math.floor(v.pos.y) + 1
          end
          goto tryfollow
        end
      else
        path = require('p3600.pathfinder')(p3600.state.map.tiletype,
                                           math.floor(v.pos.x),
                                           math.floor(v.pos.y), fx, fy)

        v.following.prev = {
          _no_save = true,
          dx = fx,
          dy = fy,
          p = path,
        }
      end

      ::next_node::
      if not (path == nil) then
        local vx = v.pos.x
        local vy = v.pos.y

        if not (tostring(vx) == tostring(path[1].x)) then
          delta_x = path[1].x - vx
          is_walking = true
        elseif not (tostring(vy) == tostring(path[1].y)) then
          delta_y = path[1].y - vy
          is_walking = true
        else
          table.remove(path, 1)
          if (path[1] == nil) then
            path = nil
            v.following.prev = nil
          end
          goto next_node
        end
      end
    end
  end

  do -- movement
    local speed = (0.05 * v.speed_mod) * 2
    local frame_time = (speed * 6) / 2

    if (is_walking) and (v.walking == nil) then
      v.walking = {
        frame = 1,
        next_frame = (speed * 6),
      }
      just_started_walking = true
    end

    if (v.can_move) then
      if (delta_y < 0) then
        if (math.abs(delta_y) < speed) then
          v.pos.y = v.pos.y + delta_y
        else
          if not (delta_x == 0) then
            v.pos.y = v.pos.y - (speed / 2)
          else
            v.pos.y = v.pos.y - speed
          end
          v.dir = 2
        end
        p3600.state.changed = true
      elseif (delta_y > 0) then
        if (math.abs(delta_y) < speed) then
          v.pos.y = v.pos.y + delta_y
        else
          if not (delta_x == 0) then
            v.pos.y = v.pos.y + (speed / 2)
          else
            v.pos.y = v.pos.y + speed
          end
          v.dir = 0
        end
        p3600.state.changed = true
      end

      if (delta_x < 0) then
        if (math.abs(delta_x) < speed) then
          v.pos.x = v.pos.x + delta_x
        else
          if not (delta_y == 0) then
            v.pos.x = v.pos.x - (speed / 2)
          else
            v.pos.x = v.pos.x - speed
          end
          v.dir = 1
        end
        p3600.state.changed = true
      elseif (delta_x > 0) then
        if (math.abs(delta_x) < speed) then
          v.pos.x = v.pos.x + delta_x
        else
          if not (delta_y == 0) then
            v.pos.x = v.pos.x + (speed / 2)
          else
            v.pos.x = v.pos.x + speed
          end
          v.dir = 3
        end
        p3600.state.changed = true
      end
    end

    if (is_walking) then
      if not (just_started_walking) then
        v.walking.next_frame = v.walking.next_frame - dt
        if (v.walking.next_frame <= 0) then
          v.walking.next_frame = frame_time
          v.walking.frame = v.walking.frame + 1
          if (v.walking.frame > 3) then
            v.walking.frame = 0
          end
          p3600.state.changed = true
        end
      end
    else
      v.walking = nil
      p3600.state.changed = true
    end
  end
end
