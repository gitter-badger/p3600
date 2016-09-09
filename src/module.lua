local package_metatable = {
  __index = function(tbl, index)
    local s, r = pcall(require, tbl._NAME..'.'..tostring(index))
    if (s) then
      return r
    else
      return nil
    end
  end,
}

local getlast = function(str, c)
  local b = c:byte(1)
  for i = #str, 0, -1 do
    if (str:byte(i) == b) then
      return i
    end
  end
  return -1
end

return function(modname)
  local r = {_NAME = modname}
  do
    local l = getlast(modname, '.')
    if not (l == -1) then
      r._PACKAGE = modname:sub(1, l - 1)
    end
  end
  setmetatable(r, package_metatable)
  return r
end
