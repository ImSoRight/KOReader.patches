--[[ User patch for Project Title plugin to add complete status icon in mosaic view ]]--

local userpatch = require("userpatch")
local IconWidget = require("ui/widget/iconwidget")
local Screen = require("device").screen

local function patchCoverBrowserCompleteIcon(plugin)
    -- Grab Cover Grid mode and the individual Cover Grid items
    local MosaicMenu = require("mosaicmenu")
    local MosaicMenuItem = userpatch.getUpValue(MosaicMenu._updateItemsBuildUI, "MosaicMenuItem")

    -- Store original MosaicMenuItem paintTo method
    local orig_MosaicMenuItem_paint = MosaicMenuItem.paintTo
    
    -- Override paintTo method to add complete status icon
    function MosaicMenuItem:paintTo(bb, x, y)
        -- Call the original paintTo method to draw the cover normally
        orig_MosaicMenuItem_paint(self, bb, x, y)
        
        -- Get the cover image widget (target) and dimensions
        local target = self[1][1][1]
        if not target or not target.dimen then
            return
        end
		
        -- Add complete status icon for books marked as complete
        if self.status == "complete" then
            local left_margin = Screen:scaleBySize(10)
            local radius = Screen:scaleBySize(10)
            local top_margin = Screen:scaleBySize(10)

            -- Use target.dimen.x and target.dimen.y which are relative to the cell
            local center_x = target.dimen.x + left_margin + radius
            local center_y = target.dimen.y + top_margin + radius

            -- Create the complete icon
            local complete_mark = IconWidget:new{
                icon = "complete",
                width = Screen:scaleBySize(25),
                height = Screen:scaleBySize(25),
                alpha = true,
            }

            -- Position icon centered
            local icon_x = center_x - math.floor(complete_mark.width / 2)
            local icon_y = center_y - math.floor(complete_mark.height / 2)

            complete_mark:paintTo(bb, icon_x, icon_y)
        end
    end
end

userpatch.registerPatchPluginFunc("coverbrowser", patchCoverBrowserCompleteIcon)