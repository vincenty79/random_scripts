#MaxThreadsPerHotkey 3
#Persistent
#IfWinActive, ahk_exe Gw2-64.exe
    +pause::  ; shift+pause hotkey.
    {
        KeyWait, shift
        MouseGetPos, MouseX, MouseY
        PixelGetColor, colortool1, %MouseX%, %MouseY% ; get initial color of tool
        Gosub, mousex2click ; double click to change tool
        Gosub, checkiftoolchanged ; check if tool has changed
        Gosub, startgather ; presses f
        sleep 3300
        PixelGetColor, colorbar1, 887, 948
        sleep 1000
        PixelGetColor, color, %MouseX%, %MouseY%
        while (color != colortool1)
            {
                PixelGetColor, color, %MouseX%, %MouseY%
                if (color = colortool1)
                {
                    Gosub, movemousetochange
                    return
                }
                Else
                {
                    PixelGetColor, colorbar2, 887, 948
                    if (colorbar1 != colorbar2)
                    {
                        Gosub, mousemovechangetoolback
                    }
                }
            }
    }
return

pause::Exit
return

!pause::ExitApp

^CtrlBreak:: ; move back mouse to where the last tool click was 9Pause or Ctrl+NumLock. While the Ctrl key is held down, the Pause key produces the key code of CtrlBreak and NumLock produces Pause, so use ^CtrlBreak in hotkeys instead of ^Pause.)
    {
        Gosub, RandomMouse
        MouseMove MouseX + randomx, MouseY + randomx, %mymousemove%
    }
return

checkiftoolchanged:
{
    sleep 100
    PixelGetColor, colortool2, %MouseX%, %MouseY%
    if (colortoo1 = colortool2)
        {
            Exit ; stops processing the hotkey
        }
}

return
mousex2click: ; click if the tool has changed
{
    Random, toolsleep, 50, 75
    Click
    sleep %toolsleep%
    Click
    sleep %toolsleep%
}
return

startgather:
{
    random, pressf, 75, 100
    sleep %pressf%
    send f
}
return

mousemovechangetoolback:
{
    ;Random, mymousex, -15, 15
    ;Random, mymousey, -15, 15
    Random, mymousemove, 10, 30
    MouseMove %MouseX%, %MouseY%, %mymousemove%
    Random, toolsleep, 50, 75
    sleep 50
    MouseGetPos, MouseX2, MouseY2
    if (MouseX = MouseX2) && (MouseY = MouseY2)
    {
    Click
    sleep %toolsleep%
    Click    
    }
}
return

movemousetochange:
{
    Random, mylogoutx, 895, 1010
    Random, mylogouty, 640, 656
    Random, mymousemove, 10, 30
    send {F12}
    MouseMove, %mylogoutx%, %mylogouty%, %mymousemove%
}
return

RandSleep(x,y)
{
    Random, rand, % x, % y
    Sleep, % rand
    Return
}
return

RandomMouse:
{
  Random, randomx, -15, 15
  Random, randomy, -15, 15
  Random, randomv, 10, 30
}
Return