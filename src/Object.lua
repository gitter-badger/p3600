local Object
Object = {
  __index = function(t, index)
    if not (index == 'new_class') then
      return Object[index]
    else
      return nil
    end
  end,

  __call = function(class, ...)
    return class._new(...)
  end,

  is_a = function(name)
    return (name == 'Object')
  end,

  new_class = function(name, parent)
    parent = parent or Object
    local c
    c = {
      _name = name,

      _parent = parent,

      __index = function(tbl, index)
        if not (c[index] == nil) then
          return c[index]
        end
        return c._parent[index]
      end,

      is_a = function(n)
        if (n == c._name) then
          return true
        end
        return c._parent.is_a(n)
      end,
    }

    setmetatable(c, parent)

    return c
  end,

  _is_object = 'Object',
}

return Object
