@echo off
pushd "%~dp0"
set OBBPATH=/sdcard/Android/obb/com.GREMORYGames.ActionTaimanin
adb shell "ls -1 %OBBPATH%/main* > /data/local/tmp/filelist.txt"
adb pull "/data/local/tmp/filelist.txt"
for /f %%1 in (filelist.txt) do set OBBNAME=%%~nx1
adb pull %OBBPATH%/%OBBNAME%
copy %OBBNAME% %OBBNAME%.bak
ObbAssit.exe x Assets/LocalBundle/aos/model_char model_char %OBBNAME%
Mod_AI3.exe
ObbAssit.exe f Assets/LocalBundle/aos/model_char model_char %OBBNAME%
adb push %OBBNAME% %OBBPATH%
timeout 3
