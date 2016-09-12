return function(items)
  p3600.slowness = 0.1
  love.keyboard.setTextInput(false)

  p3600.state = {
    top_entry = 1,
    start_at = items.start_row or 1,
    selection  = 1,
    menu_items = items,
    changed = true,
    onreturn = items.onreturn,
    do_onreturn = false,
    back = items.back,
    on_draw = items.draw,
    _p = p3600.display.print,
  }

  if not (items.init == nil) then
    items.init()
  end

  if (p3600.state._menu_cursor == nil) then
    local s = p3600.state_stack
    while not (s == nil) do
      if not (s.state._menu_cursor == nil) then
        p3600.state._menu_cursor = s.state._menu_cursor
        s = nil
      else
        s = s.state_stack
      end
    end

    if (p3600.state._menu_cursor == nil) then
      p3600.state._menu_cursor = love.graphics.newImage('/data/menu/cursor.tga')
    end
  end

  p3600.clear_love_callbacks()

  -- XXX: if a menu is declared with only seperators, behavior is undefined
  while not (type(p3600.state.menu_items[p3600.state.selection]) == 'table') do
    p3600.state.selection = p3600.state.selection + 1
  end

  p3600.keypressed = function(key)
    local tbl = {
      ['up'] = function()
        if (p3600.state.selection > 1) then
          local prev_selection = p3600.state.selection
          local prev_top = p3600.state.top_entry

          p3600.state.changed = true

          if (p3600.state.selection <= p3600.state.top_entry) then
            p3600.state.top_entry = p3600.state.top_entry - 1
          end

          repeat
            p3600.state.selection = p3600.state.selection - 1
          until ((type(p3600.state.menu_items[p3600.state.selection])
                  == 'table') or (p3600.state.selection < 1))

          if (p3600.state.selection < 1) then
            p3600.state.changed = not (p3600.state.top_entry == prev_top)
            p3600.state.selection = prev_selection
          elseif (p3600.state.selection < p3600.state.top_entry) then
            p3600.state.top_entry = p3600.state.selection
          end
        end
      end,

      ['down'] = function()
        if (p3600.state.selection < #p3600.state.menu_items) then
          local prev_selection = p3600.state.selection
          local prev_top = p3600.state.top_entry

          p3600.state.changed = true

          if
           (p3600.state.selection >
            (p3600.state.top_entry + (34 - p3600.state.start_at)))
          then
            p3600.state.top_entry = p3600.state.top_entry + 1
          end

          repeat
            p3600.state.selection = p3600.state.selection + 1
          until ((type(p3600.state.menu_items[p3600.state.selection])
                  == 'table') or
                 (p3600.state.selection > #p3600.state.menu_items))

          if (p3600.state.selection > #p3600.state.menu_items) then
            p3600.state.changed = not (p3600.state.top_entry == prev_top)
            p3600.state.selection = prev_selection
          elseif
           (p3600.state.selection >
            (p3600.state.top_entry + (34 - p3600.state.start_at)))
          then
            p3600.state.top_entry = p3600.state.selection
                                    - (34 - p3600.state.start_at)
          end
        end
      end,

      ['select'] = function()
        if (p3600.state.menu_items[p3600.state.selection].action) then
          p3600.state.changed = true
          p3600.state.do_onreturn = true
          return p3600.state.menu_items[p3600.state.selection].action()
        end
      end,

      ['back'] = function()
        if not (p3600.state.back == nil) then
          p3600.state.changed = true
          p3600.state.back()
        end
      end,
    }
    tbl['left'] = tbl['back']
    tbl['right'] = tbl['select']
    if not (p3600.kb.m[key] == nil) then
      if not (tbl[p3600.kb.m[key]] == nil) then
        tbl[p3600.kb.m[key]]()
      end
    end
  end

  p3600.update = function(dt)
    if (p3600.state.do_onreturn) and (not (p3600.state.onreturn == nil)) then
      p3600.state.onreturn()
    end
  end

  p3600.draw = function()
    if (p3600.state.changed) then
      love.graphics.clear()

      if not (p3600.state.top_entry == 1) then
        love.graphics.setColor(200, 200, 200, 200)
        p3600.state._p(p3600.state.start_at, 4, '^^^')
      end

      love.graphics.setColor(255, 255, 255, 255)

      do
        local offset = 0

        for i = p3600.state.top_entry, #p3600.state.menu_items, 1 do
          if (offset >= (15 - (p3600.state.start_at + 1))) then
            love.graphics.setColor(200, 200, 200, 200)
            p3600.state._p(15, 4, 'vvv')
            love.graphics.setColor(255, 255, 255, 255)
            break
          end

          local e = p3600.state.menu_items[i]

          if not (type(e) == 'table') then
            love.graphics.setColor(200, 200, 200, 255)
            if (type(e) == 'function') then
              p3600.state._p(p3600.state.start_at + 1 + offset, 1, e())
            else
              p3600.state._p(p3600.state.start_at + 1 + offset, 1, e)
            end
            love.graphics.setColor(255, 255, 255, 255)
          else
            if (i == p3600.state.selection) then
              love.graphics.setColor(255, 0, 0, 255)
              if (type(e.label) == 'function') then
                p3600.state._p(p3600.state.start_at + 1 + offset, 4, e.label())
              else
                p3600.state._p(p3600.state.start_at + 1 + offset, 4, e.label)
              end
              love.graphics.setColor(255, 255, 255, 255)

              love.graphics.draw(p3600.state._menu_cursor, 2 * 8,
                                 (p3600.state.start_at + 1 + offset) * 8)
            else
              if (type(e.label) == 'function') then
                p3600.state._p(p3600.state.start_at + 1 + offset, 4, e.label())
              else
                p3600.state._p(p3600.state.start_at + 1 + offset, 4, e.label)
              end
            end
          end

          offset = offset + 1
        end
      end

      if not (p3600.state.on_draw == nil) then
        p3600.state.on_draw()
      end

      p3600.state.changed = false
      p3600.display.changed = true
    end
  end
end
