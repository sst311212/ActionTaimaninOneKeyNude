#include <MsgBoxConstants.au3>

ShellExecute("Mod.exe")
Local $hWnd = WinWait("[TITLE:UABE Mod Installer; CLASS:UABE_ModInstaller]", "")

ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:2]")
Sleep(200)

ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:5]")
Sleep(200)

ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:9]")
Sleep(200)

Local $isEnable = 0
Do
    $isEnable = ControlCommand($hWnd, "", "[CLASS:Button; INSTANCE:12]", "IsEnabled")
    Sleep(20)
Until $isEnable == 1
ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:12]")
Sleep(200)

ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:14]")
Sleep(200)