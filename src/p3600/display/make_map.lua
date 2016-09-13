return function(mapdata)
  local map = {
    width = mapdata.layers['tiletypes'].width,
    height = mapdata.layers['tiletypes'].height,
    tiletype = {},
    data = mapdata,
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

  return map
end
