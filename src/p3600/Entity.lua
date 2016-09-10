local table = require('table')
local Object = require('Object')

local Entity = Object.new_class('Entity')
Entity._is_object = 'p3600.Entity'

-- Returns the first index containing item (id) in the entity's inventory.
-- (where) can be "main" (default), "equip", or "both".
-- If (where) is "equip" or "both", returns an additional boolean for
-- whether the item is equipped or not.
-- Returns nil if item is not found.
function Entity:search_inv(id, where)
  where = where or 'main'

  if (where == 'main') or (where == 'both') then
    for i = 1, #self.inventory, 1 do
      if (self.inventory[i].id == id) then
        return i, false
      end
    end
  end

  if (where == 'equip') or (where == 'both') then
    for i = 1, #self.inventory.wearing, 1 do
      if (self.inventory.wearing[i].id == id) then
        return i, true
      end
    end
  end

  return nil
end

function Entity:give(item)
  self.inventory[#self.inventory + 1] = item
  return #self.inventory
end

function Entity:take(idx)
  local item = self.inventory[idx]
  table.remove(self.inventory, idx)
  return item
end

function Entity:equip(idx)
  do -- can't have two weapons
    for i = 1, #self.inventory.wearing, 1 do
      if (self.inventory.wearing[i].data.equipment.weapon) then
        self:unequip(i)
      end
    end
  end
  self.inventory.wearing[#self.inventory.wearing + 1] = self.inventory[idx]
  table.remove(self.inventory, idx)
end

function Entity:unequip(idx)
  self.inventory[#self.inventory + 1] = self.inventory.wearing[idx]
  table.remove(self.inventory.wearing, idx)
end

function Entity._new(params)
  assert(params.race)

  local random = require('math').random

  local nr = p3600.race[params.race]

  local s
  if (params.sex) then
    s = params.sex
  else
    local t = {}
    for k, _ in pairs(nr.sexes) do
      t[#t + 1] = k
    end
    s = t[random(#t)]
  end

  local bs
  local hs
  do
    local t = '/data/spritesheet/r/'..params.race..'/'
    bs = t..'body/'..s
    hs = t..'hair/'..s
  end

  local r = {
    eid = params.eid,
    special = params.special,
    name = params.name or nr.common_names[s][random(#nr.common_names[s])],
    sex = s,
    race = params.race,
    pos = {
      x = 1,
      y = 1,
      area = nil,
    },
    dir = params.dir or 0,
    persist = params.persist,
    speed_mod = params.speed_mod or 1,
    can_move = (params.can_move == nil) or params.can_move,
    inventory = {
      wearing = {},
    },
    appearance = {
      hair_type = (params.appearance and params.appearance.hair_type) or
       random(#love.filesystem.getDirectoryItems(hs)) - 1,
      body_type = (params.appearance and params.appearance.body_type) or
       random(#love.filesystem.getDirectoryItems(bs)) - 1,
      hair_hue = (params.appearance and params.appearance.hair_hue) or
       random(360),
      hair_light = (params.appearance and params.appearance.hair_light) or
       random(255),
    },
    _is_object = Entity._is_object,
  }
  setmetatable(r, Entity)
  return r
end

return Entity
