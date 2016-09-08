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
--
-- Built-in modules are detected and added automatically.
--
-- Consult your doctor or physician before using this module to see if it's
-- right for you.

local gc_blacklist = { -- pre-loaded modules that cannot be safely unloaded
  -- Only top-level modules, the sub-modules are in the tables.
  -- For example, love.graphics is accessible through love.
  'coroutine', -- probably
  'debug', -- probably
  'ffi',
  'jit',
  'love',
  'math', -- maybe, uses C functions
  'os', -- not verified
  'package', -- we _need_ this
}

local package = require('package')

return function()
  if (package.is_better) then -- running twice is stupid, and possibly unsafe
    return
  end

  package.is_better = true

  setmetatable(package.loaded, {__mode = 'v',})

  if not (package.nogc) then
    package.nogc = {}
  end

  for i, m in pairs(gc_blacklist) do
    if (package.loaded[m]) then
      if (package.loaded[m] == true) then -- _bad_ module
        if (_G[m]) then -- this won't work if there are dots in the name
          package.nogc[#package.nogc + 1] = _G[m]
        else -- _UGLY_ module
          -- It's your fault we can't have nice things.
          error('Module "'..m..'" is loaded, but not accessible in a sane way.')
        end
      else -- _good_ module
        package.nogc[#package.nogc + 1] = package.loaded[m]
      end
    end
  end
end
