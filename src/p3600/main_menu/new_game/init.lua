require 'p3600'

return function()
  p3600.push_state()
  require('p3600.display.menu')({
    init = function()
      p3600.state.r = require('p3600.race')
      p3600.state.name = ''
      p3600.state.race = 0
      p3600.state.sex = 1
    end,

    back = function()
      p3600.pop_state()
    end,

    {
      label = function()
        return 'Name: '..p3600.state.name
      end,
      action = function()
        local setname = function(str)
          p3600.state.name = str
        end
        require('p3600.display.text_input')(2, 10, setname, p3600.state.name,
                                            {r = 0, b = 0, g = 0})
      end,
    },

    {
      label = function()
        return 'Race: '..p3600.state.r[p3600.state.race].singular
      end,
      action = require('p3600.main_menu.new_game.race'),
    },

    {
      label = function()
        local t = {
          [0] = 'n/a',
          [1] = 'male',
          [2] = 'female',
          [3] = 'both',
        }
        return 'Sex: '..t[p3600.state.sex]
      end,
      action = function()
        repeat
          p3600.state.sex = p3600.state.sex + 1
          if (p3600.state.sex > 3) then
            p3600.state.sex = 0
          end
        until (p3600.state.r[p3600.state.race].sexes[p3600.state.sex])
      end,
    },

    '',

    'All done?',

    {
      label = 'Wake up...',
      action = function()
        p3600.state_stack.state.new_game.start = true
        p3600.gstate = {
          entity = {
            [0] = require('p3600.Entity'){
              eid = 0,
              name = p3600.state.name,
              race = p3600.state.race,
              sex = p3600.state.sex,
              speed_mod = 1,
              dir = 1,
              can_move = false,
            },
          },
        }

        p3600.gstate.entity[0].pos = {
          x = 13,
          y = 13,
          area = 'clearing',
        }

        --p3600.gstate.entity[0]:give(require('p3600.Item')('tunic'))
        p3600.gstate.entity[0]:give('tunic')

        p3600.init_state_stack()
        require('p3600.transition.intro')()
      end,
    },

    {
      label = 'Keep sleeping (abort)',
      action = function()
        p3600.pop_state()
      end,
    },
  })
end
