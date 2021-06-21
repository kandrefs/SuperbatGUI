@echo off
TITLE P2

setlocal EnableExtensions EnableDelayedExpansion
:: Lager temp directory for et sted å legge produserte filer midlertidig. Denne fjernes igjen under flytting.
:: timeout kommandoene skal (forhåpentligvis) hjelpe til med å redusere ffmpeg crash.
if not exist "%cd%\temp" md temp
if not exist "%cd%\logs" md logs
if not exist "%cd%\logs\db" md logs\db


SET "YYYYMMDD=%date:~6,4%%date:~3,2%%date:~0,2%"
SET "logtime=%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%"
SET "logfile=P2_logfile_%YYYYMMDD%_%logtime%"

SET STARTTIME=%TIME%
SET FULLSTARTTIME=%TIME%
SET "STARTDATE=%date:~6,4%.%date:~3,2%.%date:~0,2%"

echo %logfile% >> "%cd%\logs\%logfile%.log"
echo. >> "%cd%\logs\%logfile%.log"
echo %date:~6,4%-%date:~3,2%-%date:~0,2% %TIME:~0,8% Start. >> "%cd%\logs\%logfile%.log"

:: list all input files in log
echo. >> "%cd%\logs\%logfile%.log"
echo Files to process: >> "%cd%\logs\%logfile%.log"
for %%a in ("*.mov*") do (
	echo      *%%~na.mov, %%~za bytes >> "%cd%\logs\%logfile%.log"
	)
echo. >> "%cd%\logs\%logfile%.log"

timeout 2
:: Produserer filer - xml - mkv - mp4: legges i temp
for %%a in ("*.mov*") do (
	echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! Starting QcTools, FFV1, and H264 for file: *%%~na.mov >> "%cd%\logs\%logfile%.log"
	ffprobe -f lavfi -i "movie=%%a:s=v+a[in0][in1], [in0]signalstats=stat=tout+vrep+brng, cropdetect=reset=1:round=1, idet=half_life=1, split[a][b];[a]field=top[a1];[b]field=bottom, split[b1][b2];[a1][b1]psnr[c1];[c1][b2]ssim[out0];[in1]ebur128=metadata=1, astats=metadata=1:reset=1:length=0.4[out1]" -show_frames -show_versions -of xml=x=1:q=1 -noprivate > "temp\no-nb_video_%%~na_%YYYYMMDD%.qctools.xml"
	timeout 5
	echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! New file: *no-nb_video_%%~na_%YYYYMMDD%.qctools.xml >> "%cd%\logs\%logfile%.log"
	ffmpeg -y -vsync 0 -hwaccel cuda -i "%%a" -map 0 -dn -c:v ffv1 -level 3 -g 1 -slicecrc 1 -slices 24 -c:a copy "temp\no-nb_video_%%~na_%YYYYMMDD%.mkv"
	timeout 5
	echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! New file: *no-nb_video_%%~na_%YYYYMMDD%.mkv >> "%cd%\logs\%logfile%.log"
	ffmpeg -y -vsync 0 -hwaccel cuda -i "%%a" -c:v h264_nvenc -vf "yadif,format=yuv420p" -preset llhq -rc:v vbr_hq -cq:v 19 -b:v 2000k -maxrate:v 3000k -profile:v high -c:a aac "temp\no-nb_video_%%~na_%YYYYMMDD%.mp4"
	timeout 5
	echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! New file: *no-nb_video_%%~na_%YYYYMMDD%.mp4 >> "%cd%\logs\%logfile%.log"
	)
echo. >> "%cd%\logs\%logfile%.log"
:: Mediainfo ønskes i .xml fil og format. // add -fx //

:: Produserer filer - xml - txt: lages fra temp, legges i temp.
for %%a in ("%cd%\temp\*.mkv*") do (
	echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! Starting Mediainfo and Mediatrace on file: *%%~na.mkv >> "%cd%\logs\%logfile%.log"
	mediaconch -mi -fx "%%a" > "%cd%\temp\%%~na.mediainfo.xml"
	echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! New file: *%%~na.mediainfo.xml >> "%cd%\logs\%logfile%.log"
	mediaconch -tt -fx "%%a" > "%cd%\temp\%%~na.mediatrace.xml"
	echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! New file: *%%~na.mediatrace.xml >> "%cd%\logs\%logfile%.log"
	)
timeout 5
echo. >> "%cd%\logs\%logfile%.log"
:: list all files produced
echo Files produced: >> "%cd%\logs\%logfile%.log"
for %%a in ("%cd%\temp\*.mkv*") do (
	echo      *%%~na.mkv, %%~za bytes >> "%cd%\logs\%logfile%.log"
	echo %%~na ; %date:~6,4%-%date:~3,2%-%date:~0,2% >> "%cd%\logs\db\P2_database.csv
	)
for %%a in ("%cd%\temp\*.mp4*") do (
	echo      *%%~na.mp4, %%~za bytes >> "%cd%\logs\%logfile%.log"
	)
