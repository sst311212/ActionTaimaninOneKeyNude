@echo off
pushd "%~dp0"
set OBBPATH=/sdcard/Android/obb/com.GREMORYGames.ActionTaimanin
adb shell "ls -1 %OBBPATH%/main* > /data/local/tmp/filelist.txt"
adb pull "/data/local/tmp/filelist.txt"
for /f %%1 in (filelist.txt) do set OBBNAME=%%~nx1
if exist %OBBNAME%.bak (
  del %OBBNAME%
  copy %OBBNAME%.bak %OBBNAME%
  del model_char*
) else (
  adb pull %OBBPATH%/%OBBNAME%
  copy %OBBNAME% %OBBNAME%.bak
)
ObbAssit.exe extract Assets/LocalBundle/aos/model_char model_char %OBBNAME%
Mod_AI3.exe
ObbAssit.exe update Assets/LocalBundle/aos/model_char model_char %OBBNAME%
adb push %OBBNAME% %OBBPATH%
adb shell "am start -n com.GREMORYGames.ActionTaimanin/com.unity3d.player.UnityPlayerActivity"
timeout 3
