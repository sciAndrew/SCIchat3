:absolute_start
echo off
SETLOCAL EnableDelayedExpansion
set id=%RANDOM%
set id=%RANDOM%
set loop=0

::maxloop - ile lini zostanie wyswietlonych
::interval - jak czesto wiadomosci beda pobierane z serwera, im czesciej tym mniejsza szansa na przegapienie wiadomosci ale wieksze uzycie serwera (tak czy siak nie powinno sprawiac problemow, mysi byc wiecej niz 0)
::diskletter - litera dysku przez ktury ma dzialac czat

::mozesz zmieniac ustawienia
::od tutaj
set maxloop=24
set interval=5
set diskletter=P
::do tutaj

:setloop
set /A loop=%loop%+1
set m%loop%=LINE
if %loop% lss %maxloop% ( goto setloop )
set messagein=-
set /p user=Nazwa uzytkownika: 
choice /C TN /M "Czy chcesz sie polonczyc z pokojem publicznym? T jesli tak, N aby podac nazwe pokoju"
if %ERRORLEVEL%==2 ( set /p room=Nazwa pokoju: ) else ( set room=Public)

echo wiadomosci mogo miec max 90 znakow i nie mogo zaczynac sie malym x

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