return function()
  local t = {
    text = {},
    choices = {
      {
        label = 'O...k..?',
        action = function()
          p3600.display.end_dialog()
          p3600.pop_state()
        end,
      },
    },
  }

  t.text[#t.text + 1] = "Anyway, I'm bored and you seem interesting,"
  t.text[#t.text + 1] = "so I'm gonna follow you until I find"
  t.text[#t.text + 1] = 'something more interesting.'

  p3600.display.dialog(t)
end
