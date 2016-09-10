return function()
  p3600.gstate.entity[1].is_known = true

  return p3600.display.dialog{
    text = {
      "I'm a shapeshifter!",
      '...',
      'Huh, normally people run away when I say that.',
    },

    choices = {
      {
        label = '(back)',
        action = function()
          p3600.display.end_dialog()
          p3600.pop_state()
        end,
      },
    },
  }
end
