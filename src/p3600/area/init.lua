return function(name, ...)
  require('p3600.unuse_sprites')()

  p3600.clear_love_callbacks()
  p3600.slowness = 0.01

  if not (love.filesystem.exists('/p3600/area/'..name..'/data.lua')) then
    require('p3600.area.generator')(name)
  end

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

  if
   love.filesystem.exists('/p3600/area/'..name..'.lua') or
   love.filesystem.exists('/p3600/area/'..name..'/init.lua')
  then
    require('p3600.area.'..name)((prev_area == name), ...)
  end

  if not (prev_area == name) then
    do
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
        return require('p3600.pause')(p3600.state.can_save)
      end,

      ['inventory'] = function()
        p3600.state.changed = true
        p3600.push_state()
        return require('p3600.inventory.display')()
      end,
    }

    if not (p3600.kb.w[key] == nil) then
      if not (tbl[p3600.kb.w[key]] == nil) then
        return tbl[p3600.kb.w[key]]()
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
        return require('p3600.area')(p3600.state.map.exits[pcy][pcx])
      end

      if (p3600.state.map.exits.top) and (pcy <= 1) then
        return require('p3600.area')(p3600.state.map.exits.top)
      end

      if (p3600.state.map.exits.left) and (pcx <= 1) then
        return require('p3600.area')(p3600.state.map.exits.left)
      end

      if (p3600.state.map.exits.right) and (pcx >= p3600.state.map.width) then
        return require('p3600.area')(p3600.state.map.exits.right)
      end

      if (p3600.state.map.exits.bottom) and (pcy >= p3600.state.map.height) then
        return require('p3600.area')(p3600.state.map.exits.bottom)
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
