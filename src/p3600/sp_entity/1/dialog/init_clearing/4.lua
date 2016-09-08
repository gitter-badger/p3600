return function()
  local one_of = require('misc.one_of')

  local t = {
    text = {},
    choices = {
      {
        label = '...',
        action = require('p3600.sp_entity.1.dialog.init_clearing.3'),
      },
    },
  }

  t.text[#t.text + 1] = 'Oh!'
  if (one_of(p3600.gstate.entity[0].race, 9)) then
    t.text[#t.text + 1] = 'I just hit you with a thunder ball!'
    t.text[#t.text + 1] = "Nothing a little jolt can't fix, eh?"
    t.text[#t.text + 1] = ''
    t.text[#t.text + 1] = "I might've singed your ear, by the way."
    t.text[#t.text + 1] = '(I also destroyed a tree...)'
  else
    t.text[#t.text + 1] = 'Um...'
    t.text[#t.text + 1] = "I forgot?"
  end

  require('p3600.display.dialog')(t)
end
