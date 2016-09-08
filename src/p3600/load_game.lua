return function(n)
  local make_objects
  make_objects = function(t)
    for i, v in pairs(t) do
      if (type(v) == 'table') then
        make_objects(v)

        if (v._is_object) then
          local mt = require(v._is_object)
          setmetatable(v, mt)
        end
      end
    end
  end

  local s = love.filesystem.load(n..'/data.lua')()
  make_objects(s)
  love.filesystem.mount(n, '/', false)
  p3600.gstate = s.gstate
  p3600.area.enter(p3600.gstate.entity[0].pos.area)
end
