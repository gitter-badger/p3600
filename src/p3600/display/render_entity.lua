return function(entity)
  local math = require('math')

  if not ((entity.pos.x) and (entity.pos.y)) then
    return
  end

  local qy = entity.dir
  local qx = 0

  if not (entity.walking == nil) then
    if (entity.walking.frame == 0) or (entity.walking.frame == 2) then
      qx = 0
    elseif (entity.walking.frame == 1) then
      qx = 1
    elseif (entity.walking.frame == 3) then
      qx = 2
    end
  end

  entity.spritesheet.quad:setViewport(qx * 16, qy * 16, 16, 16)

  love.graphics.draw(entity.spritesheet.body, entity.spritesheet.quad,
                     math.floor((entity.pos.x - 1) * 16),
                     math.floor((entity.pos.y - 1) * 16))

  if not (entity.spritesheet.equip_under == nil) then
    for i, s in ipairs(entity.spritesheet.equip_under) do
      love.graphics.draw(s, entity.spritesheet.quad,
                         math.floor((entity.pos.x - 1) * 16),
                         math.floor((entity.pos.y - 1) * 16))
    end
  end

  love.graphics.draw(entity.spritesheet.hair, entity.spritesheet.quad,
                     math.floor((entity.pos.x - 1) * 16),
                     math.floor((entity.pos.y - 1) * 16))

  if not (entity.spritesheet.equip_over == nil) then
    for i, s in ipairs(entity.spritesheet.equip_over) do
      love.graphics.draw(s, entity.spritesheet.quad,
                         math.floor((entity.pos.x - 1) * 16),
                         math.floor((entity.pos.y - 1) * 16))
    end
  end
end
