return function()
  p3600.display.dialog{
    text = {
      "You don't remember?!",
      '...',
      "Well, I'm lost, so I guess you are too. ;P",
      '',
      "We're in a HUGE forest.",
    },

    choices = {
      {
        label = '(back)',
        action = function()
          p3600.pop_state()
        end,
      }
    },
  }
end
