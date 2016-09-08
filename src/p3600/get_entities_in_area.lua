return function(area)
  local r = {}

  for eid, v in pairs(p3600.gstate.entity) do
    if (v.pos.area == area) then
      r[eid] = v
    end
  end

  return r
end
