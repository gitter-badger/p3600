return function(mapdata)
  local map = {
    width = mapdata.layers['tiletypes'].width,
    height = mapdata.layers['tiletypes'].height,
    tiletype = {},
    data = mapdata,
    entrances = {},
    exits = {},
    vx = 0,
    vy = 0,
  }

  for y, r in pairs(mapdata.layers['tiletypes'].data) do
    map.tiletype[y] = {}
    for x, t in pairs(r) do
      map.tiletype[y][x] = t.id
    end
  end

  do
    local e = mapdata:getLayerProperties('exits')
    map.exits['top'] = e['top']
    map.exits['bottom'] = e['bottom']
    map.exits['left'] = e['left']
    map.exits['right'] = e['right']
  end

  if not (mapdata.layers['entrances'] == nil) then
    for _, e in pairs(mapdata.layers['entrances'].objects) do
      local id = e.name:gmatch('[^/]+')()
      local subv = e.name:gsub('.*/', '')

      if (map.entrances[id] == nil) then
        map.entrances[id] = {}
      end

      map.entrances[id][subv] = {
        x = e.x / 16,
        y = e.y / 16,
        dir = e.properties.dir,
      }
    end
  end

  return map
end
