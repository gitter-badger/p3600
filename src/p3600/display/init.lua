local m = module('p3600.display')
package.nogc[#package.nogc + 1] = m

m.buffer = {}

-- If true, screen will be redrawn.
m.changed = true

-- Automatic values. Don't mess with these.
m.width = 320
m.height = 240

return m
