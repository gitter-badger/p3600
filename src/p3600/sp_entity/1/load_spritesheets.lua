return function(e)
  local n = '/data/spritesheet/se/1/0/'
  e.spritesheet.body = love.graphics.newImage(n..'body.tga')
  e.spritesheet.hair = love.image.newImageData(n..'hair.tga')
end
