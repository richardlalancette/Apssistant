

; ==========================================�Ԅӱ����Д�
/* 
#Persistent
SetTimer,ClsEvthn,1000
return

ClsEvthn:
IfWinExist,ahk_class EVERYTHING
        IfWinNotActive
                WinClose
return
 */


; ==========================================调试信息
/* 
Debug:
	msgbox,DPI %%VirtualWidth%% %%VirtualHeight%%`n%VirtualWidth% %VirtualHeight% `n fcp %fcX% %fcY% `n MapAltmode=%MapAltmode%
	;msgbox, %Precisehudcp%
	;msgbox, %centerw% %centerh% 
	;msgbox ,%FCPk%
	Return
 */

Browse2:
	;PsPath=NULL
	ProgramFilesDir:="A_ProgramFiles"
	FileSelectFile, Dir , 1, %ProgramFilesDir%\Photoshop.exe, %Lang_PsDir%, Photoshop (*.exe; *.lnk)
	StringReplace, Dir, Dir, `n, `r`n, A
	If Dir=
		return
	else
	{
		IniWrite, %Dir%, %A_scriptdir%\Data\Config.ini, Setting, PsPath
		run "%Dir%"
	}
	Return

CleanUpTempFiles:
	If Check14=1
	{
		DriveGet, OutputVar, list
		Loop, Parse, OutputVar,,
		{
			Ifexist %A_LoopField%:\Photoshop Temp*
				FileDelete %A_LoopField%:\Photoshop Temp*
			Ifexist %A_LoopField%:\*_*_MVM_*.tmp
				FileDelete %A_LoopField%:\*_*_MVM_*.tmp
		}
	}
	Return


; 读取配置信息
ConfigRead:
	IniRead, HUDCP, %A_scriptdir%\Data\Config.ini, Setting, hudcp, ``
	IniRead, FCPk, %A_scriptdir%\Data\Config.ini, Setting, fcp, n
	IniRead, Check1, %A_scriptdir%\Data\Config.ini, Setting, undo, 0
	IniRead, Autosavenum, %A_scriptdir%\Data\Config.ini, Setting, autosave, 1
	IniRead, Savesleep, %A_scriptdir%\Data\Config.ini, Setting, savesleep, 5
	IniRead, Check2, %A_scriptdir%\Data\Config.ini, Setting, helptip, 0
	IniRead, Check3, %A_scriptdir%\Data\Config.ini, Setting, lockIME, 0
	IniRead, Check4, %A_scriptdir%\Data\Config.ini, Setting, launchPs, 1
	IniRead, Check5, %A_scriptdir%\Data\Config.ini, Setting, Precisehudcp, 1
	IniRead, Check6, %A_scriptdir%\Data\Config.ini, Setting, enableQCLayer, 1
	IniRead, Check7, %A_scriptdir%\Data\Config.ini, Setting, enablehudcp, 1
	IniRead, Check8, %A_scriptdir%\Data\Config.ini, Setting, enablefcp, 1
	IniRead, Check9, %A_scriptdir%\Data\Config.ini, Setting, Centerhudcp, 0
	IniRead, Check10, %A_scriptdir%\Data\Config.ini, Setting, DisableAltMenu, 1
	IniRead, Check11, %A_scriptdir%\Data\Config.ini, Setting, enableModifyBrushRadius, 1
	IniRead, Check12, %A_scriptdir%\Data\Config.ini, Setting, CPThudcp, 1
	IniRead, Check13, %A_scriptdir%\Data\Config.ini, Setting, SHLayerToggle, 1
	IniRead, Check14, %A_scriptdir%\Data\Config.ini, Setting, CleanUpTempFiles, 1
	IniRead, SHLayer, %A_scriptdir%\Data\Config.ini, Setting, SHLayer, H
	IniRead, QCLayer, %A_scriptdir%\Data\Config.ini, Setting, QCLayer, F1
	IniRead, ModifyBrushKey, %A_scriptdir%\Data\Config.ini, Setting, ModifyBrushRadius, F2
	IniRead, MapAltmode, %A_scriptdir%\Data\Config.ini, Setting, mapalt, 1
	IniRead, PsPath, %A_scriptdir%\Data\Config.ini, Setting, PsPath, NULL
	IniRead, Check15, %A_scriptdir%\Data\Config.ini, Setting, 3dsMaxSync, 0
	If PsPath=NULL
	{
		PsDir:=RegRead64("HKEY_LOCAL_MACHINE", "SOFTWARE\Adobe\Photoshop\" . Regver . ".0", "ApplicationPath")
		If ErrorLevel
			PsPath=NULL
		else
			PsPath=%PsDir%Photoshop.exe
	}

	IniRead, Tiptext, %A_scriptdir%\Data\Config.ini, Setting, tiptext, %Lang_tiptext%
	IniRead, fontname, %A_scriptdir%\Data\Config.ini, General, fontname, Segoe UI
	stringreplace, Tiptext, Tiptext, \n, `n, All
	stringreplace, Tiptext, Tiptext, \r, `r, All
	Return

Website:
	; please retain the original links and related notes.
	run http://www.deviantart.com/deviation/160950828
	return

Blog:
	; please retain the original links and related notes.
	run http://millionart.deviantart.com
	return



; A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A links A A A A A A A A A A A A A A A A A A A A A A A A A A A A A A

WinClose:
	Process, Close, Config.exe
	gosub CleanUpTempFiles
GuiClose:
GuiEscape:
Cancel:
;	Gui, Cancel
	ExitApp
	return

#include %A_scriptdir%\inc\Function.ahk
#include %A_scriptdir%\inc\reg64.ahk
;#include %A_scriptdir%\inc\Dlg.ahk