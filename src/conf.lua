function love.conf(t)
  t.p3600 = {
    developer = true,

    invert_run = false, -- If true, hold the 'run' key to walk.

    keybinds = {
      -- 'mouse1' is used for up/down/left/right depending on where the
      -- cursor is. Do not bind it.
      world = {
        ['w']      = 'up',
        ['up']     = 'up',
        ['s']      = 'down',
        ['down']   = 'down',
        ['a']      = 'left',
        ['left']   = 'left',
        ['d']      = 'right',
        ['right']  = 'right',
        ['space']  = 'interact',
        ['e']      = 'inventory',
        ['escape'] = 'pause',
        ['lshift'] = 'run',
        ['mouse2'] = 'run',
        ['c']      = 'combat',
      },

      combat = {
        ['w']      = 'up',
        ['up']     = 'up',
        ['s']      = 'down',
        ['down']   = 'down',
        ['a']      = 'left',
        ['left']   = 'left',
        ['d']      = 'right',
        ['right']  = 'right',
        ['space']  = 'attack',
        ['escape'] = 'pause',
        ['lshift'] = 'guard',
        ['mouse2'] = 'guard',
        ['c']      = 'end_combat',
      },

      menu = {
        ['up']     = 'up',
        ['w']      = 'up',
        ['down']   = 'down',
        ['s']      = 'down',
        ['d']      = 'right',
        ['right']  = 'right',
        ['left']   = 'left',
        ['a']      = 'left',
        ['return'] = 'select',
        ['mouse2'] = 'select',
        ['space']  = 'select',
        ['escape'] = 'back',
      },

      editor = {
        ['up']     = 'up',
        ['down']   = 'down',
        ['left']   = 'left',
        ['right']  = 'right',
        ['return'] = 'menu',
        ['space']  = 'repeat',
        ['escape'] = 'exit',
      },
    },
  }

  t.console = false                   -- Attach a console (boolean, Windows only)

  t.externalstorage = true            -- True to save files (and read from the save directory) in external storage on Android (boolean) 

  t.window.width = 640                -- The window width (number)
  t.window.height = 480               -- The window height (number)
  t.window.borderless = false         -- Remove all border visuals from the window (boolean)
  t.window.minwidth = 10              -- Minimum window width (number)
  t.window.minheight = 10             -- Minimum window height (number)
  t.window.fullscreen = false         -- Enable fullscreen (boolean)
  t.window.fullscreentype = "desktop" -- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
  t.window.vsync = true               -- Enable vertical sync (boolean)
  t.window.msaa = 0                   -- The number of samples to use with multi-sampled antialiasing (number)
  t.gammacorrect = false              -- Enable gamma-correct rendering, when supported by the system (boolean)
  t.window.display = 1                -- Index of the monitor to show the window in (number)
  t.window.highdpi = false            -- Enable high-dpi mode for the window on a Retina display (boolean)
  t.window.x = nil                    -- The x-coordinate of the window's position in the specified display (number)
  t.window.y = nil                    -- The y-coordinate of the window's position in the specified display (number)

  -- only developers will need to change the values below

  t.identity = 'p3600'                -- The name of the save directory (string)
  t.version = "0.10.1"                -- The LÖVE version this game was made for (string)
  t.accelerometerjoystick = false     -- Enable the accelerometer on iOS and Android by exposing it as a Joystick (boolean)
  t.window.title = "p3600"            -- The window title (string)
  t.window.icon = '/data/icon.tga'    -- Filepath to an image to use as the window's icon (string)
  t.window.resizable = true           -- Let the window be user-resizable (boolean)

  -- optional modules
  t.modules.joystick = false
  t.modules.mouse    = false
  t.modules.touch    = false
  t.modules.window   = true

  -- required modules
  t.modules.event    = true
  t.modules.graphics = true
  t.modules.image    = true
  t.modules.keyboard = true
  t.modules.math     = true
  t.modules.timer    = true

  -- unused modules
  t.modules.audio    = false
  t.modules.physics  = false
  t.modules.sound    = false
  t.modules.system   = false
  t.modules.thread   = false
  t.modules.video    = false
end
