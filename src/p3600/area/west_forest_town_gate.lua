local d = {
  height = 18,
  width  = 25,

  bg = {
    spritesheet = 'bg0',
    data = {
      {5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,0,1,1,1,1,1},
      {5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,0,1,1,1,1,1},
      {0,0,0,0,0,0,0,0,0,0,5,5,0,0,0,0,0,0,0,0,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5},
      {1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    },
  },

  fg = {
    spritesheet = 'bg0',
    data = {
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0},
      {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    },
  },

  tiletypes = {
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  },

  exits = {
    top = 'west_forest_town_1_2',
    right = 'forest_1_2',

    [3] = {
      -- [11] =
      -- [12] =
    },
  },

  entrances = {
    default = {
      player = {
        x = 13,
        y = 13,
      },

      follower = {
        x = 12,
        y = 13,
      },
    },
  },

  onload = function(restore)
    if not (restore) then
      local guard_1 = p3600.Entity{
        race = 0,
      }
      p3600.gstate.entity[#p3600.gstate.entity + 1] = guard_1
      guard_1.eid = #p3600.gstate.entity
      local guard_2 = p3600.Entity{
        race = 0,
      }
      p3600.gstate.entity[#p3600.gstate.entity + 1] = guard_2
      guard_2.eid = #p3600.gstate.entity

      guard_1.pos = {
        x = 10,
        y = 4,
        area = 'west_forest_town_gate',
      }

      guard_2.pos = {
        x = 13,
        y = 4,
        area = 'west_forest_town_gate',
      }
    end

    local ih = function(_)
      p3600.push_state()
      if (p3600.gstate.west_forest_town.gate_open) then
        p3600.display.dialog{
          text = {
            'Guard:',
            '  Welcome.',
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
      else
        local endd = {
          label = '(back)',
          action = function()
            p3600.display.end_dialog()
            p3600.pop_state()
          end,
        }

        local t =  {
          'Guard:',
          "  I'm sorry stranger, but a monster was recently",
          '  spotted close to the walls. Until we recieve',
          '  the all-clear, you must wait outside.',
        }

        if
         (p3600.gstate.entity[1]) and
         (p3600.gstate.entity[1].following) and
         (p3600.gstate.entity[1].following.id == 0)
        then
          t[#t + 1] = ''
          t[#t + 1] = 'Saoirse:'
          t[#t + 1] = '  ...'
        end

        p3600.display.dialog{
          text = t,
          choices = {
            endd,
            {
              label = 'What if the monster gets me?',
              action = function()
                local t = {
                  'Guard:',
                  '  One of us will defend you, of course!',
                  "  We aren't heartless monsters!",
                }

                if
                 (p3600.gstate.entity[1]) and
                 (p3600.gstate.entity[1].following) and
                 (p3600.gstate.entity[1].following.id == 0)
                then
                  t[#t + 1] = ''
                  t[#t + 1] = 'Saoirse:'
                  t[#t + 1] = '  (By the way, this form has a functional'
                  t[#t + 1] = '  heart, and if I was gonna "get" you, I'
                  t[#t + 1] = "  would've done it in the forest.)"
                end

                p3600.display.dialog{
                  text = t,
                  choices = {
                    endd,
                  },
                }
              end,
            },
            {
              label = 'Do I look like a monster to you?',
              action = function()
                p3600.state_stack.state.can_ask_about_animosity = true

                local t = {
                  'Guard:',
                  '  Actually, it was a shapeshifter, so you',
                  '  might be the monster.',
                  '  Shapeshifters get bored quickly, so if you',
                  "  are one, you'll leave soon enough.",
                  "  That's the protocol for dealing with them:",
                  '  just wait a few hours.',
                }

                if
                 (p3600.gstate.entity[1]) and
                 (p3600.gstate.entity[1].following) and
                 (p3600.gstate.entity[1].following.id == 0)
                then
                  t[#t + 1] = ''
                  t[#t + 1] = 'Saoirse:'
                  t[#t + 1] = "  (He's right, any other day I'd be gone"
                  t[#t + 1] = '  by now. But this is important.)'
                end

                p3600.display.dialog{
                  text = t,
                  choices = {
                    endd,
                  },
                }
              end,
            },
          },
        }
      end
    end

    p3600.state.interact_handlers = {
      [#p3600.gstate.entity] = ih,
      [#p3600.gstate.entity - 1] = ih,
    }
  end
}

if (p3600.gstate) then
  if (p3600.gstate.west_forest_town) then
    if (p3600.gstate.west_forest_town.gate_open) then
      d.fg.data[3][11] = 0
      d.fg.data[3][12] = 0
      d.tiletypes[3][11] = 0
      d.tiletypes[3][12] = 0
    end
  else
    p3600.gstate.west_forest_town = {
      gate_open = false,
    }
  end
end

return d
