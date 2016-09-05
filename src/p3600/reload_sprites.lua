require 'p3600'

return function(entity)
  entity.spritesheet = {
    _no_save = true,
  }

  do
    local eo = {}
    local eu = {}
    local ew = {}

    for idx, item in ipairs(entity.inventory.wearing) do
      local itm = require('p3600.item.'..item.id)
      if (itm.equipment.armor) then
        if (itm.equipment.armor.over_hair) then
          eo[#eo + 1] = love.graphics.newImage(
           '/data/spritesheet/r/'..entity.race..'/equip/'..item.id..'/'..
           entity.sex..'.tga')
        else
          eu[#eu + 1] = love.graphics.newImage(
           '/data/spritesheet/r/'..entity.race..'/equip/'..item.id..'/'..
           entity.sex..'.tga')
        end
      elseif (itm.equipment.weapon) then
        ew[#ew + 1] = love.graphics.newImage(
         '/data/spritesheet/r/'..entity.race..'/equip/'..item.id..'/'..
         entity.sex..'.tga')
      end
    end

    entity.spritesheet.equip_over = eo
    entity.spritesheet.equip_under = eu
    entity.spritesheet.weapons = ew
  end

  if (entity.eid == 0) then
    local sn = '/save/'..entity.name..'/player/body.png'
    if (love.filesystem.exists(sn)) then
      entity.spritesheet.body = love.graphics.newImage(sn)
    else
      entity.spritesheet.body = love.graphics.newImage(
       '/data/spritesheet/r/'..entity.race..'/p/'..entity.sex..'/body.tga')
    end

    sn = '/save/'..entity.name..'/player/hair.png'
    if (love.filesystem.exists(sn)) then
      entity.spritesheet.hair = love.graphics.newImage(sn)
    else
      entity.spritesheet.hair = love.graphics.newImage(
       '/data/spritesheet/r/'..entity.race..'/p/'..entity.sex..'/hair.tga')
    end
  elseif (entity.special) then
    require('p3600.sp_entity.'..entity.eid..'.load_spritesheets')(entity)
  else
    entity.spritesheet.body = love.graphics.newImage(
     '/data/spritesheet/r/'..entity.race..'/body/'..entity.sex..'/'..
     entity.appearance.body_type..'.tga')
    entity.spritesheet.hair = love.graphics.newImage(
     '/data/spritesheet/r/'..entity.race..'/hair/'..entity.sex..'/'..
     entity.appearance.hair_type..'.tga')
  end

  entity.spritesheet.quad =
   love.graphics.newQuad(0, 0, 32, 32, 256, 256)
end