for %%a in ("%cd%\temp\*.qctools.xml*") do (
	echo      *%%~na.xml, %%~za bytes >> "%cd%\logs\%logfile%.log"
	)
for %%a in ("%cd%\temp\*.mediainfo.xml*") do (
	echo      *%%~na.xml, %%~za bytes >> "%cd%\logs\%logfile%.log"
	)
for %%a in ("%cd%\temp\*.mediatrace.xml*") do (
	echo      *%%~na.xml, %%~za bytes >> "%cd%\logs\%logfile%.log"
	)
echo. >> "%cd%\logs\%logfile%.log"

:: Flytter oss til temp
cd ..
:: kopierer mp4 til /mp4
echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! Copying all .mp4 files to /MP4. >> "%cd%\P2\logs\%logfile%.log"
copy P2\temp\*.mp4 "%cd%\MP4"
echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! Finished copy. >> "%cd%\P2\logs\%logfile%.log"


echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! Sorting all files into folders. >> "%cd%\P2\logs\%logfile%.log"
cd %cd%\P2\temp

:: Lager folder basert på mkv navn, legger inn tilhørende filer uten mp4.
for %%a in ("*.mkv*") do (
	md "%%~na"
	move "%%~na.mkv" "%%~na"
	move "%%~na.qctools.xml" "%%~na"
	move "%%~na.mediatrace.xml" "%%~na"
	move "%%~na.mediainfo.xml" "%%~na"
	move "%%~na.mp4" "%%~na"
	)

cd ..
echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! All files sorted. >> "%cd%\logs\%logfile%.log"

cd ..

timeout 5
echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! Making checksums for all sorted files. >> "%cd%\P2\logs\%logfile%.log"
:: Lager chcksum av mapper inne i temp
fsum "%cd%\P2\temp" /T:F /R /O
echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! Checksums done. >> "%cd%\P2\logs\%logfile%.log"

timeout 5
echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! Moving all sorted files to /Ferdig. >> "%cd%\P2\logs\%logfile%.log"
:: Flytter mappene til /ferdig - inneholder mkv, xml, xml, txt, md5. /XF er redundant atm.
robocopy "%cd%\P2\temp" "%cd%\Ferdig" /MOVE /XF "mediaconch.exe" "libcurl.dll" /E
timeout 5
:: Flytter original .mov til /original
set "source=%cd%\P2"
set "destination=%cd%\Original"
robocopy "%source%" "%destination%" *.mov* /mov /minage:%X%
timeout 5
echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! Moving done. >> "%cd%\P2\logs\%logfile%.log"
echo %date:~6,4%-%date:~3,2%-%date:~0,2% !TIME:~0,8! End logfile. >> "%cd%\P2\logs\%logfile%.log"



SET ENDTIME=%TIME%
SET "ENDDATE=%date:~6,4%.%date:~3,2%.%date:~0,2%"


echo ------------------------------------
echo START:       %STARTTIME:~0,8%     %STARTDATE%
echo END:         %ENDTIME:~0,8%     %ENDDATE%
echo ------------------------------------

echo ------------------------------------ >> "%cd%\P2\logs\%logfile%.log"
echo START:       %STARTTIME:~0,8%     %STARTDATE% >> "%cd%\P2\logs\%logfile%.log"
echo END:         %ENDTIME:~0,8%     %ENDDATE% >> "%cd%\P2\logs\%logfile%.log"
echo ------------------------------------ >> "%cd%\P2\logs\%logfile%.log"

set /A STARTTIME=(1%STARTTIME:~0,2%-100)*360000 + (1%STARTTIME:~3,2%-100)*6000 + (1%STARTTIME:~6,2%-100)*100 + (1%STARTTIME:~9,2%-100)
set /A ENDTIME=(1%ENDTIME:~0,2%-100)*360000 + (1%ENDTIME:~3,2%-100)*6000 + (1%ENDTIME:~6,2%-100)*100 + (1%ENDTIME:~9,2%-100)

set /A DURATION=%ENDTIME%-%STARTTIME%

if %ENDTIME% LSS %STARTTIME% set /A DURATION=%DURATION%+8640000

set /A DURATIONH=%DURATION% / 360000
set /A DURATIONM=(%DURATION% - %DURATIONH%*360000) / 6000
set /A DURATIONS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000) / 100
set /A DURATIONHS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000 - %DURATIONS%*100)

if %DURATIONH% LSS 10 set DURATIONH=0%DURATIONH%
if %DURATIONM% LSS 10 set DURATIONM=0%DURATIONM%
if %DURATIONS% LSS 10 set DURATIONS=0%DURATIONS%
if %DURATIONHS% LSS 10 set DURATIONHS=0%DURATIONHS%

echo DURATION:    %DURATIONH%:%DURATIONM%:%DURATIONS%
echo ------------------------------------

echo DURATION:    %DURATIONH%:%DURATIONM%:%DURATIONS% >> "%cd%\P2\logs\%logfile%.log"
echo ------------------------------------ >> "%cd%\P2\logs\%logfile%.log"


pause
:: -Kandrefs
