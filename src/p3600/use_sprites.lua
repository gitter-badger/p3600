return function(eid)
  if (p3600.state._sprites_used == nil) then
    p3600.state._sprites_used = {}
  end

  if (p3600.state._sprites_used[eid] == nil) then
    p3600.state._sprites_used[eid] = true

    if not (p3600.sprite_refs[eid] == nil) then
      p3600.sprite_refs[eid] = p3600.sprite_refs[eid] + 1
    else
      p3600.sprite_refs[eid] = 1

      return p3600.reload_sprites(p3600.gstate.entity[eid])
    end
  end
end
