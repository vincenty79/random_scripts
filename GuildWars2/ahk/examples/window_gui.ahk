f1:: 
Loop
{
    char_n := 1
    initSecs := 9000 ; number of seconds to wait x1000(its 9 seconds in this example)
    Gui, 99:+AlwaysOnTop    
    Gui, 99:font,s20 bold,Verdana
    Gui, 99: +Caption +Border -sysmenu
    Gui, 99:add, text, x10 y10 w150 h30 center vTX , %initSecs%
    Gui, 99:Show,,Sleep time left
    loop % initSecs-1 
    {     
        GuiControl,99:,TX,% Frmt(--initSecs)
        sleep, 1000
    }
    Gui, 99:Destroy
    Frmt(secs) 
    {
        time = 20000101
        time += %secs%, seconds
        FormatTime, mmss, %time%, HH:mm:ss
        return mmss
    }
esc::ExitApp

}

