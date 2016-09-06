local saoi = require('p3600.Entity'){
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

return saoi
