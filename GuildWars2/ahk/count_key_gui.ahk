#MaxThreadsPerHotkey 1
#Persistent
#IfWinActive, ahk_exe Gw2-64.exe
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%\Gdip_All.ahk
; Array
  arrPos := []
  arrPos[1] := {x: 678, y: 1066}
  arrPos[2] := {x: 773, y: 1066}
  arrPos[3] := {x: 863, y: 1066}
  arrPos[4] := {x: 960, y: 1066}
  arrPos[5] := {x: 1055, y: 1066}
  arrPos[6] := {x: 1150, y: 1066}
  arrPos[7] := {x: 1243, y: 1066}
  arrPos[98] := {x: 585 , y: 1066} ; back
  arrPos[99] := {x: 1333, y: 1066} ; forward
;
; Variable
  toolaxe := 4500
  toolharvester := 2500
  toolsleep := toolaxe
  MaxC := 27 ; max characters
  Count := 26 ; set default position
  Screen := 1 ; 
  Gosub, CountScreen ; to get the corresponding position variable.
  
;
; Gui
  Gui, +AlwaysOnTop
  Gui, +Caption +Border +sysmenu
  ;Gui, Add, Tab3,, General|Waypoints
  ;Gui, Tab, 1
  Gui, Add, Text, vCount w200, (%Count%) Screen %Screen% - Position %Position%.
  Gui, Add, Text, vStatus w200, none
  Gui, Add, Picture, h400 h-1 vMyChar, ;Image.png
  ;Gui, Add, Text, vcharPos w200, none
  ;Gui, Add, Text, vToolTimer ym, Sleep %toolsleep%
  gui, Add, Radio, gAxetimer ym, Axe %toolaxe%
  gui, Add, Radio, gHarvester, Harvester %toolharvester%
  ;gui, add, Text, vmyTest w200, Test
  ;gui, Tab,2 
  gui, Add, Edit, ym, /g3 [&BIcCAAA=]
  Gui, Show, AutoSize xCenter y0
  return
;
; PgUp:: used to increase count of where the character is
  PgUp::
    KeyWait, PgUp  ;Wait for h to be released
    If Count <= % MaxC - 1
    {
      Count := Count + 1
    }
    Else If Count = % MaxC
    {
      Count := 1
    }
    Gosub, CountScreen
    GuiControl, Text, Count, (%Count%) Screen %Screen% - Position %Position%.
    KeyWait, PgUp  ;Wait for h to be released
  return
;
; PgDn:: used to decrease count of where the character is
  PgDn::
    KeyWait, PgDn  ;Wait for h to be released
    If Count >= 2
    {
      Count := Count - 1
    }
    Else If Count = 1
    {
      Count := MaxC
    }
    Gosub, CountScreen
    GuiControl, Text , Count, (%Count%) Screen %Screen% - Position %Position%.
  return
;
; Home:: move to character
  Home::
  {
  KeyWait, Home
  GuiControl, Text , Status, You are at (%Count%) %Screen%-%Position%.
  ;GuiControl, Text , charPos, You are at arrPos%Position%
  Gosub, changeScreen
  Gosub, RandomMouse
  MouseMove arrPos[Position].x + randomx, arrPos[Position].y + randomy, randomv
  return
  }
;
; F12:: Move mouse to character select
  F12::
  {
  Gosub, movemousetochange
  return
  }
;
; Insert:: used to actually select character
  Insert::
  {
  KeyWait, Insert
  GuiControl, Text , Status, You are at (%Count%) %Screen%-%Position%.
  ;GuiControl, Text , charPos, You are at arrPos%Position%
  ;Gosub, changeScreen
  ;Gosub, RandomMouse
  ;MouseMove arrPos[Position-1].x + randomx, arrPos[Position-1].y + randomy, randomv
  Gosub, takescreen
  Sleep, 50
  Gosub, mousex2click
  return
  }
;
; +pause:: (shift+pause) G3, used to changed tool and start gathering
  +pause::  ; shift+pause hotkey.
    {
      KeyWait, shift
      MouseGetPos, MouseX, MouseY
      PixelGetColor, colortool1, %MouseX%, %MouseY% ; get initial color of tool
      Gosub, mousex2click ; double click to change tool
      Gosub, checkiftoolchanged ; check if tool has changed and stargather
      ;sleep 2000
      ;PixelGetColor, colorbar1, 887, 948
      ;sleep 2500
      sleep %toolsleep%
      ;PixelGetColor, color, %MouseX%, %MouseY%
      ;PixelGetColor, colorbar2, 887, 948
      SetTimer, looptime, -3000
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
           Gosub, mousemovechangetoolback
          }
        }
    }
  return
