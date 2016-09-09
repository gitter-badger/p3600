local abs = require('math').abs
local max = require('math').max
local min = require('math').min
local rad = require('math').rad

return function(r, g, b, a)
  if (a == 0) then
    return 0, 0, 0, 0
  end

  local M = max(r, g, b)
  local m = min(r, g, b)
  local c = M - m

  local h
  local s
  local l = (M + m) / 2

  if (c == 0) then
    h = 0 -- undefined
    s = 0
  else
    if (M == r) then
      h = rad(60) * (((g - b) / c) % 6)
    elseif (M == g) then
      h = rad(60) * (((b - r) / c) + 2)
    else -- (M == b)
      h = rad(60) * (((r - g) / c) + 4)
    end

    s = c / (1 - abs((l * 2) - 1))
  end

  return h, s, l, a
end
