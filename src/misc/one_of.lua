return function(v, ...)
  local l = select('#', ...)
  for i = 1, l, 1 do
    local n = select(i, ...)
    if (v == n) then
      return true
    end
  end
  return false
end
