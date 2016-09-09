return function(name, ...)
  p3600.unuse_sprites()

  p3600.clear_love_callbacks()
  p3600.slowness = 0.01

  if not (love.filesystem.exists('/p3600/area/'..name..'/data.lua')) then
    p3600.area.generator.generate(name)
  end

  local mapdata = loadfile('/p3600/area/'..name..'/data.lua')()

  p3600.state = {
    map = p3600.display.make_map(mapdata),
    rmbg = p3600.display.render_map_bg,
    rmfg = p3600.display.render_map_fg,
    re = p3600.display.render_entity,
    k = p3600.reverse_aa(p3600.kb.w),
    update_player = p3600.update_player,
    ue = p3600.update_entity,
    changed = true,
    can_save = true,
  }

  local prev_area = p3600.gstate.entity[0].pos.area

  if (p3600.area[name]) then
    local f = p3600.area[name].onload
    if (f) then
      f((prev_area == name), ...)
    end
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
      p3600.pull_followers(0, entrance.follower.x, entrance.follower.y)
    end

    p3600.clean_other_areas(name)
  end

  p3600.state.active_entities = p3600.get_entities_in_area(name)

  do
    local u = p3600.use_sprites
    for eid, v in pairs(p3600.state.active_entities) do
      u(eid)
    end
  end

  p3600.keypressed = function(key)
    local tbl = {
      ['pause'] = function()
        p3600.state.changed = true
        return p3600.pause(p3600.state.can_save)
      end,

      ['inventory'] = function()
        p3600.state.changed = true
        p3600.push_state()
        return p3600.inventory()
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
      local pcx
      local pcy
      do
        local math = require('math')
        pcx = math.floor(p3600.gstate.entity[0].pos.x)
        pcy = math.floor(p3600.gstate.entity[0].pos.y)
      end

      if
       (p3600.state.map.exits[pcy]) and
       (p3600.state.map.exits[pcy][pcx])
      then
        return p3600.area.enter(p3600.state.map.exits[pcy][pcx])
      end

      if (p3600.state.map.exits.top) and (pcy <= 1) then
        return p3600.area.enter(p3600.state.map.exits.top)
      end

      if (p3600.state.map.exits.left) and (pcx <= 1) then
        return p3600.area.enter(p3600.state.map.exits.left)
      end

      if (p3600.state.map.exits.right) and (pcx >= p3600.state.map.width) then
        return p3600.area.enter(p3600.state.map.exits.right)
      end

      if (p3600.state.map.exits.bottom) and (pcy >= p3600.state.map.height) then
        return p3600.area.enter(p3600.state.map.exits.bottom)
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
