return function(x, y)
  local forest_maxx = 30
  local forest_maxy = 30

  local p = {
    height = 18,
    width = 25,

    walls = {},

    fg_spritesheet = 'bg0',
    bg_spritesheet = 'bg0',

    wall_ids = {
      2,
    },

    floor_ids = {
      1,
      9,
      17,
    },

    features = {
      trees = {
        ids = {
          2,
        },
        density = 0.3,
      },
    },

    entrances = {
      default = {
        player = {
          x = 10,
          y = 10,
        },
        follower = {
          x = 10,
          y = 11,
        },
      },
    },

    exits = {},

    always_clear = {
      {true, true, true, true, true, true, true, true, true, true, true, true,
       true, true, true, true, true, true, true, true, true, true, true, true,
       true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {[1] = true, [25] = true},
      {true, true, true, true, true, true, true, true, true, true, true, true,
       true, true, true, true, true, true, true, true, true, true, true, true,
       true},
    },
  }

  if (x == 1) then
    p.exits.left = 'forest_30_'..tostring(y)
  else
    p.exits.left = 'forest_'..tostring(x - 1)..'_'..tostring(y)
  end

  if (x == forest_maxx) then
    p.exits.left = 'forest_2_'..tostring(y)
  else
    p.exits.right = 'forest_'..tostring(x + 1)..'_'..tostring(y)
  end

  if (y == 1) then
    p.exits.left = 'forest_'..tostring(x)..'_30'
  else
    p.exits.top = 'forest_'..tostring(x)..'_'..tostring(y - 1)
  end

  if (y == forest_maxy) then
    p.exits.left = 'forest_'..tostring(x)..'_1'
  else
    p.exits.bottom = 'forest_'..tostring(x)..'_'..tostring(y + 1)
  end

  return p
end
