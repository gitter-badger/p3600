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

  p3600.display.menu(m)
end
