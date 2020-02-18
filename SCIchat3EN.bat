:absolute_start
echo off
SETLOCAL EnableDelayedExpansion
set id=%RANDOM%
set id=%RANDOM%
set loop=0

::maxloop defines how many lines will be shown
::interval defines how often message will be checked, the lower the less chance of missing one, but more load on the server (should not cause problems anyways, keep above 0)
::diskletter is the letter of the shared drive

::you can change settings
::from here
set maxloop=24
set interval=5
set diskletter=P
::to here

:setloop
set /A loop=%loop%+1
set m%loop%=LINE
if %loop% lss %maxloop% ( goto setloop )
set messagein=-
set /p user=Username: 
choice /C TN /M "Do you want to connect to the public room? Y if yes, N to give the room name"
if %ERRORLEVEL%==2 ( set /p room=Room name: ) else ( set room=Public)

echo messages can only be up to 90 characters long and can't start with lowercase x

:start

choice /T %interval% /CS /C qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890 /N /D x
if %ERRORLEVEL% == 21 ( goto messages_get ) else ( goto send_message )
goto start

:messages_get
if exist "%diskletter%:\room%room%.SCIchat3" ( set /p messagein=<%diskletter%:\room%room%.SCIchat3 ) else ( goto show )
if "%messagein:~0,90%"=="%m1:~0,90%" ( goto show )
set loop=%maxloop%
set m0=%messagein:~0,90%
:updateloop
set /A prloop=%loop%-1
set m%loop%=!m%prloop%!
set /A loop=%loop%-1
if %loop% gtr 0 ( goto updateloop )
:show
set loop=%maxloop%
cls
:showloop
echo !m%loop%!
set /A loop=%loop%-1
if %loop% gtr 0 ( goto showloop )
goto start

:send_message
echo #----------------------------------------------------------------------------------------#
set /p message=%user%:
echo %user%:%message%>"%diskletter%:\room%room%.SCIchat3"
goto start