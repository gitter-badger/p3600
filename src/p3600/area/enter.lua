local floor = require('math').floor
local sti = require('sti')

return function(name, edge, ...)
  p3600.unuse_sprites()

  p3600.clear_love_callbacks()
  p3600.slowness = 0.01

  if not (love.filesystem.exists('/p3600/area/'..name..'.lua')) then
    p3600.area.generator.generate(name)
  end

  local mapdata = sti('/p3600/area/'..name..'.lua')

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

  if (love.filesystem.exists('/p3600/area/'..name..'_onload.lua')) then
    loadfile('/p3600/area/'..name..'_onload.lua')()((prev_area == name), ...)
  end

  if not (prev_area == name) then
    do
      local ppos = p3600.gstate.entity[0].pos

      ppos.area = name

      if not (edge) then
        local entrance = mapdata.entrances[prev_area]
        if (entrance == nil) then
          entrance = mapdata.entrances.default
        end
        ppos.x = entrance.player.x
        ppos.y = entrance.player.y
        p3600.pull_followers(0, entrance.follower.x, entrance.follower.y)
      elseif (edge == 'top') then
        ppos.y = mapdata.height - 1
        p3600.pull_followers(0, ppos.x, ppos.y)
      elseif (edge == 'bottom') then
        ppos.y = 1
        p3600.pull_followers(0, ppos.x, ppos.y)
      elseif (edge == 'left') then
        ppos.x = mapdata.width - 1
        p3600.pull_followers(0, ppos.x, ppos.y)
      else -- (edge == 'right')
        ppos.x = 1
        p3600.pull_followers(0, ppos.x, ppos.y)
      end
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

      ['interact'] = function()
        local tx = p3600.gstate.entity[0].pos.x
        local ty = p3600.gstate.entity[0].pos.y
        local ta = p3600.gstate.entity[0].pos.area

        if (p3600.gstate.entity[0].dir == 0) then
          ty = ty + 1
        elseif (p3600.gstate.entity[0].dir == 1) then
          tx = tx - 1
        elseif (p3600.gstate.entity[0].dir == 2) then
          ty = ty - 1
        else -- (p3600.gstate.entity[0].dir == 3)
          tx = tx + 1
        end

        local e = p3600.get_entity_at(tx, ty, 0.3, ta)

        if (e) then
          p3600.state.changed = true
          return p3600.interact(e)
        end
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
    p3600.state.map.data:update(dt)
    p3600.state.update_player(dt)
    do
      local pcx
      local pcy
      do
        pcx = floor(p3600.gstate.entity[0].pos.x)
        pcy = floor(p3600.gstate.entity[0].pos.y)
      end

      if
       (p3600.state.map.exits[pcy]) and
       (p3600.state.map.exits[pcy][pcx])
      then
        return p3600.area.enter(p3600.state.map.exits[pcy][pcx])
      end

      if (p3600.state.map.exits.top) and (pcy < 1) then
        return p3600.area.enter(p3600.state.map.exits.top, 'top')
      end

      if (p3600.state.map.exits.left) and (pcx < 1) then
        return p3600.area.enter(p3600.state.map.exits.left, 'left')
      end

      if (p3600.state.map.exits.right) and (pcx > p3600.state.map.width) then
        return p3600.area.enter(p3600.state.map.exits.right, 'right')
      end

      if (p3600.state.map.exits.bottom) and (pcy > p3600.state.map.height) then
        return p3600.area.enter(p3600.state.map.exits.bottom, 'bottom')
      end
    end
    for eid, v in pairs(p3600.state.active_entities) do
      p3600.state.ue(eid, v, dt)
    end
  end

  p3600.draw = function()
    if (p3600.state.changed) then
      do -- update x
        local x = p3600.state.map.vx
        local nx = floor((p3600.gstate.entity[0].pos.x - 1) * 16) - (320 / 2)

        if ((nx + 320) > ((p3600.state.map.width - 1) * 16)) then
          nx = ((p3600.state.map.width - 1) * 16) - 320
        end

        if (nx < 0) then
          nx = 0
        end

        if not (nx == x) then
          p3600.state.map.vx = nx
        end
      end

      do -- update y
        local y = p3600.state.map.vy
        local ny = floor((p3600.gstate.entity[0].pos.y - 1) * 16) - (240 / 2)

        if ((ny + 240) > ((p3600.state.map.height - 1) * 16)) then
          ny = ((p3600.state.map.height - 1) * 16) - 240
        end

        if (ny < 0) then
          ny = 0
        end

        if not (ny == y) then
          p3600.state.map.vy = ny
        end
      end

      love.graphics.push()
      p3600.state.map.data:setDrawRange(p3600.state.map.vx * -1,
                                        p3600.state.map.vy * -1,
                                        320, 240)
      love.graphics.translate(p3600.state.map.vx * -1, p3600.state.map.vy * -1)

      love.graphics.clear(love.graphics.getBackgroundColor())

      p3600.state.rmbg(p3600.state.map)

      for eid, v in pairs(p3600.state.active_entities) do
        p3600.state.re(v)
      end

      p3600.state.rmfg(p3600.state.map)

      love.graphics.pop()
      p3600.display.changed = true
      p3600.state.changed = false
    end
  end
end
