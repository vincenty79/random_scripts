#MaxThreadsPerHotkey 1
#Persistent
;#IfWinActive, ahk_exe Gw2-64.exe
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
  MaxC := 27
  Count := 1pBitmap_area
  Screen := 1
  Position := Count
;
; Gui
  Gui, +AlwaysOnTop
  Gui, +Caption +Border +sysmenu
  Gui, Add, Text, vCount w200, (%Count%) Screen %Screen% - Position %Position%.
  Gui, Add, Text, vStatus w200, none
  Gui, Add, Text, vcharPos w200, none
  Gui, Add, Picture, h400 h-1 vMyChar, Image.png
  Gui, Show, AutoSize Center
  return
;

F1::
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
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
Return