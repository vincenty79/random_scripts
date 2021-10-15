@echo off
set fpath=%~dp1
set fname=%~n1
set file=%~f1
rem echo "%fpath%%fname%"
ffmpeg -i "%file%" -f srt -i "%fpath%%fname%.srt" -map 0:0 -map 0:1 -map 1:0 -c:v copy -c:a copy -c:s mov_text -metadata:s:1 language=eng -metadata:s:s:0 language=eng G:\temp\transcode\%fname%.mp4

rem ffmpeg -i "%file%" -map 0 -c copy -metadata:s:1 language=eng -metadata:s:s:0 language=eng G:\temp\transcode\%fname%.mp4