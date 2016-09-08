return function(mapdata)
  local spq = require('p3600.display.spq')

  local map = {
    width = mapdata.width,
    height = mapdata.height,
    tiletype = mapdata.tiletypes,
    exits = mapdata.exits,
  }

  do -- make background SpriteBatch
    local ss = love.graphics.newImage('/data/spritesheet/'..
                                      mapdata.bg.spritesheet..'.tga')
    map.bg = love.graphics.newSpriteBatch(ss, map.width * map.height, 'static')

    if (mapdata.fg.spritesheet == mapdata.bg.spritesheet) then -- save memory
      map.fg = love.graphics.newSpriteBatch(ss, map.width * map.height,
                                            'static')
    end
  end

  if (map.fg == nil) then -- make foreground SpriteBatch
    local ss = love.graphics.newImage('/data/spritesheet/'..
                                      mapdata.fg.spritesheet..'.tga')
    map.fg = love.graphics.newSpriteBatch(ss, map.width * map.height,
                                          'static')
  end

  do
    local quads = {}

    for x = 1, map.width, 1 do
      for y = 1, map.height, 1 do
        if (quads[mapdata.bg.data[y][x]] == nil) then
          quads[mapdata.bg.data[y][x]] = spq(mapdata.bg.data[y][x])
        end
        map.bg:add(quads[mapdata.bg.data[y][x]], (x - 1) * 32, (y - 1) * 32)
        if (quads[mapdata.fg.data[y][x]] == nil) then
          quads[mapdata.fg.data[y][x]] = spq(mapdata.fg.data[y][x])
        end
        map.fg:add(quads[mapdata.fg.data[y][x]], (x - 1) * 32, (y - 1) * 32)
      end
    end
  end

  return map
end
