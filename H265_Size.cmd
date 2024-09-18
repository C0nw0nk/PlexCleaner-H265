@echo off & setLocal EnableDelayedExpansion

set search_limit=2000000

:: Files larger than this size will be converted until they are smaller than this size adjust CRF quality in plexcleaner.json
:: A CRF quality range of 27 - 30 will be good to decrease size little by little
set max_file_size=2GB

:: Instead of just closing the window after our automated tasking we pause to view and check once your happy you can set this to 0
:: 1 enabled
:: 0 disabled
set pause_window=1

:: If you want this script to not exit once finished and after task complete / wait interval passed recheck plex folders in a loop
:: 1 enabled
:: 0 disabled
set loop=1

:: End Edit DO NOT TOUCH ANYTHING BELOW THIS POINT UNLESS YOU KNOW WHAT YOUR DOING!

TITLE C0nw0nk - Directory Largest File first based on file size

echo If file size is greater than %max_file_size% then this script will convert until they are smaller
 
echo Input the Directory or Path you want to correctly order for example C:\path or you can use \\NAS\STORAGE\PATH
set /p "plex_folder="

set root_path="%~dp0"

:start_of_script

del "%root_path:"=%%~n0.txt"

::start powershell code
echo $extensions = @("*.mkv") >"%root_path:"=%%~n0.ps1"
echo Get-ChildItem "%plex_folder:"=%" -Include $extensions -Recurse ^| sort -descending -property length ^| Where {$_.Length -gt %max_file_size%} ^| select -first %search_limit% name -ExpandProperty FullName ^| Out-File -FilePath "%root_path:"=%%~n0.txt" -NoClobber -Append >>"%root_path:"=%%~n0.ps1"
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
			call "%root_path:"=%PlexCleaner_265.cmd" "%%i" "0" "0" "0"
		)
	)
)
del "%root_path:"=%%~n0.txt"

if %pause_window% == 1 pause

if %loop% == 1 goto :start_of_script

exit
