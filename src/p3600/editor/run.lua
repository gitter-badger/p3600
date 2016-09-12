return function(area_name, full)
  p3600.clear_love_callbacks()

  p3600.state = {
    changed = true,
    map_changed = true,
    name = area_name,

    rmbg = p3600.display.render_map_bg,
    rmfg = p3600.display.render_map_fg,

    show_fg = true,
    show_bg = true,
    show_walls = false,

    selection = {
      x = 1,
      y = 1,
      fg = true, -- If false, bg is selected.
    },
  }

  if not (area_name == nil) then
    p3600.state.map = loadfile('/p3600/area/'..area_name..'.lua')()
  end

  p3600.slowness = 0.1

  p3600.keypressed = function(key)
    local tbl = {
      ['up'] = function()
        if (p3600.state.selection.y > 1) then
          p3600.state.selection.y = p3600.state.selection.y - 1
          p3600.state.changed = true
        end
      end,

      ['down'] = function()
        if (p3600.state.selection.y < p3600.state.map.height) then
          p3600.state.selection.y = p3600.state.selection.y + 1
          p3600.state.changed = true
        end
      end,

      ['left'] = function()
        if (p3600.state.selection.x > 1) then
          p3600.state.selection.x = p3600.state.selection.x - 1
          p3600.state.changed = true
        end
      end,

      ['right'] = function()
        if (p3600.state.selection.x < p3600.state.map.width) then
          p3600.state.selection.x = p3600.state.selection.x + 1
          p3600.state.changed = true
        end
      end,

      ['menu'] = p3600.editor.menu,

      ['exit'] = function()
        p3600.state.changed = true
        p3600.push_state()

        p3600.display.menu{
          back = p3600.pop_state,

          'Are you sure you want to exit?',

          {
            label = 'No',
            action = function()
              p3600.pop_state()
            end,
          },

          {
            label = 'Yes',
            action = function()
              p3600.pop_state()
              p3600.pop_state()
            end,
          },
        }
      end
    }
    if
     (not (p3600.kb.e[key] == nil)) and
     (not (tbl[p3600.kb.e[key]] == nil))
    then
      tbl[p3600.kb.e[key]]()
    end
  end

  p3600.update = function(dt)
    if (p3600.state.map_changed) then
      p3600.state.cached_map = p3600.display.make_map(p3600.state.map)
      p3600.state.changed = true
      p3600.state.map_changed = false
    end
  end

  p3600.draw = function()
    if (p3600.state.changed) and (not (p3600.state.map_changed)) then
      love.graphics.clear()

      if (p3600.state.show_bg) then
        p3600.state.rmbg(p3600.state.cached_map)
      end

      if (p3600.state.show_fg) then
        p3600.state.rmfg(p3600.state.cached_map)
      end

      if (p3600.state.show_walls) then
        for y, r in pairs(p3600.state.map.tiletypes) do
          for x, v in pairs(r) do
            if (v == 1) then
              love.graphics.rectangle('line',
                                      ((x - 1) * 32) + ((32 / 2) - (16 / 2)),
                                      ((y - 1) * 32) + ((32 / 2) - (16 / 2)),
                                      16, 16)
            end
          end
        end
      end

      love.graphics.rectangle('line', (p3600.state.selection.x * 32) - 33,
                              (p3600.state.selection.y * 32) - 33, 34, 34)

      p3600.display.changed = true
      p3600.state.changed = false
    end
  end

  if (full) then
    love.window.setTitle('p3600 map editor')

    if (area_name == nil) then
      p3600.editor.prompt_for_area()
    end
  end
end
