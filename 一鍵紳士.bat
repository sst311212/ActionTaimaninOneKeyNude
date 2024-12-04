@echo off
pushd "%~dp0"

echo Get APK location
adb shell "su -c 'find /data/app -ipath *taimanin*stream* > /data/local/tmp/filelist.txt'"

echo Set APK Path^&Name variables
adb pull "/data/local/tmp/filelist.txt" >NUL 2>&1
for /f %%1 in (filelist.txt) do set APKPATH=%%~1
for /f %%1 in (filelist.txt) do set APKNAME=%%~nx1

echo.
echo Name: %APKNAME%
echo Path: %APKPATH%
if "%APKPATH%"=="" goto :EOF
if "%APKNAME%"=="" goto :EOF

echo.
if exist %APKNAME%.bak (
  echo Found backup APK, restoring files...
  copy /y %APKNAME%.bak %APKNAME%
  del model_char*
) else (
  echo Copying %APKNAME% to temp directory...
  adb shell "su -c 'cp %APKPATH% /data/local/tmp'"
  
  echo Pulling %APKNAME% from Phone...
  adb pull /data/local/tmp/%APKNAME%
  
  echo Backing up APK for next uses...
  copy %APKNAME% %APKNAME%.bak
)

echo.
echo Extracting model_char from %APKNAME%...
ObbAssit.exe extract assets/AssetBundles/aos/model_char model_char %APKNAME%

echo Patching model_char...
if not exist model_char goto :EOF
start /wait "Patching" Mod_AI3.exe

echo Updating model_char to %APKNAME%...
ObbAssit.exe update assets/AssetBundles/aos/model_char model_char %APKNAME%

echo.
echo Pushing %APKNAME% to Phone's temp directory...
adb push %APKNAME% /data/local/tmp

echo.
echo Moving %APKNAME% to Package location...
adb shell "su -c 'mv /data/local/tmp/%APKNAME% %APKPATH%'"

echo.
echo Auto start Action Taimanin
adb shell "am force-stop com.GREMORYGames.ActionTaimanin"
timeout 1 >NUL 2>&1
adb shell "am start -n com.GREMORYGames.ActionTaimanin/com.unity3d.player.UnityPlayerActivity"

pause
exit
