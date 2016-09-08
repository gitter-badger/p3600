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
      action = p3600.main_menu.new_game,
    },

    {
      label = 'Load Game',
      action = p3600.main_menu.load_game,
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
        p3600.editor.run(nil, true)
      end
    }
  end

  p3600.display.menu(m)
end
