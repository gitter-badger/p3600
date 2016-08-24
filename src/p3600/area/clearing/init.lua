require 'p3600'

return function(init) -- init is only true if called from intro
  p3600.clear_love_callbacks()

  p3600.slowness = 0.01

  p3600.gstate.entity[0].pos.area = 'clearing'

  if (init) then
    p3600.gstate.entity[1] = require('p3600.sp_entity.1')
  end

  p3600.state = {
    map = require('p3600.display.make_map')(require('p3600.area.clearing.data')),
    rmbg = require('p3600.display.render_map_bg'),
    rmfg = require('p3600.display.render_map_fg'),
    re = require('p3600.display.render_entity'),
    k = require('p3600.reverse_aa')(p3600.kb.w),
    update_player = require('p3600.update_player'),
    ue = require('p3600.update_entity'),
    changed = true,
    active_entities = require('p3600.get_entities_in_area')('clearing'),
  }

  do
    local u = require('p3600.use_sprites')
    for eid, v in pairs(p3600.state.active_entities) do
      u(eid)
    end
  end

  p3600.keypressed = function(key)
    local tbl = {
      ['pause'] = function()
        p3600.state.changed = true
        require('p3600.pause')(true)
      end,
    }

    if not (p3600.kb.w[key] == nil) then
      if not (tbl[p3600.kb.w[key]] == nil) then
        tbl[p3600.kb.w[key]]()
      end
    end
  end

  p3600.update = function(dt)
    p3600.state.update_player(dt)
    for eid, v in pairs(p3600.state.active_entities) do
      p3600.state.ue(eid, v, dt)
    end
  end

  p3600.draw = function()
    if (p3600.state.changed) then
      love.graphics.clear(love.graphics.getBackgroundColor())
      p3600.state.rmbg(p3600.state.map)
      for eid, v in pairs(p3600.state.active_entities) do
        p3600.state.re(v)
      end
      p3600.state.rmfg(p3600.state.map)
      p3600.display.changed = true
      p3600.state.changed = false
    end
  end
end
