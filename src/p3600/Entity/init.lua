require 'p3600'

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
  self.inventory.wearing[#self.inventory.wearing + 1] = self.inventory[idx]
  table.remove(self.inventory, idx)
end

function Entity:unequip(idx)
  self.inventory[#self.inventory + 1] = self.inventory.wearing[idx]
  table.remove(self.inventory.wearing, idx)
end

function Entity._new(params)
  local r = {
    eid = params.eid,
    special = params.special,
    name = params.name,
    sex = params.sex,
    race = params.race,
    pos = {
      x = 1,
      y = 1,
      area = nil,
    },
    dir = params.dir or 0,
    persist = params.persist,
    speed_mod = params.speed_mod or 1,
    can_move = params.can_move or true,
    inventory = {
      wearing = {},
    },
    appearance = {
      hair_type = 0,
      hair_color = {0, 0, 0, 0},
      body_type = 0,
    },
    _is_object = Entity._is_object,
  }
  setmetatable(r, Entity)
  return r
end

return Entity
