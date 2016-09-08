return function()
  p3600.push_state()
  p3600.display.dialog{
    text = {
      'Hi there!',
      "You were out for quite a while, I thought I'd",
      'lost you!',
    },

    choices = {
      {
        label = 'Where am I?',
        action = function()
          p3600.push_state()
          p3600.sp_entity[1].dialog.init_clearing[1]()
        end,
      },

      {
        label = 'What happened?',
        action = function()
          p3600.sp_entity[1].dialog.init_clearing[2]()
        end,
      },
    },
  }
end
