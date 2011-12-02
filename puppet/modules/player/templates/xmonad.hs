import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Config.Xfce
import XMonad.Layout.NoBorders
import XMonad.Layout.TwoPane
import XMonad.Layout.WindowNavigation
import XMonad.Layout.IM
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import Data.Ratio ((%))
import System.IO




main = do
    xmonad $ xfceConfig {
         borderWidth        = 2,
         normalBorderColor  = "#cccccc",
         focusedBorderColor = "#cd8b00",
         workspaces = [ "cockpit", "admin" ],
         manageHook = composeAll [ className =? "Pd" --> doShift "admin",
	                           manageDocks ] <+> manageHook defaultConfig,
         layoutHook = windowNavigation $ Mirror (avoidStruts ( withIM (60%80) (ClassName "Mixxx") tiled ||| withIM (1%80) (ClassName "Pd") tiled ))
         }
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 2     -- The default number of windows in the master pane
     ratio   = 1/2   -- Default proportion of screen occupied by master pane
     delta   = 3/100 -- Percent of screen to increment by when resizing panes
