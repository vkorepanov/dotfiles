--
-- xmonad.xs - xmonad configuration file.
-- Copyright (C) 2016-2017 Korepanov Vyacheslav <real93@live.ru>
--
-- Distributed under terms of the MIT license.
-- This file based on the default xmonad config example file.
--

import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import System.Process
import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

defaultMasterVolume :: String
defaultMasterVolume = "35"

defaultTerminal :: String
defaultTerminal = "alacritty"

-- Don't focus windows by mouse cursor. Explicit focus by clicking on the window
isFocusFollowsMouse :: Bool
isFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
isClickJustFocuses :: Bool
isClickJustFocuses = False

-- Width of the window border in pixels.
defaultBorderWidth = 2

-- Use meta (win) key as modifier.
-- Some possible values are:
--   mod1Mask - left alt
--   mod3Mask - right alt
--   mod4Mask - meta (windows key)
defaultModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
webWs   = "1:web"
gamesWs = "8:games"
infoWs  = "9:info"

-- The number of workspaces is determined by the length of this list.
defaultWorkspaces = webWs : map show [2..7] ++ [gamesWs, infoWs]

-- Border colors for unfocused and focused windows, respectively.
defaultNormalBorderColor  = "#99CC99"
defaultFocusedBorderColor = "#6699CC"

-- Color of current window title in xmobar.
xmobarTitleColor = "#66CCCC"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#6699CC"

urgencyColor = "#F99157"

-- Key bindings.
defaultKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- Launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)
    -- Launch chromium browser
    , ((modm .|. shiftMask, xK_b     ), spawnChromium)
    -- Launch file manager by using xdg-open
    , ((modm,               xK_e     ), spawn "xdg-open ~/")
    -- Launch dmenu
    , ((modm,               xK_d     ), spawn "dmenu_run")
    -- Launch rofi
    , ((modm .|. shiftMask, xK_d     ), spawn "rofi -show run")
    -- Close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
    -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
    -- Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_p     ), io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((modm              , xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    -- Lock the screen
    , ((modm .|. shiftMask, xK_l     ), spawn "xscreensaver-command --lock")
    -- Sleep key. Then it pressed just disable a monitor.
    , ((0                 , xF86XK_Sleep), spawn "xset dpms force off")
    -- Multimedia "Play" key
    , ((0                 , xF86XK_AudioPlay), spawn "clementine -t")
    -- Multimedia "Mute" key
    , ((0                 , xF86XK_AudioMute), spawn "amixer --device pulse set Master toggle")
    -- Meta + "Mute"
    , ((modm              , xF86XK_AudioMute), spawn ("amixer --device pulse set Master " ++ defaultMasterVolume ++ "%"))
    -- Multimedia "Previous" key
    , ((0                 , xF86XK_AudioPrev), spawn "clementine --previous")
    -- Multimedia "Next" key
    , ((0                 , xF86XK_AudioNext), spawn "clementine --next")
    -- Multimedia "Volume up" key
    , ((0                 , xF86XK_AudioRaiseVolume), spawn "clementine --volume-increase-by 5")
    -- Multimedia "Volume down" key
    , ((0                 , xF86XK_AudioLowerVolume), spawn "clementine --volume-decrease-by 5")
    -- Multimedia "Volume up" key with mod key will change system volume.
    , ((modm              , xF86XK_AudioRaiseVolume), spawn "amixer --device pulse set Master 2%+")
    -- Multimedia "Volume down" key with mod key will change system volume.
    , ((modm              , xF86XK_AudioLowerVolume), spawn "amixer --device pulse set Master 2%-")
    ]
    ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{q,w}, Switch to physical/Xinerama screens 1 or 2
    -- mod-shift-{q,w}, Move client to screen 1 or 2
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_q, xK_w] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- Mouse bindings: default actions bound to mouse events
defaultMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    -- select with scroll window transparency
    , ((modm, button4), \w -> spawn "transset -p --inc 0.1")
    , ((modm, button5), \w -> spawn "transset -p --dec 0.1")
    ]

-- The available layouts. Note that each layout is separated by |||,
-- which denotes layout choice.
defaultLayout = smartBorders tiled ||| noBorders Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = spacing pix $ Tall nmaster delta ratio
    -- The number of pixels between panes
    pix     = 3
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
    -- Percent of screen to increment by when resizing panes
    delta   = 5/100

-- Window rules
defaultManageHook = manageSpawn <+> composeAll
    [ className =? "Chromium"       --> doShift webWs
    , className =? "Gimp"           --> doFloat
    , className =? "MPlayer"        --> doFloat
    , className =? "Nvidia-settings"--> doShift infoWs
    , className =? "SKGuiModeling"  --> doFloat
    , className =? "Steam"          --> doShift gamesWs
    , className =? "ksysguard"      --> doShift infoWs
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "stalonetray"    --> doIgnore
    , isFullscreen                  --> doFullFloat
    , isDialog                      --> doCenterFloat
    ]

-- Event handling
defaultEventHook = fullscreenEventHook <+> ewmhDesktopsEventHook

-- Status bars and logging
defaultLogHook = return ()

withNotSpawnedProcess :: MonadIO m => String -> (String -> m ()) -> m ()
withNotSpawnedProcess cmd f = do
    pidofResult <- (liftIO $ readProcessWithExitCode "pidof" [head . words $ cmd] ""
                         >>= (\(ec, _, _) -> return ec))
    case pidofResult of
        ExitSuccess -> return ()
        _           -> f cmd

