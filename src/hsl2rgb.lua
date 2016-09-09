local abs = require('math').abs
local rad = require('math').rad

return function(h, s, l, a)
  if (a == 0) then
    return 0, 0, 0, 0
  end

  -- find chroma
  local c = (1 - abs((l * 2) - 1)) * s

  -- add the same amount to each component to match lightness
  local m = l - (c / 2)

  h = h / rad(60)
  local x = c * (1 - abs(h % 2 - 1))
  if (h < 0) or (h >= 6) then -- undefined
    return 0 + m, 0 + m, 0 + m, a
  elseif (h < 1) then
    return c + m, x + m, 0 + m, a
  elseif (h < 2) then
    return x + m, c + m, 0 + m, a
  elseif (h < 3) then
    return 0 + m, c + m, x + m, a
  elseif (h < 4) then
    return 0 + m, x + m, c + m, a
  elseif (h < 5) then
    return x + m, 0 + m, c + m, a
  else -- (h < 6)
    return c + m, 0 + m, x + m, a
  end
end
