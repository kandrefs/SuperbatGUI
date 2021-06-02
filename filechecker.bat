
@echo off
title File checker

:: Check which folders contain video.done
Echo.
Echo Checks for folders with "video.done" included.
Echo.
Echo.
Echo Visible folders:
echo.

for /d %%a in (Ferdig\*) do (
	if exist "%%a\video.done" echo ^<%%~na^> 
	)

Echo.
Echo.
Echo.
Echo.
Echo Not visible folders: (missing video.done)
Echo.

for /d %%a in (Ferdig\*) do (
	if not exist "%%a\video.done" echo ^<%%~na^> 
	)	
	
Echo.
Echo Please add "video.done" file to invisible folders.
Echo.
Echo.

Echo Press any key to check for missing files...
pause >nul
cls

:: Chech which folders has missing and completed files.
Echo Checking for missing files: (*.mkv, *.mp4, *.qctools.xml, *.mediainfo.xml, *.mediatrace.xml, *.md5)
echo.
echo.
::missing
for /d %%a in (Ferdig\*) do (
	if not exist "%%a\%%~na.mkv" (
		echo [91;1m^<%%~na^> - missing files![0m
	) else (
		if not exist "%%a\%%~na.mp4" (
			echo [91;1m^<%%~na^> - missing files![0m
		) else (
			if not exist "%%a\%%~na.qctools.xml" (
				echo [91;1m^<%%~na^> - missing files![0m
			) else (
				if not exist "%%a\%%~na.mediainfo.xml" (
					echo [91;1m^<%%~na^> - missing files![0m
				) else (
					if not exist "%%a\%%~na.mediatrace.xml" (
						echo [91;1m^<%%~na^> - missing files![0m
					) else (
						if not exist "%%a\%%~na.md5" (
							echo [91;1m^<%%~na^> - missing files![0m
							)
						)
					)
				)
			)
		)
	)
::OK
echo.
for /d %%a in (Ferdig\*) do (
	 if exist "%%a\%%~na.mkv" if exist "%%a\%%~na.mp4" if exist "%%a\%%~na.qctools.xml" if exist "%%a\%%~na.mediainfo.xml" if exist "%%a\%%~na.mediatrace.xml" if exist "%%a\%%~na.md5" echo [92;1m^<%%~na^> - OK![0m
)

echo.
echo.
Echo Press any key to expand missing files...
pause >nul
cls
set mangler=0
::Check which files are missing from folders, outputs nothing if all ok.
for /d %%a in (Ferdig\*) do (
if not exist "%%a\%%~na.mkv" (
		echo. & echo ^<%%~na^>:
	) else (
		if not exist "%%a\%%~na.mp4" (
			echo. & echo ^<%%~na^>:
		) else (
			if not exist "%%a\%%~na.qctools.xml" (
				echo. & echo ^<%%~na^>:
			) else (
				if not exist "%%a\%%~na.mediainfo.xml" (
					echo. & echo ^<%%~na^>:
				) else (
					if not exist "%%a\%%~na.mediatrace.xml" (
						echo. & echo ^<%%~na^>:
					) else (
						if not exist "%%a\%%~na.md5" (
							echo. & echo ^<%%~na^>:
							)
						)
					)
				)
			)
		)
 if not exist "%%a\%%~na.mkv" echo      [91;1m%%~na.mkv is missing![0m & set mangler=1
 if not exist "%%a\%%~na.mp4" echo      [91;1m%%~na.mp4 is missing![0m & set mangler=1
 if not exist "%%a\%%~na.qctools.xml" echo      [91;1m%%~na.qctools.xml is missing![0m & set mangler=1
 if not exist "%%a\%%~na.mediainfo.xml" echo      [91;1m%%~na.mediainfo.xml is missing![0m & set mangler=1
 if not exist "%%a\%%~na.mediatrace.xml" echo      [91;1m%%~na.mediatrace.xml is missing![0m & set mangler=1
 if not exist "%%a\%%~na.md5" echo      [91;1m%%~na.md5 is missing![0m & set mangler=1
)
if %mangler%==0 echo Nothing to expand!
pause
exit