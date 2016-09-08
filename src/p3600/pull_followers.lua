return function(eid, x, y)
  local followers = p3600.gstate.entity[eid].followers
  if not (followers == nil) then
    for i, e in pairs(followers) do
      if not
       (p3600.gstate.entity[e].pos.area == p3600.gstate.entity[eid].pos.area)
      then
        p3600.gstate.entity[e].pos = {
          x = x,
          y = y,
          area = p3600.gstate.entity[0].pos.area,
        }
      end
    end
  end
end
