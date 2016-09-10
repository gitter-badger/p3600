return function()
  local pc = p3600.gstate.entity[0]
  local saoi = p3600.gstate.entity[1]

  do
    local case = {
      [4] = function()
        return p3600.sp_entity[1].dialog.forest[0]()
      end,
    }
    case[2] = case[4]

    if not (case[saoi.progress.main] == nil) then
      saoi.dir = pc.dir + 2
      if (saoi.dir > 3) then
        saoi.dir = saoi.dir - 4
      end
      love.draw()

      return case[saoi.progress.main]()
    end
  end
end
