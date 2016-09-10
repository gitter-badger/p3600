return function(x, y, tolerance, area)
  local abs = require('math').abs

  for i = 1, #p3600.gstate.entity, 1 do
    if (p3600.gstate.entity[i].pos.area == area) then
      if
       (abs(p3600.gstate.entity[i].pos.x - x) <= tolerance) and
       (abs(p3600.gstate.entity[i].pos.y - y) <= tolerance)
      then
        return p3600.gstate.entity[i]
      end
    end
  end

  return nil
end
