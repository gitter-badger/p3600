return function()
  local one_of = require('misc.one_of')

  local t = {
    text = {},
    choices = {
      {
        label = 'I have no idea what happened.',
        action = p3600.sp_entity[1].dialog.init_clearing[3],
      },
    },
  }

  t.text[#t.text + 1] = 'Gee, I dunno!'
  if not (one_of(p3600.gstate.entity[0].race, 11, 17, 18)) then
    t.text[#t.text + 1] = "I just found you laying here, and you didn't"
    t.text[#t.text + 1] = 'have a pulse!'
    t.choices[#t.choices + 1] = {
      label = 'How did you revive me?',
      action = p3600.sp_entity[1].dialog.init_clearing[4],
    }
  else
    t.text[#t.text + 1] = "I just found you laying here, and you weren't"
    t.text[#t.text + 1] = 'moving!'
  end

  p3600.display.dialog(t)
end
