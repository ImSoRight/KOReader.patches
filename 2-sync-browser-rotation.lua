local ReaderUI = require("apps/reader/readerui")
local Screen = require("device").screen

-- Patch ReaderUI to save current rotation as fm_rotation_mode when closing
local function patchReaderUI()
    local originalOnClose = ReaderUI.onClose
    
    function ReaderUI:onClose(full_refresh)
        -- Save the current rotation for file manager
        G_reader_settings:saveSetting("fm_rotation_mode", Screen:getRotationMode())
        
        -- Call original onClose
        originalOnClose(self, full_refresh)
    end
end

-- Since ReaderUI is used globally, we can call the patch directly
patchReaderUI()