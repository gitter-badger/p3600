require 'p3600'

return function(name, arg)
  require('p3600.unuse_sprites')()

  p3600.clear_love_callbacks()
  p3600.slowness = 0.01

  local mapdata = require('p3600.area.'..name..'.data')

  p3600.state = {
    map = require('p3600.display.make_map')(mapdata),
    rmbg = require('p3600.display.render_map_bg'),
    rmfg = require('p3600.display.render_map_fg'),
    re = require('p3600.display.render_entity'),
    k = require('p3600.reverse_aa')(p3600.kb.w),
    update_player = require('p3600.update_player'),
    ue = require('p3600.update_entity'),
    changed = true,
    can_save = true,
  }

  local prev_area = p3600.gstate.entity[0].pos.area
  if not (prev_area == name) then
    do
      require('p3600.area.'..name)(arg)
      p3600.gstate.entity[0].pos.area = name

      local entrance = mapdata.entrances[prev_area]

      if (entrance == nil) then
        entrance = mapdata.entrances.default
      end

      p3600.gstate.entity[0].pos.x = entrance.player.x
      p3600.gstate.entity[0].pos.y = entrance.player.y
      require('p3600.pull_followers')(0, entrance.follower.x,
                                      entrance.follower.y)
    end

    require('p3600.clean_other_areas')(name)
  end

  p3600.state.active_entities = require('p3600.get_entities_in_area')(name)

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
        require('p3600.pause')(p3600.state.can_save)
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
    do
      local pcx = math.floor(p3600.gstate.entity[0].pos.x)
      local pcy = math.floor(p3600.gstate.entity[0].pos.y)

      if
       (p3600.state.map.exits[pcy]) and
       (p3600.state.map.exits[pcy][pcx])
      then
        require('p3600.area')(p3600.state.map.exits[pcy][pcx].name)
        return
      end
    end
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
