return function(restore, init) -- init is only true if called from intro
  if (init) then
    p3600.gstate.entity[1] = p3600.sp_entity[1].new
  end
end
