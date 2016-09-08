return function()
  p3600.display.dialog{
    text = {
      "You'll need _something_...",
      'Oh, you can borrow one of my swords!',
      'Would you prefer the long one, or the short one?',
    },

    choices = {
      {
        label = 'The long one? (Start with balanced skills.)',
        action = p3600.sp_entity[1].dialog.init_weapon.long_sword,
      },

      {
        label = 'The short one. (I hope you like running!)',
        action = p3600.sp_entity[1].dialog.init_weapon.mr_stabby,
      },
    },
  }
end
