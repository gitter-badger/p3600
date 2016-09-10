return function(entity)
  if (entity.special) then
    return p3600.sp_entity[entity.eid].interact()
  elseif not (p3600.state.interact_handlers == nil) then
    if not (p3600.state.interact_handlers[entity.eid] == nil) then
      return p3600.state.interact_handlers[entity.eid](entity)
    end
  end
end
