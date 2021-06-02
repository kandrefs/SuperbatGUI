@echo off
TITLE P1
:: Lager temp directory for et sted å legge produserte filer midlertidig. Denne fjernes igjen under flytting.
:: timeout kommandoene skal (forhåpentligvis) hjelpe til med å redusere ffmpeg crash.
md temp
SET "YYYYMMDD=%date:~6,4%%date:~3,2%%date:~0,2%"
timeout 2
:: Produserer filer - xml - mkv - mp4: legges i temp
for %%a in ("*.mov*") do (
	ffprobe -f lavfi -i "movie=%%a:s=v+a[in0][in1], [in0]signalstats=stat=tout+vrep+brng, cropdetect=reset=1:round=1, idet=half_life=1, split[a][b];[a]field=top[a1];[b]field=bottom, split[b1][b2];[a1][b1]psnr[c1];[c1][b2]ssim[out0];[in1]ebur128=metadata=1, astats=metadata=1:reset=1:length=0.4[out1]" -show_frames -show_versions -of xml=x=1:q=1 -noprivate > "temp\no-nb_video_%%~na_%YYYYMMDD%.qctools.xml"
	timeout 5
	ffmpeg -y -vsync 0 -hwaccel cuda -i "%%a" -map 0 -dn -c:v ffv1 -level 3 -g 1 -slicecrc 1 -slices 16 -c:a copy "temp\no-nb_video_%%~na_%YYYYMMDD%.mkv"
	timeout 5
	ffmpeg -y -vsync 0 -hwaccel cuda -i "%%a" -c:v h264_nvenc -vf "yadif,format=yuv420p" -preset llhq -rc:v vbr_hq -cq:v 19 -b:v 2000k -maxrate:v 3000k -profile:v high -c:a aac "temp\no-nb_video_%%~na_%YYYYMMDD%.mp4"
	timeout 5
	)

:: Mediainfo ønskes i .xml fil og format. // add -fx //

:: Produserer filer - xml - txt: lages fra temp, legges i temp.
for %%a in ("%cd%\temp\*.mkv*") do (
	mediaconch -mi -fx "%%a" > "%cd%\temp\%%~na.mediainfo.xml"
	mediaconch -tt -fx "%%a" > "%cd%\temp\%%~na.mediatrace.xml"
	)
timeout 5
	
:: Flytter oss til temp
cd ..
:: kopierer mp4 til /mp4
copy P1\temp\*.mp4 "%cd%\MP4"



cd %cd%\P1\temp

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
cd ..
timeout 5
:: Flytter mp4 så det ikke lages chksum av dem
::set "source=%cd%\P1\temp"
::set "destination=%cd%\MP4"
::robocopy "%source%" "%destination%" *.mp4* /mov /minage:%X%
timeout 5
:: Lager chcksum av mapper inne i temp
fsum "%cd%\P1\temp" /T:F /R /O
timeout 5
:: Flytter mappene til /ferdig - inneholder mkv, xml, xml, txt, md5. /XF er redundant atm.
robocopy "%cd%\P1\temp" "%cd%\Ferdig" /MOVE /XF "mediaconch.exe" "libcurl.dll" /E
timeout 5
:: Flytter original .mov til /original
set "source=%cd%\P1"
set "destination=%cd%\Original"
robocopy "%source%" "%destination%" *.mov* /mov /minage:%X%
timeout 5

pause
:: -Kandrefs