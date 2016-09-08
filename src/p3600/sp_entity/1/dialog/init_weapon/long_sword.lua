return function()
  require('p3600.display.dialog')({
    text = {
      'Okey dokey!',
      '...',
      "No, those aren't blood stains.",
      'Probably.',
    },

    choices = {
      {
        label = 'Feels like rust...',
        action = function()
          require('p3600.display.end_dialog')()
          p3600.pop_state()

          local sword = p3600.gstate.entity[1]:search_inv('sao_longsword')
          sword = p3600.gstate.entity[1]:take(sword)
          p3600.gstate.entity[0]:give(sword)
        end,
      },
    },
  })
end
