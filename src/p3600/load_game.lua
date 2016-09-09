local make_objects
make_objects = function(t)
  for i, v in pairs(t) do
    if (type(v) == 'table') then
      make_objects(v)

      if (v._is_object) then
        setmetatable(v, require(v._is_object))
      end
    end
  end
end

return function(n)
  local s = assert(loadfile(n..'/data.lua'))()
  make_objects(s)
  love.filesystem.mount(n, '/', false)
  p3600.gstate = s.gstate

  if (love.filesystem.exists(n..'/keybinds.lua')) then
    s = assert(loadfile(n..'/keybinds.lua'))()
    p3600.kb.e = s.editor or p3600.kb.e
    p3600.kb.m = s.menu or p3600.kb.m
    p3600.kb.w = s.world or p3600.kb.w
  end

  return p3600.area.enter(p3600.gstate.entity[0].pos.area)
end
