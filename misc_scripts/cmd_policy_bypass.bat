@echo off
:start
set /p command="%CD%> "
%command%
echo.
goto start