;

; end:: exits the loops that wants to change the tool back after gathering
end::
  colortool1 := color
  return
;
; looptime
  looptime:
  colortool1 := color
  Return
;

; !pause:: shift+pause Exits app
!pause::ExitApp

; ^CtrlBreak:: (ctrl+pause) G2,  ; move back mouse to where the last tool click was 9Pause or Ctrl+NumLock. While the Ctrl key is held down, the Pause key produces the key code of CtrlBreak and NumLock produces Pause, so use ^CtrlBreak in hotkeys instead of ^Pause.)
  ^CtrlBreak::
    {
        Gosub, RandomMouse
        MouseMove MouseX + randomx, MouseY + randomx, %mymousemove%
    }
  return
;
; checkiftoolchanged: Subroutine to check if tool has changed
  checkiftoolchanged:
  {
    sleep 100
    PixelGetColor, colortool2, %MouseX%, %MouseY%
    if (colortool1 = colortool2)
      {
        Exit ; stops processing the hotkey
      }
    Else
      {
        Gosub, startgather ; presses f
      }
  }
  return
;
; startgather: Subroutine to start gathering, presses F
  startgather:
  {
    random, pressf, 75, 100
    sleep %pressf%
    send f
  }
  return
;
; mousemovechangetoolback: Moves mouse back to where the tool was to change it back
  mousemovechangetoolback:
  {
    Random, mymousemove, 10, 30
    MouseMove, %MouseX%, %MouseY%, %mymousemove%
    sleep 50
    Gosub, mousex2click ; double click to change tool
  }
  return
;
; movemousetochange: Subroutine, presses F12 to change character and presses
  movemousetochange:
  {
    Random, mylogoutx, 895, 1010
    Random, mylogouty, 640, 656
    Random, mymousemove, 5, 15
    send {F12}
    MouseMove, %mylogoutx%, %mylogouty%, %mymousemove%
  }
  return
;

; CountScreen: Subroutine for determining which screen character is in
  CountScreen:
  {
  If Count >= 8
    {
      Countnew := Count
      ScreenX := 1
      while Countnew >= 8
      {
        ScreenX := ScreenX + 1
        Countnew := Countnew - 7
      }
      Screen := ScreenX
      Position := Countnew
    }
  Else
    {
      Screen := 1
      Position := Count
    }
  }
  return
;
; Changescreen: Subroutine for changing the character screen
  changeScreen:
  {
  if Screen >= 2
    {
      changeScreenx := 2
      Gosub, RandomMouse
      MouseMove arrPos[99].x + randomx, arrPos[Position].y + randomy, randomv
      sleep 50
      click
      while (changeScreenx < Screen)
      {
        Sleep, 750
        Click
        changeScreenx := changeScreenx + 1 
        ;GuiControl, Text , charPos, Screen is %Screen% You are at %changeScreenx%
      }
      sleep, 1000
    }
  }
  Return
;
; RandomMouse: Subroutine to randomize x, y, and speed
  RandomMouse:
  {
    Random, randomx, -5, 5
    Random, randomy, -5, 5
    Random, randomv, 5, 15
  }
  Return
;
; mousex2click: Subroutine to double click with random sleep in between
  mousex2click:
  {
      Random, clicksleep, 50, 75
      Click
      sleep %clicksleep%
      Click
      
  }
  return
;

; shift+PgUp:: move to character
  +PgUp::
  {
  KeyWait, PgUp
  Gosub, CountScreen
  newPos := Position + 1
  MouseMove arrPos[newPos].x + randomx, arrPos[newPos].y
  return
  }
;

; shift+PgDn:: move to character
  +PgDn::
  {
  KeyWait, PgDn
  Gosub, CountScreen
  newPos := Position - 1
  MouseMove arrPos[newPos].x + randomx, arrPos[newPos].y
  return
  }
;

takescreen:
  pToken := Gdip_Startup()
    x:=634
    y:=1024
    w:=654
    h:=83
  pBitmap := Gdip_BitmapFromScreen(x "|" y "|" w "|" h)
  ;Gdip_SaveBitmapToFile(pBitmap, "Image.png")
  ;Gdip_SetBitmapToClipboard(pBitmap)
  mypic := Gdip_CreateHBITMAPFromBitmap(pBitmap)
  GuiControl,, MyChar, % "HBITMAP:*" mypic
  Gui, Show, AutoSize xCenter y0
  Gdip_DisposeImage(pBitmap)
  Gdip_Shutdown(pToken)
Return

Axetimer:
toolsleep := toolaxe
return

Harvester:
toolsleep := toolharvester
return

GuiClose:
ExitApp