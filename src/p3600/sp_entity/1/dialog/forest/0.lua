local random = require('math').random

return function()
  local ch = {
    {
      label = 'What should I do?',
      action = function()
        local t = {
          'Well, I was heading to a town to the west.',
          '',
        }

        if (p3600.gstate.entity[1].is_known) then
          t[#t + 1] = 'Unfortunately, someone saw me fly in and almost'
          t[#t + 1] = 'shot me. Now the whole town is on lockdown!'
          t[#t + 1] = ''
          t[#t + 1] = 'Can you help me find a way in?'
          t[#t + 1] = "It's really important that I meet someone"
          t[#t + 1] = 'in there soon!'
          t[#t + 1] = ''
          t[#t + 1] = "Please? I'll pay you!"
        else
          t[#t + 1] = "But the gates are closed, so I'm stuck here"
          t[#t + 1] = 'waiting for them to forget-- waiting for them'
          t[#t + 1] = 'to open.'
          t[#t + 1] = ''
          t[#t + 1] = 'Maybe you know of another way in?'
          t[#t + 1] = "I won't tell anyone if you do!"
          t[#t + 1] = '...'
          t[#t + 1] = 'Please?'
        end

        return p3600.display.dialog{
          text = t,
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
      end,
    },
  }

  p3600.sp_entity[1].dialog.append_misc(ch)

  if
   (p3600.gstate.entity[1].is_known) and
   (p3600.state.can_ask_about_animosity)
  then
    ch[#ch + 1] = {
      label = "What's the big deal with shapeshifters?",
      action = function()
        return p3600.display.dialog{
          text = {
            'Think about it:',
            'I can pretend to be just about anyone, and',
            "go places I shouldn't.",
            "I might see something I shouldn't, and",
            'tell someone. Shapeshifters make the best',
            'spies, and humans are terrified that we',
            'might care about what they do in private.',
            '',
            "Personally, I've only spied on one person.",
            "That person is bad, though, and now I'm",
            'telling someone.',
            '',
            '... But not you. ;3',
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
      end,
    }
  end

  ch[#ch + 1] = {
    label = 'Nevermind.',
    action = function()
      p3600.display.end_dialog()
      p3600.pop_state()
    end,
  }

  local responses = {
    {
      'Yes?',
    },
    {
      'Did you need something?',
    },
  }

  p3600.push_state()

  p3600.display.dialog{
    text = responses[random(#responses)],
    choices = ch,
  }
end
