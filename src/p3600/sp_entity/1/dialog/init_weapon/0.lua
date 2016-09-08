return function()
  p3600.push_state()
  p3600.display.dialog{
    text = {
      'Hey, wait up!',
      "You don't have a weapon, do you?",
    },

    choices = {
      {
        label = 'Nope.',
        action = p3600.sp_entity[1].dialog.init_weapon[1],
      },

      {
        label = 'My fists are all I need.',
        action = p3600.sp_entity[1].dialog.init_weapon.unarmed,
      },
    },
  }
end
