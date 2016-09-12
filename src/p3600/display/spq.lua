--[[
Returns a Quad for sprite (id) on a spritesheet.
If a sprite takes up more than one index, specify (size).
]]
return function(id, size)
  local math = require('math')

  size = size or 1
  local row = math.floor(id / 16)
  local col = id % 16
  return love.graphics.newQuad(col * 16, row * 16, 16 * size, 16 * size, 256,
                               256)
end
