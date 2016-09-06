require 'p3600'

local Object = require('Object')

local Entity = Object.new_class('Entity')

Entity._is_object = 'p3600.Entity'

function Entity:set_pos(x, y, area)
  self.pos.x = x
  self.pos.y = y
  if not (area == nil) then
    self.pos.area = area
  end
end

function Entity:give(item)
  print('need to give an item to '..self.name, item)
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
