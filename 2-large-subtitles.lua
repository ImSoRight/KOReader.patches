local Font = require("ui/font")
local TitleBar = require("ui/widget/titlebar")

TitleBar_orig_subtitle_face = TitleBar.subtitle_face
TitleBar.subtitle_face = Font:getFace("smalltfont")