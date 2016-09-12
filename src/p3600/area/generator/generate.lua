return function(name)
  local f
  do
    local filename = '/save/'..p3600.gstate.entity[0].name..'/p3600/area/'
    love.filesystem.createDirectory(filename)
    f = love.filesystem.newFile(filename..name..'.lua', 'w')
  end

  local params
  do
    local area_name = name:gmatch('[^_]*')()
    local func = p3600.area.generator.params[area_name]
    local left = name:sub(#area_name + 2)
    local x = left:gmatch('[^_]*')()
    left = left:sub(#x + 2)
    local y = left
    params = func(tonumber(x), tonumber(y))
  end

  f:write('return {\n')

  f:write('  height = '..tostring(params.height)..',\n')
  f:write('  width = '..tostring(params.width)..',\n')

  f:write('  exits = ')
  p3600.serialize(f, params.exits, '  ')
  f:write(",\n")

  local fg = {
  }
  local bg = {
  }
  local tiletypes = {}

  for y = 1, params.height, 1 do
    fg[y] = {}
    bg[y] = {}
    tiletypes[y] = {}
    for x = 1, params.width, 1 do
      fg[y][x] = 0
      bg[y][x] = params.floor_ids[math.random(#params.floor_ids)]
      tiletypes[y][x] = 0
    end
  end

  if (params.features and params.features.trees) then
    local ids = params.features.trees.ids
    for y = 1, params.height, 1 do
      for x = 1, params.width, 1 do
        if
         (require('math').random() < (params.features.trees.density or 0.3))
        then
          fg[y][x] = ids[math.random(#ids)]
          tiletypes[y][x] = 1
        end
      end
    end
  end

  if (params.walls) and (params.walls.top) then
    for x = 1, params.width, 1 do
      tiletypes[1][x] = 1
      fg[1][x] = params.wall_ids[math.random(#params.wall_ids)]
    end
  end

  if (params.walls) and (params.walls.bottom) then
    for x = 1, params.width, 1 do
      tiletypes[params.height][x] = 1
      fg[params.height][x] = params.wall_ids[math.random(#params.wall_ids)]
    end
  end

  if (params.walls) and (params.walls.left) then
    for y = 1, params.height, 1 do
      tiletypes[y][1] = 1
      fg[y][1] = params.wall_ids[math.random(#params.wall_ids)]
    end
  end

  if (params.walls) and (params.walls.right) then
    for y = 1, params.height, 1 do
      tiletypes[y][params.width] = 1
      fg[y][params.width] = params.wall_ids[math.random(#params.wall_ids)]
    end
  end

  if (params.always_clear) then
    for y, r in pairs(params.always_clear) do
      for x, v in pairs(r) do
        if (v) then
          tiletypes[y][x] = 0
          fg[y][x] = 0
        end
      end
    end
  end

  f:write('  fg = {\n')
  f:write('    spritesheet = [['..params.fg_spritesheet..']],\n')
  f:write('    data = ')
  p3600.serialize(f, fg, '    ')
  f:write(",\n")
  f:write("  },\n")

  f:write('  bg = {\n')
  f:write('    spritesheet = [['..params.bg_spritesheet..']],\n')
  f:write('    data = ')
  p3600.serialize(f, bg, '    ')
  f:write(",\n")
  f:write("  },\n")

  f:write('  tiletypes = ')
  p3600.serialize(f, tiletypes, '  ')
  f:write(",\n")

  f:write('  entrances = ')
  p3600.serialize(f, params.entrances, '  ')
  f:write(",\n")

  f:write('  exits = ')
  p3600.serialize(f, params.exits, '  ')
  f:write(",\n")

  f:write('}\n')

  f:flush()
  f:close()
end
