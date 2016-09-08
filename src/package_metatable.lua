return {
  __index = function(tbl, index)
    local s, r = pcall(require, tbl._modname..'.'..tostring(index))
    if (s) then
      return r
    else
      return nil
    end
  end,
}
