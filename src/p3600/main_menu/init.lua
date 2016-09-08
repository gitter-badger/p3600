return function()
  local m = {
    init = function()
      p3600.state.new_game = {
        start = false,
      }
    end,

    back = p3600.pop_state,

    {
      label = 'New Game',
      action = require('p3600.main_menu.new_game'),
    },

    {
      label = 'Load Game',
      action = require('p3600.main_menu.load_game'),
    },

    {
      label = 'Exit',
      action = p3600.pop_state,
    },
  }

  if (p3600.cfg.developer) then
    m[#m + 1] = ''

    m[#m + 1] = 'Developer Stuff:'

    m[#m + 1] = {
      label = 'Area Editor',
      action = function()
        require('p3600.editor')(nil, true)
      end
    }
  end

  require('p3600.display.menu')(m)
end
