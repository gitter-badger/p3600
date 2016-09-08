return function(_e)
  local math = require('math')

  do -- entities
    local x = _e.pos.x
    local y = _e.pos.y
    local ae

    if not (p3600.state.active_entities == nil) then
      ae = p3600.state.active_entities
    else
      ae = p3600.get_entities_in_area(entity.pos.area)
    end

    for i, e in pairs(ae) do
      if not (e == _e) then
        if (math.abs(y - e.pos.y) < 1) and (math.abs(x - e.pos.x) < 1) then
          return 'obstacle'
        end
      end
    end
  end

  -- map
  local f
  f = function(entity, recurse)
    local x = math.floor(entity.pos.x)
    local y = math.floor(entity.pos.y)

    local valid = false

    if (recurse == 0) then
      valid = true
    else
      local x_inc = (math.floor(entity.pos.x + 0.9) > x)
      local y_inc = (math.floor(entity.pos.y + 0.9) > y)

      if (recurse == 1) then
        if (x_inc) then
          x = x + 1
          valid = true
        end
      elseif (recurse == 2) then
        if (y_inc) then
          y = y + 1
          valid = true
        end
      else
        if (x_inc and y_inc) then
          x = x + 1
          y = y + 1
          valid = true
        end
      end
    end

    if (valid) then
      local tiletype

      if not (p3600.state.map == nil) then
        tiletype = p3600.state.map.tiletype
      else
        tiletype = p3600.area[entity.pos.area].data.tiletypes
      end

      if (tiletype[y][x] == 1) then
        return 'obstacle'
      end
    end

    if (recurse < 3) then
      return f(entity, recurse + 1)
    else
      return nil
    end
  end

  return f(_e, 0)
end
