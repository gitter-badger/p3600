require 'p3600'

return function()
  local cp = function(src, dest)
    local s = love.filesystem.newFile(src, 'r')
    local d = love.filesystem.newFile(dest, 'w')
    d:setBuffer('none')
    while not (s:isEOF()) do
      local b,n = s:read(512)
      if not (n == 0) then
        d:write(b)
      end
    end
    s:close()
    d:flush()
    d:close()
  end

  local save_name = '/save/'..p3600.gstate.entity[0].name

  love.filesystem.createDirectory(save_name)

  do
    if (love.filesystem.exists(save_name..'/data.lua')) then
      cp(save_name..'/data.lua', save_name..'/data.lua.bak')
    end

    local f = love.filesystem.newFile(save_name..'/data.lua', 'w')

    f:write("return {\n")
    f:write('  gstate = ')
    require('p3600.serialize')(f, p3600.gstate, '  ')
    f:write(",\n")
    f:write("}\n")

    f:flush()
    f:close()
  end

  if (love.filesystem.exists(save_name..'/data.lua.bak')) then
    love.filesystem.remove(save_name..'/data.lua.bak')
  end

  if not (love.filesystem.exists(save_name..'/player/body.png')) then
    love.filesystem.createDirectory(save_name..'/player')
    local dsn = '/data/spritesheet/r/'..p3600.gstate.entity[0].race..'/p/'..
                p3600.gstate.entity[0].sex..'/body.tga'
    love.image.newImageData(dsn):encode('png', save_name..'/player/body.png')
  end

  if not (love.filesystem.exists(save_name..'/player/hair.png')) then
    local dsn = '/data/spritesheet/r/'..p3600.gstate.entity[0].race..'/p/'..
                p3600.gstate.entity[0].sex..'/hair.tga'
    love.image.newImageData(dsn):encode('png', save_name..'/player/hair.png')
  end
end
