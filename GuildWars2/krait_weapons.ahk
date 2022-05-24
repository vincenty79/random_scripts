#MaxThreadsPerHotkey 1
#Persistent
#IfWinActive, ahk_exe Gw2-64.exe
CoordMode, Mouse, Client
SetWorkingDir %A_ScriptDir%

if WinExist("Guild Wars 2")
    WinActivate ; Use the window found by WinExist.

;
; Positions
;0 search :=(x:590,y:289)
;1 carrionrecurvebow	:={x:590,y:346}
;2 clerichandgun		:={x:590,y:406}
;3 assassinshooter	:={x:590,y:450}
;4 rampageshooter		:={x:590,y:485}
;5 carrionshortbow	:={x:590,y:528}
;6 berserkbrazier		:={x:590,y:591}
;7 valkbrazier		:={x:590,y:605}
;8 knightwhelk		:={x:590,y:682}
;9 valkwhelk			:={x:590,y:698}
;10 no18
;11 craft
;12 close
;13 mag1
;14 mag2
;15 mag3

	searchPos:={x:590,y:289}
	krarrPos := []
	krarrPos[1]:={x:590,y:346}
	krarrPos[2]:={x:590,y:406}
	krarrPos[3]:={x:590,y:450}
	krarrPos[4]:={x:590,y:485}
	krarrPos[5]:={x:590,y:528}
	krarrPos[6]:={x:590,y:591}
	krarrPos[7]:={x:590,y:605}
	krarrPos[8]:={x:590,y:682}
	krarrPos[9]:={x:590,y:698}
	
	no18Pos:={x:944,y:740}
	
	craftarrPos := []
	craftarrPos[11]:={x:1040,y:740}
	craftarrPos[12]:={x:1237,y:740}	
	
	magarrPos := []
	magarrPos[1]:={x:1252,y:460}
	magarrPos[2]:={x:1252,y:530}
	magarrPos[3]:={x:1252,y:600}
	
recipe = 0
PgDn::
{
KeyWait, PgDn
	If recipe <=8
		{
		recipe := recipe + 1
		MouseMove krarrPos[recipe].x, krarrPos[recipe].y
		Click
		}
	Else If recipe >= 9
		{
		  recipe := 1
		  MouseMove krarrPos[recipe].x, krarrPos[recipe].y
		Click
		}
return
}

PgUp::
{
KeyWait, PgUp
	If recipe >=2
		{
		recipe := recipe - 1
		MouseMove krarrPos[recipe].x, krarrPos[recipe].y
		Click
		}
	Else If recipe <= 1
		{
		  recipe := 9
		  MouseMove krarrPos[recipe].x, krarrPos[recipe].y
		Click
		}
return
}

Right::
{
KeyWait, Right
}	
return

Down::
{
;KeyWait, Down
Gosub, craftclose
}	
return

craftclose:
	{
	MouseMove craftarrPos[11].x, craftarrPos[11].y
	sleep 50
	;Gosub, mousewaitclick
	MouseMove craftarrPos[12].x, craftarrPos[12].y
	;Gosub, mousewaitclick
	}
return
	
mousewaitclick:
	{
	sleep 250
	Click
	}

return