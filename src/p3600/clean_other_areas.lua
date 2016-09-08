return function(name)
  local table = require('table')

  for id = 1, #p3600.gstate.entity, 1 do
    ::removed::
    if not (p3600.gstate.entity[id] == nil) then
      if not (p3600.gstate.entity[id].pos.area == name) then
        if not (p3600.gstate.entity[id].persist) then
          table.remove(p3600.gstate.entity, id)
          goto removed
        end
      end
    end
  end
end
