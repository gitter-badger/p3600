local function rndsmell()
  -- repeat things to increase the chances of one being selected
  local smell = {
    'apples', 'apples', 'apples', 'apples', 'apples', 'apples', 'apples',
    'apples', 'apples', 'apples',

    'pears', 'pears', 'pears', 'pears', 'pears', 'pears', 'pears', 'pears',
    'pears', 'pears', 'pears',

    'watermelon', 'watermelon', 'watermelon', 'watermelon', 'watermelon',

    'ozone', 'ozone', 'ozone', 'ozone', 'ozone', 'ozone', 'ozone',

    'tree sap', 'tree sap', 'tree sap', 'tree sap',
  }

  local of_course = { -- included for hilarity
    "yo' momma", "yo' momma", "yo' momma", "yo' momma", "yo' momma",
    'your sister',
    'your brother',
    "yo' papa",
    'dat ass',
    'a bad joke',
    'your hand',
  }

  if (math.random(20) == 9) then
    return of_course[math.random(#of_course)]
  else
    return smell[math.random(#smell)]
  end
end

return {
  id = 'sao_shortsword',
  name = "Saoirse's Shortsword",

  description = {
    'A short, incredibly sharp blade with',
    'a worn-out handle.',
    '',
    'The blade is slightly sticky, and smells',
    'like '..rndsmell()..'...',
  },

  equipment = {
    weight = 0.01,
    weapon = {
      class = 'sword',
      length = 0.3,
      sharpness = 210,
    },
  },
}
