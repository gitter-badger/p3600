-- Better package module that automagically unloads unused modules.
-- Require and call this function once to set everything up.
--
-- How it works:
-- By making the package.loaded table weak, modules that are not currently used
-- elsewhere can be garbage collected.
--
-- If you use the `local modname = require("modname")` approach, then
-- the module becomes elegible for garbage collection once modname goes out
-- of scope, but if you require it again before it is collected, the cached
-- result is used like normal, keeping the performance benefits.
--
-- If a module uses C callbacks or anything else that makes it dangerous to
-- unload, the module must manually add it's package.loaded value
-- (the table it returns when required) to package.nogc
-- Alternatively, you can add the full module name to package.gc_blacklist
--
-- Built-in modules are detected and added automatically.
--
-- Consult your doctor or physician before using this module to see if it's
-- right for you.

-- Ironically, this module itself is a feral module.

local package = require('package')

if not (package.gc_blacklist) then -- create if nonexistant
  package.gc_blacklist = {}
end

-- Modules that cannot be safely unloaded.
-- This list is by no means complete; you can add more entries at any time.
package.gc_blacklist['enet'] = true
package.gc_blacklist['ffi'] = true
package.gc_blacklist['jit'] = true
package.gc_blacklist['love'] = true
package.gc_blacklist['ltn12'] = true
package.gc_blacklist['mime'] = true
package.gc_blacklist['mime.core'] = true -- can be loaded seperately
package.gc_blacklist['socket'] = true
package.gc_blacklist['socket.core'] = true -- can be loaded seperately
package.gc_blacklist['socket.ftp'] = true -- can be loaded seperately
package.gc_blacklist['socket.http'] = true -- can be loaded seperately
package.gc_blacklist['socket.smtp'] = true -- can be loaded seperately
package.gc_blacklist['socket.tp'] = true -- can be loaded seperately
package.gc_blacklist['socket.url'] = true -- can be loaded seperately

-- It is almost impossible to tell how the "standard library"
-- is implemented, so it is blacklisted to be safe.
package.gc_blacklist['bit'] = true
package.gc_blacklist['coroutine'] = true
package.gc_blacklist['debug'] = true
package.gc_blacklist['io'] = true
package.gc_blacklist['math'] = true
package.gc_blacklist['os'] = true
package.gc_blacklist['package'] = true
package.gc_blacklist['string'] = true
package.gc_blacklist['table'] = true
package.gc_blacklist['utf8'] = true

package.require = require -- save real require function

local better_require = function(modname)
  if (not package.loaded[modname]) and (package.gc_blacklist[modname]) then
    local r = package.require(modname)
    package.nogc[#package.nogc + 1] = r
    return r
  end

  return package.require(modname)
end

return function()
  if (package.is_better) then -- running twice is stupid, and possibly unsafe
    return
  end

  if not (package.nogc) then -- create if nonexistant
    package.nogc = {}
  end

  require = better_require -- inject the blacklist-aware version

  for m, i in pairs(package.gc_blacklist) do -- detect preloaded modules
    if (package.loaded[m]) then
      if (package.loaded[m] == true) then -- _bad_ module
        if (_G[m]) then -- this won't work if there are dots in the name
          package.nogc[#package.nogc + 1] = _G[m]
        else -- _UGLY_ module
          -- This module is ugly, unfortunately.
          -- However, _it_ is safe to unload.
          --
          -- You know how it goes, people make rules for others and
          -- exceptions for themselves.
          -- Well, let's change that by making an exception for others,
          -- because we rule. ;p
          error('Module "'..m..'" is loaded, but not accessible in a sane way.')
          -- You can always take the offending module off the blacklist
          -- if you know it has references.
        end
      else -- _good_ module
        package.nogc[#package.nogc + 1] = package.loaded[m]
      end
    end
  end

  setmetatable(package.loaded, {__mode = 'v',})

  package.is_better = true
end
