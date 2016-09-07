require 'p3600'

return function()
  require('p3600.display.dialog')({
    text = {
      'Okey dokey!',
      '',
      'I call it Mr. Stabby, because I can!',
    },

    choices = {
      {
        label = 'Stab ALL the things!',
        action = function()
          require('p3600.display.end_dialog')()
          p3600.pop_state()

          local sword = p3600.gstate.entity[1]:search_inv('sao_shortsword')
          sword = p3600.gstate.entity[1]:take(sword)
          p3600.gstate.entity[0]:give(sword)
        end,
      },

      {
        label = 'On second thought...',
        action = require('p3600.sp_entity.1.dialog.init_weapon.long_sword'),
      },
    },
  })
end
