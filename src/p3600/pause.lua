return function(can_save)
  local i = {
    back = function()
      p3600.pop_state()
    end,

    {
      label = 'Continue',
      action = function()
        p3600.pop_state()
      end,
    },

    {
      label = 'Save Game',
      action = function()
        p3600.save_game()
        p3600.state.menu_items[2].label = 'SAVED'
      end,
    },

    {
      label = 'Quit',
      action = function()
        love.event.quit(0)
      end,
    },
  }

  if not (can_save) then
    i[2] = "Can't save here."
  end

  p3600.push_state()
  p3600.display.menu(i)
end
