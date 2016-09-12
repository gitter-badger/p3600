return function()
  local function make_menu(m)
    local i = 1

    m[i] = 'Equipment'
    i = i + 1

    for idx, item in ipairs(p3600.gstate.entity[0].inventory.wearing) do
      local itm = item.data

      m[i] = {
        label = itm.name,
        action = function()
          p3600.push_state()
          return p3600.display.menu(m.make_item_menu(true, idx))
        end,
      }
      i = i + 1
    end

    m[i] = 'Items'
    i = i + 1

    for idx = 1, #p3600.gstate.entity[0].inventory, 1 do
      local itm = p3600.gstate.entity[0].inventory[idx].data

      m[i] = {
        label = itm.name,
        action = function()
          p3600.push_state()
          return p3600.display.menu(m.make_item_menu(false, idx))
        end,
      }
      i = i + 1
    end

    m[i] = ''
    i = i + 1

    m[i] = {
      label = 'Exit',
      action = p3600.pop_state,
    }
    i = i + 1

    m[i] = nil
  end

  local m = {
    make_menu = make_menu, -- for onreturn()
    make_item_menu = function(equipped, idx) -- for make_menu
      local mnu = {
        back = p3600.pop_state,

        start_row = 8,

        init = function()
          local itm
          if (equipped) then
            itm = p3600.gstate.entity[0].inventory.wearing[idx]
          else
            itm = p3600.gstate.entity[0].inventory[idx]
          end

          p3600.state.item = itm.data

          p3600.state.item_icon = love.graphics.newImage(
           '/data/item/'..itm.id..'.tga')
        end,

        draw = function()
          love.graphics.draw(p3600.state.item_icon, 1, 1)

          p3600.state._p(1, 2, p3600.state.item.name)

          for line, text in pairs(p3600.state.item.description) do
            p3600.state._p(2 + line, 3, text)
          end
        end,
      }

      if (equipped) then
        mnu[#mnu + 1] = {
          label = 'Unequip',
          action = function()
            p3600.pop_state()
            p3600.state.inv_changed = true
            p3600.gstate.entity[0]:unequip(idx)
            p3600.reload_sprites(p3600.gstate.entity[0])
          end,
        }
      else
        local itm = p3600.gstate.entity[0].inventory[idx].data
        if (itm.equipment) then
          mnu[#mnu + 1] = {
            label = 'Equip',
            action = function()
              p3600.pop_state()
              p3600.state.inv_changed = true
              p3600.gstate.entity[0]:equip(idx)
              p3600.reload_sprites(p3600.gstate.entity[0])
            end,
          }
        end
      end

      mnu[#mnu + 1] = {
        label = 'Back',
        action = p3600.pop_state,
      }

      return mnu
    end,

    back = p3600.pop_state,

    init = function()
      p3600.state.inv_changed = false
    end,

    onreturn = function()
      if (p3600.state.inv_changed) then
        p3600.state.changed = true
        return p3600.state.menu_items.make_menu(p3600.state.menu_items)
      end
    end,
  }

  make_menu(m)

  return p3600.display.menu(m)
end
