local BD = require("ui/bidi")
local FileManager = require("apps/filemanager/filemanager")
local filemanagerutil = require("apps/filemanager/filemanagerutil")

function FileManager:updateTitleBarPath(path)
    local text
    if self.folder_shortcuts:hasFolderShortcut(path) then
        -- Use the shortcut name instead of the path
        local shortcut = self.folder_shortcuts.folder_shortcuts[path]
        text = shortcut and BD.directory(shortcut.text) or BD.directory(filemanagerutil.abbreviate(path))
    else
        text = BD.directory(filemanagerutil.abbreviate(path))
    end
    self.title_bar:setSubTitle(text)
end