local Device = require("device")
local Geom = require("ui/geometry")
local GestureRange = require("ui/gesturerange")
local InfoMessage = require("ui/widget/infomessage")
local InputContainer = require("ui/widget/container/inputcontainer")
local ScreenSaverLockWidget = require("ui/widget/screensaverlockwidget")
local UIManager = require("ui/uimanager")
local util = require("util")
local _ = require("gettext")
local Screen = Device.screen

function ScreenSaverLockWidget:showWaitForGestureMessage()
    -- another widget that we would need to prevent catching events
    local infomsg = InfoMessage:new{
        text = self.has_exit_screensaver_gesture
                    and _("If lost, please contact Jenny at 867-5309.")
                     or _("No exit screensaver gesture configured. Tap to exit.")
    }
    infomsg:paintTo(Screen.bb, 0, 0)
    infomsg:onShow() -- get the screen refreshed
    infomsg:free()

    -- Notify our Resume/Suspend handlers that this is visible, so they know what to do
    self.is_infomessage_visible = true
end