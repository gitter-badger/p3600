return function(dt)
  local pc = p3600.gstate.entity[0]
  local saoi = p3600.gstate.entity[1]

  do
    local s_main = {
      [0] = function()
        saoi.progress.main = 1
        pc.can_move = true
        p3600.sp_entity[1].dialog.init_clearing[0]()
      end,

      [1] = function()
        saoi.progress.main = 2
        saoi.following = {
          id = 0,
          distance = 3,
        }
        if (pc.followers == nil) then
          pc.followers = {}
        end
        pc.followers[#pc.followers + 1] = 1

        -- game file must exist on disk before procedural generation starts
        -- this is as good a place as any to ensure it is saved
        p3600.save_game()
        love.filesystem.mount('/save/'..p3600.gstate.entity[0].name, '/', false)
      end,

      [2] = function()
        if (p3600.gstate.entity[0].pos.x < 5) then
          pc.can_move = false
          saoi.following.distance = 1
          saoi.progress.main = 3
        end
      end,

      [3] = function()
        local math = require('math')

        if
         (math.abs(saoi.pos.x - pc.pos.x) <= 1.2) and
         (math.abs(saoi.pos.y - pc.pos.y) <= 1.2)
        then
          saoi.progress.main = 4
          saoi.following.distance = 3
          pc.can_move = true
          p3600.sp_entity[1].dialog.init_weapon[0]()
        end
      end,
    }

    if not (s_main[saoi.progress.main] == nil) then
      s_main[saoi.progress.main]()
    end
  end
end
