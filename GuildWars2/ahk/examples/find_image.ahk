F1::
logging := "C:\Users\vincent\Documents\Vincent_Scripts\GuildWars2\Unbreakable_Logging_Axe.png"
harvesting := "C:\Users\vincent\Documents\Vincent_Scripts\GuildWars2\Unbreakable_Harvesting_Sickle.png"
mining := "C:\Users\vincent\Documents\Vincent_Scripts\GuildWars2\Unbreakable_Mining_Pick.png"
test := "C:\Users\vincent\Documents\Vincent_Scripts\GuildWars2\Capture.PNG"
CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *125 %mining%
if (ErrorLevel = 2)
    MsgBox Could not conduct the search.
else if (ErrorLevel = 1)
    MsgBox Icon could not be found on the screen.
else
    MouseMove, %FoundX%, %FoundY%, 10
    ;MsgBox The icon was found at %FoundX%x%FoundY%.