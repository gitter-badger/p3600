return function(choices)
  local saoi = p3600.gstate.entity[1]

  if not (saoi.is_known) then
    choices[#choices + 1] = {
      label = 'What are you?',
      action = function()
        return p3600.sp_entity[1].dialog.misc.dafuq_is_wrong_wit_you()
      end,
    }
  else
  end
end
