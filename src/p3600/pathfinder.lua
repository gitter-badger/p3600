return function(grid, sx, sy, dx, dy)
  if (grid._jumper == nil) then
    local g = require('jumper.grid')(grid)
    grid._jumper = require('jumper.pathfinder')(g, 'ASTAR', 0)
    grid._jumper:setMode('ORTHOGONAL')
  end

  return grid._jumper:getPath(sx, sy, dx, dy)
end
