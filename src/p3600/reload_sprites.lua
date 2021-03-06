local hsl2rgb = require('hsl2rgb')
local rgb2hsl = require('rgb2hsl')

return function(entity)
  entity.spritesheet = {
    _no_save = true,
  }

  do
    local eo = {}
    local eu = {}
    local ew = {}

    for idx, item in ipairs(entity.inventory.wearing) do
      local itm = item.data
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
      entity.spritesheet.hair = love.image.newImageData(sn)
    else
      entity.spritesheet.hair = love.image.newImageData(
       '/data/spritesheet/r/'..entity.race..'/p/'..entity.sex..'/hair.tga')
    end
  elseif (entity.special) then
    p3600.sp_entity[entity.eid].load_spritesheets(entity)
  else
    entity.spritesheet.body = love.graphics.newImage(
     '/data/spritesheet/r/'..entity.race..'/body/'..entity.sex..'/'..
     entity.appearance.body_type..'.tga')
    entity.spritesheet.hair = love.image.newImageData(
     '/data/spritesheet/r/'..entity.race..'/hair/'..entity.sex..'/'..
     entity.appearance.hair_type..'.tga')
  end

  do
    local abs = require('math').abs
    local max = require('math').max
    local min = require('math').min

    local pf = function(x, y, r, g, b, a)
      if (a == 0) then
        return r, g, b, a
      end

      local M = max(r, g, b)
      local m = min(r, g, b)

      return hsl2rgb(entity.appearance.hair_hue,
                     (M - m) / (1 - abs((M + m) - 1)),
                     entity.appearance.hair_light, a)
    end

    entity.spritesheet.hair:mapPixel(pf)
  end

  entity.spritesheet.hair = love.graphics.newImage(entity.spritesheet.hair)

  entity.spritesheet.quad =
   love.graphics.newQuad(0, 0, 16, 16, 256, 256)
end
