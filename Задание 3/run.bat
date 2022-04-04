@echo off
for /f "tokens=2 delims==" %%i in ('WMIC PATH Win32_LocalTime GET DayOfWeek /value') do for %%j in (%%i) do set "dawyofweek=%%j"



if %dawyofweek% EQU 4 goto thu

:main
echo end programm
exit

:thu
set /p str=Input text: 
goto main