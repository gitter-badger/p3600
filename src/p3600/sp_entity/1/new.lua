local saoi = p3600.Entity{
  eid = 1,
  special = true,
  persist = true,

  name = 'Saoirse',
  race = 11,
  sex = 2,
  speed_mod = 1,
  can_move = true,
  dir = 3,
}

saoi.progress = {
  main = 0,
}

saoi.pos = {
  x = 12,
  y = 13,
  area = 'clearing',
}

local Item = p3600.Item

saoi:give(Item('sao_shortsword'))
saoi:give(Item('sao_longsword'))
saoi:equip(saoi:give(Item('sao_armor')))

return saoi
