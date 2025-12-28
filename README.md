### [2-customize-highlight-colors](2-customize-highlight-colors.lua)
This patch allows you to customize your highlight colors and their names.

<img src="img/custom_highlights.PNG" style="width:30%; height:auto;">

### [2-star-rating-overlay](2-star-rating-overlay.lua)
This patch displays your star rating over the book covers in mosaic view of the cover browser. To use the same star icon as I did, save star.empty.svg and star.full.svg in koreader/icons. Make sure to save both, because this will also change the icons on the book status page.

<img src="star_overlay_and_completed_check.png" style="width:30%; height:auto;">

### [2-complete-status-icon](2-complete-status-icon.lua)
This patch displays a green checkmark icon on the top left corner of completed book covers in mosaic view of the cover browser (screenshot above). Save complete.svg in koreader/icons.

### [2-sync-browser-rotation](2-sync-browser-rotation.lua)
This patch makes koreader keep the same rotation you were using in your most recently opened book when you go back to the file browser, rather than switching back to the default rotation every time.

### [2-large-subtitles](2-large-subtitles.lua)
This patch makes subtitles the same size as the title. This works well when using the [2-filemanager-titlebar patch](https://github.com/sebdelsol/KOReader.patches/tree/main#-2-filemanager-titlebar) by [sebdelsol](https://github.com/sebdelsol)

<img src="img/large_subtitle.PNG" style="width:70%; height:auto;">

### [2-shortcut-subtitles](2-shortcut-subtitles.lua)
This patch replaces the filepath in the subtitle with the shortcut name when you open a shortcut folder.

<img src="img/shortcut_subtitle.PNG" style="width:70%; height:auto;">

### [2-modify-exit-sleep-screen-message](2-modify-exit-sleep-screen-message.lua)
This patch changes the text of the exit sleep screen message when you postpone screen update after wakeup (in sleep screen settings) until 'exit sleep screen' gesture that you set up with the gesture manager. If your device is lost and someone finds it, this can tell them how to contact you, and in the meantime, they won't know the gesture that will exit the sleep screen, or that it is even waiting for a gesture.

Hint: In the gesture manager, you can enable multiswipes for more complicated gestures, and can record your own custom multiswipe (you can't mix straight up/down with diagonal swipes). Recording seems more sucessful if you swipe quickly.

<img src="img/exit_sleep_screen_message.jpg" style="width:70%; height:auto;">
