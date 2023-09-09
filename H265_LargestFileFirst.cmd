@echo off & setLocal EnableDelayedExpansion

set search_limit=20

:: End Edit DO NOT TOUCH ANYTHING BELOW THIS POINT UNLESS YOU KNOW WHAT YOUR DOING!

TITLE C0nw0nk - Directory Largest File first

echo Input the Directory or Path you want to correctly order for example C:\path or you can use \\NAS\STORAGE\PATH
set /p "plex_folder="

set root_path="%~dp0"

::start powershell code
echo $extensions = @("*.mkv", "*.mp4", "*.avi") >"%root_path:"=%%~n0.ps1"
echo Get-ChildItem "%plex_folder:"=%" -Include $extensions -Recurse ^| sort -descending -property length ^| select -first %search_limit% name -ExpandProperty FullName ^| Out-File -FilePath "%root_path:"=%%~n0.txt" -NoClobber -Append >>"%root_path:"=%%~n0.ps1"
::end powershell code
powershell -ExecutionPolicy Unrestricted -File "%root_path:"=%%~n0.ps1" "%*" -Verb runAs
del "%root_path:"=%%~n0.ps1"

:: If plex cleaner not found then download and put it with script
if not exist "%root_path:"=%win-x64\Tools\FfMpeg\bin\ffmpeg.exe" (
	call "%root_path:"=%PlexCleaner_265.cmd" "" "0" "0" "0"
)

:: start /b /wait "%root_path:"=%PlexCleaner_265.cmd" "%plex_folder:"=%\%%i" "0" "0" "0"
for /f "delims=" %%i in ('Type "%root_path:"=%%~n0.txt"') do (
	echo "%%i"
	for /f %%b in ('%root_path:"=%win-x64\Tools\FfMpeg\bin\ffmpeg.exe -i "%%i" 2^>^&1 ^| find /c /i "Video: hevc "') do (
		if [%%b]==[0] (
			echo "%%i" is not hevc encoded
			call "%root_path:"=%PlexCleaner_265.cmd" "%%i" "0" "0" "0"
		) else (
			echo "%%i" is hevc encoded
		)
	)
)
del "%root_path:"=%%~n0.txt"

pause

exit
