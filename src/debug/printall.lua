local debug = require('debug')

return function(tbl, opts)
  if not (opts) then
    opts = {}
  end

  local cycle_tbl = {} -- Detecting recursion is literally this simple.

  local format_tbl = {
    ['string'] = function(v)
      return '"'..v..'"'
    end,
  }

  local printall
  printall = function(i, t, remaining_depth)
    cycle_tbl[t] = true
    for k,v in pairs(t) do
      local s = i

      s = s..tostring(k)..' = '

      if not (format_tbl[type(v)] == nil) then
        s = s..format_tbl[type(v)](v)
      else
        s = s..tostring(v)
      end

      print(s)

      if (type(v) == 'table') then
        if not (remaining_depth == 0) then
          if (cycle_tbl[v] == nil) then
            printall(i..'  ', v, remaining_depth - 1)
          elseif (cycle_tbl[v] == false) then
            print(i..'  (recurrence)')
          elseif (cycle_tbl[v] == true) then
            print(i..'  (cycle)')
          end
        else
          print(i..'  (too deep)')
        end
      end

      if (opts.show_metatables) then
        local mt = debug.getmetatable(v)
        if not (mt == nil) then
          print(i..'  (metatable) = '..tostring(mt))
          printall(i..'    ', mt, remaining_depth - 1)
        end
      end
    end

    if not (opts.show_recurrent) then
      cycle_tbl[t] = nil
    end
  end

  printall('', tbl, opts.max_depth or -1)
end
