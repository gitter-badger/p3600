require 'p3600'

return function()
  local function make_menu(m)
    local i = 1

    m[i] = 'Equipment'
    i = i + 1

    for idx, item in ipairs(p3600.gstate.entity[0].inventory.wearing) do
      local itm = require('p3600.item.'..item.id)

      m[i] = {
        label = itm.name,
        action = function()
          p3600.push_state()
          return require('p3600.display.menu')(m.make_item_menu(true, idx))
        end,
      }
      i = i + 1
    end

    m[i] = 'Items'
    i = i + 1

    for idx = 1, #p3600.gstate.entity[0].inventory, 1 do
      local itm = require('p3600.item.'..
                          p3600.gstate.entity[0].inventory[idx].id)

      m[i] = {
        label = itm.name,
        action = function()
          p3600.push_state()
          return require('p3600.display.menu')(m.make_item_menu(false, idx))
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
        start_row = 16,
      }

      if (equipped) then
        mnu[#mnu + 1] = {
          label = 'Unequip',
          action = function()
            p3600.pop_state()
            p3600.state.inv_changed = true
            local inv = p3600.gstate.entity[0].inventory
            local inv_e = p3600.gstate.entity[0].inventory.wearing
            inv[#inv + 1] = inv_e[idx]
            table.remove(inv_e, idx)
          end,
        }
      else
        local itm = require('p3600.item.'..
                            p3600.gstate.entity[0].inventory[idx].id)
        if (itm.equipment) then
          mnu[#mnu + 1] = {
            label = 'Equip',
            action = function()
              p3600.pop_state()
              p3600.state.inv_changed = true
              local inv = p3600.gstate.entity[0].inventory
              local inv_e = p3600.gstate.entity[0].inventory.wearing
              inv_e[#inv_e + 1] = inv[idx]
              table.remove(inv, idx)
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

  return require('p3600.display.menu')(m)
end
