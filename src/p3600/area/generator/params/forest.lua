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
      [2] = {
        [10] = true,
        [11] = true,
      },
      [10] = {
        [2] = true,
        [10] = true,
        [24] = true,
      },
      [11] = {
        [2] = true,
        [10] = true,
        [24] = true,
      },
      [17] = {
        [10] = true,
        [11] = true,
      },
    },
  }

  if (x == 1) then
    p.exits.left = 'forest_30_'..tostring(y)
    p.entrances['forest_30_'..tostring(y)] = {
      player = {
        x = 2,
        y = 10,
      },
      follower = {
        x = 2,
        y = 11,
      },
    }
  else
    p.exits.left = 'forest_'..tostring(x - 1)..'_'..tostring(y)
    p.entrances['forest_'..tostring(x - 1)..'_'..tostring(y)] = {
      player = {
        x = 2,
        y = 10,
      },
      follower = {
        x = 2,
        y = 11,
      },
    }
  end

  if (x == forest_maxx) then
    p.exits.left = 'forest_2_'..tostring(y)
    p.entrances['forest_2_'..tostring(y)] = {
      player = {
        x = 2,
        y = 10,
      },
      follower = {
        x = 2,
        y = 11,
      },
    }
  else
    p.exits.right = 'forest_'..tostring(x + 1)..'_'..tostring(y)
    p.entrances['forest_'..tostring(x + 1)..'_'..tostring(y)] = {
      player = {
        x = 24,
        y = 10,
      },
      follower = {
        x = 24,
        y = 11,
      },
    }
  end

  if (y == 1) then
    p.exits.left = 'forest_'..tostring(x)..'_30'
    p.entrances['forest_'..tostring(x)..'_30'] = {
      player = {
        x = 10,
        y = 2,
      },
      follower = {
        x = 11,
        y = 2,
      },
    }
  else
    p.exits.top = 'forest_'..tostring(x)..'_'..tostring(y - 1)
    p.entrances['forest_'..tostring(x)..'_'..tostring(y - 1)] = {
      player = {
        x = 10,
        y = 2,
      },
      follower = {
        x = 11,
        y = 2,
      },
    }
  end

  if (y == forest_maxy) then
    p.exits.left = 'forest_'..tostring(x)..'_1'
    p.entrances['forest_'..tostring(x)..'_1'] = {
      player = {
        x = 10,
        y = 17,
      },
      follower = {
        x = 11,
        y = 17,
      },
    }
  else
    p.exits.bottom = 'forest_'..tostring(x)..'_'..tostring(y + 1)
    p.entrances['forest_'..tostring(x)..'_'..tostring(y + 1)] = {
      player = {
        x = 10,
        y = 17,
      },
      follower = {
        x = 11,
        y = 17,
      },
    }
  end

  return p
end