-- TODO: implement search of processes and not run command if process already exists.
spawnIfNoProcess :: MonadIO m => String -> m ()
-- spawnIfNoProcess cmd = withNotSpawnedProcess cmd spawn
spawnIfNoProcess = spawn

spawnOnIfNoProcess :: WorkspaceId -> String -> X ()
-- spawnOnIfNoProcess ws cmd = withNotSpawnedProcess cmd (spawnOn ws)
spawnOnIfNoProcess = spawnOn

chromiumExecutable = "chromium-browser"

spawnChromium :: X ()
spawnChromium = spawnOnIfNoProcess webWs $ chromiumExecutable
    ++ " --enable-native-gpu-memory-buffers --enable-features=\"CheckerImaging\""

-- Startup hook
defaultStartupHook = do
    setWMName "LG3D"
    spawnIfNoProcess "feh --bg-fill .background_image"
    spawnIfNoProcess "xsetroot -cursor_name left_ptr"
    -- Compositing effects.
    spawnIfNoProcess "compton -bcCf -i 0.8 -D 0 --shadow-blue 0.15 --inactive-dim 0.3"
    spawnChromium
    spawnIfNoProcess "pkill stalonetray; stalonetray"
    spawnIfNoProcess "numlockx"
    -- spawnIfNoProcess "xscreensaver"
    spawnIfNoProcess "sleep 1 && transset -n stalonetray 0.784314"
    spawnIfNoProcess "clementine"
    spawnOnIfNoProcess "2"     "telegram-desktop"
    spawnOnIfNoProcess gamesWs "steam"
    spawnOnIfNoProcess infoWs  "nvidia-settings"

defaultXmobarPP = xmobarPP
    { ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "" . wrap "<fn=3>[" "]</fn>"
    , ppUrgent  = xmobarColor urgencyColor ""
    , ppSep     = " | "
    , ppTitle   = xmobarColor xmobarTitleColor "" . shorten 60 .wrap "" ""
    }

main = do
    cfg <- statusBar "xmobar" defaultXmobarPP
           (\c -> (modMask c, xK_f)) . withUrgencyHook (BorderUrgencyHook urgencyColor)
           $ defaults
    xmonad cfg

defaults = def {
    terminal           = defaultTerminal
  , focusFollowsMouse  = isFocusFollowsMouse
  , clickJustFocuses   = isClickJustFocuses
  , borderWidth        = defaultBorderWidth
  , modMask            = defaultModMask
  , workspaces         = defaultWorkspaces
  , normalBorderColor  = defaultNormalBorderColor
  , focusedBorderColor = defaultFocusedBorderColor
  , keys               = defaultKeys
  , mouseBindings      = defaultMouseBindings
  , layoutHook         = defaultLayout
  , manageHook         = defaultManageHook
  , handleEventHook    = defaultEventHook
  , logHook            = defaultLogHook
  , startupHook        = defaultStartupHook
  }

help :: String
help = unlines [
    "The default modifier key is 'meta'. Default keybindings:"
  , ""
  , "-- launching and killing programs"
  , "mod-Enter          Launch terminal"
  , "mod-d              Launch dmenu"
  , "mod-Shift-d        Launch rofi"
  , "mod-Shift-c        Close/kill the focused window"
  , "mod-Space          Rotate through the available layout algorithms"
  , "mod-Shift-Space    Reset the layouts on the current workSpace to default"
  , "mod-n              Resize/refresh viewed windows to the correct size"
  , ""
  , "-- move focus up or down the window stack"
  , "mod-Tab            Move focus to the next window"
  , "mod-Shift-Tab      Move focus to the previous window"
  , "mod-j              Move focus to the next window"
  , "mod-k              Move focus to the previous window"
  , "mod-m              Move focus to the master window"
  , ""
  , "-- modifying the window order"
  , "mod-Shift-Return   Swap the focused window and the master window"
  , "mod-Shift-j        Swap the focused window with the next window"
  , "mod-Shift-k        Swap the focused window with the previous window"
  , ""
  , "-- resizing the master/slave ratio"
  , "mod-h              Shrink the master area"
  , "mod-l              Expand the master area"
  , ""
  , "-- floating layer support"
  , "mod-t              Push window back into tiling; unfloat and re-tile it"
  , ""
  , "-- increase or decrease number of windows in the master area"
  , "mod-comma  (mod-,) Increment the number of windows in the master area"
  , "mod-period (mod-.) Deincrement the number of windows in the master area"
  , ""
  , "-- quit, or restart"
  , "mod-Shift-p        Quit xmonad"
  , "mod-r              Restart xmonad"
  , "mod-[1..9]         Switch to workSpace N"
  , ""
  , "-- Workspaces & screens"
  , "mod-Shift-[1..9]   Move client to workspace N"
  , "mod-{q,w}          Switch to physical/Xinerama screens 1, 2"
  , "mod-Shift-{q,w}    Move client to screen 1, 2"
  , ""
  , "-- Mouse bindings: default actions bound to mouse events"
  , "mod-button1        Set the window to floating mode and move by dragging"
  , "mod-button2        Raise the window to the top of the stack"
  , "mod-button3        Set the window to floating mode and resize by dragging"
  , "mod-scroll         Setup window transparency"
  ]
