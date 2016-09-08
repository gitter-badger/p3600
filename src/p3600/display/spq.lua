--[[
Returns a Quad for sprite (id) on a spritesheet.
If a sprite takes up more than one index, specify (size).
]]
return function(id, size)
  local math = require('math')

  size = size or 1
  local row = math.floor(id / 8)
  local col = id % 8
  return love.graphics.newQuad(col * 32, row * 32, 32 * size, 32 * size, 256,
                               256)
end
