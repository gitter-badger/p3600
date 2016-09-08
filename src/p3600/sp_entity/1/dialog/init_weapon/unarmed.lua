return function()
  require('p3600.display.dialog')({
    text = {
      'Are you insane?!',
      'Awesome, so am I!',
      '',
      "Let's get going then!",
    },

    choices = {
      {
        label = 'Um...',
        action = function()
          -- TODO: unarmed combat skills
          require('p3600.display.end_dialog')()
          p3600.pop_state()
        end,
      },
    },
  })
end
