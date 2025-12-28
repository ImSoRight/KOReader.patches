--[[ User patch for KOReader to draw the star rating on completed books in MosaicMenu]]--

local userpatch = require("userpatch")
local logger = require("logger")
local Screen = require("device").screen
local Blitbuffer = require("ffi/blitbuffer")
local IconWidget = require("ui/widget/iconwidget")
local DocSettings = require("docsettings")

-- Patch function
local function patchStarRating(plugin)
    local BookInfoManager = require("bookinfomanager")
    local BookList = require("ui/widget/booklist")
    local MosaicMenu = require("mosaicmenu")
    -- obtain the MosaicMenuItem class reference used by MosaicMenu
    local MosaicMenuItem = userpatch.getUpValue(MosaicMenu._updateItemsBuildUI, "MosaicMenuItem")
    if not MosaicMenuItem then
        logger.warn("mosaic-rating: could not find MosaicMenuItem upvalue; aborting patch")
        return
    end

    -- Save original paintTo
    local orig_paint = MosaicMenuItem.paintTo
    local corner_mark_size = userpatch.getUpValue(orig_paint, "corner_mark_size") or Screen:scaleBySize(20)

    -- Helper to try caching rating into BookList like other metadata
    local function ensure_rating_cached(self)
        local ok, book_info = pcall(function() return self.menu.getBookInfo(self.filepath) end)
        if not ok or not book_info then return nil end
        -- If rating already present, return it
        if book_info.rating ~= nil then return tonumber(book_info.rating) end
        -- Try to open sidecar via BookList.getDocSettings (will not create sidecar if absent)
        local ok2, doc_settings = pcall(BookList.getDocSettings, self.filepath)
        if ok2 and doc_settings then
            local summary = doc_settings:readSetting("summary") or {}
            local rating_val = summary and summary.rating and tonumber(summary.rating)
            if rating_val and rating_val > 0 then
                -- Cache into BookList cache
                pcall(BookList.setBookInfoCacheProperty, self.filepath, "rating", rating_val)
                return rating_val
            end
        end
        return nil
    end

    function MosaicMenuItem:paintTo(bb, x, y)
        -- call original first to render existing UI
        orig_paint(self, bb, x, y)

        -- find cover target
        local target = self[1] and self[1][1] and self[1][1][1]
        if not target or not target.dimen then return end

        -- only show for completed books
        if self.status ~= "complete" then return end

        -- try to get rating from menu cache or sidecar
        local rating = nil
        local ok, book_info = pcall(function() return self.menu.getBookInfo(self.filepath) end)
        if ok and book_info and tonumber(book_info.rating) then
            rating = tonumber(book_info.rating)
        else
            -- try BookInfoManager DB side (unlikely to have summary) or ensure caching
            rating = ensure_rating_cached(self)
        end

        if not rating or rating <= 0 then return end

        -- draw only filled stars (integer part), centered within the cover area
        local max_stars = 5
        local draw_stars = math.min(math.floor(rating), max_stars)
        if draw_stars <= 0 then return end

        local star_size = math.floor(corner_mark_size)
        local stars_width = draw_stars * star_size
        -- center within the target widget
        local margin = math.floor((target.dimen.w - stars_width) / 2)
        local pos_x = x + math.ceil((self.width - target.dimen.w) / 2) + margin
        -- small bottom margin so stars are not flush with the bottom
        local bottom_margin = Screen:scaleBySize(6)
        local pos_y = y + self.height - math.ceil((self.height - target.dimen.h) / 2) - corner_mark_size - bottom_margin

        for i = 1, draw_stars do
            local star_icon = IconWidget:new{
                icon = "star.full",
                width = star_size,
                height = star_size,
                alpha = true,
            }
            star_icon:paintTo(bb, pos_x + (i-1)*star_size, pos_y)
            star_icon:free()
        end
    end
end

-- register for the coverbrowser plugin (mosaicmenu is used by that plugin)
userpatch.registerPatchPluginFunc("coverbrowser", patchStarRating)

return true
