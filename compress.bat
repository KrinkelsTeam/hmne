@echo off
StripReloc nisedit.exe
if ERRORLEVEL 1 goto StripRelocError
UPX  --compress-icons=0 -9 nisedit.exe
goto exit
:StripRelocError
echo StripReloc Error!!!
:exit
