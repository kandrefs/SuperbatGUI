#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=library\data\gui\sb_icon.ico
#AutoIt3Wrapper_Outfile=SuperbatGUI.exe
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Description=SuperbatGUI
#AutoIt3Wrapper_Res_LegalCopyright=Kjetil Sole
#AutoIt3Wrapper_Res_LegalTradeMarks=Kjetil Sole
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>



Local $sDestination = "library\data\gui\splash.jpg"
SplashImageOn("Splash Screen", $sDestination, 1280, 720, -1, -1, 1)

Sleep(5000)
SplashOff()





#Region ### START GUI ###
$Form1_1 = GUICreate("SuperbatGUI - v0.1", 1264, 724, -1, -1, $GUI_SS_DEFAULT_GUI) ;$WS_EX_TOPMOST; hvis det skal være onTOP
$MenuItem1 = GUICtrlCreateMenu("&Fil")
$MenuItem4 = GUICtrlCreateMenuItem("Åpne P#-mapper", $MenuItem1)
$MenuItem5 = GUICtrlCreateMenuItem("Avlsutt", $MenuItem1)
$MenuItem2 = GUICtrlCreateMenu("&video.done()")
$MenuItem6 = GUICtrlCreateMenuItem("Kjør video.done()", $MenuItem2)
$MenuItem3 = GUICtrlCreateMenu("&Hjelp")
$MenuItem7 = GUICtrlCreateMenuItem("lol", $MenuItem3)
$MenuItem8 = GUICtrlCreateMenuItem("Readme...", $MenuItem3)
GUISetBkColor(0xB4B4B4)
$Button1 = GUICtrlCreateButton("P1", 31, 422, 165, 60)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlSetCursor (-1, 0)
$Button2 = GUICtrlCreateButton("P2", 223, 422, 165, 60)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlSetCursor (-1, 0)
$Button3 = GUICtrlCreateButton("P3", 31, 510, 165, 60)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlSetCursor (-1, 0)
$Button4 = GUICtrlCreateButton("P4", 223, 510, 165, 60)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlSetCursor (-1, 0)
$Button5 = GUICtrlCreateButton("Kjør alle", 31, 590, 358, 82)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlSetCursor (-1, 0)
$Pic1 = GUICtrlCreatePic("library\data\gui\guibg2.jpg", 425, -9, 855, 720, $WS_CLIPSIBLINGS)
$Group1 = GUICtrlCreateGroup("Script valg:", 16, 399, 393, 289)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Checkbox1 = GUICtrlCreateCheckbox("Nvidia Encoder", 32, 359, 97, 17)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
$Group2 = GUICtrlCreateGroup("Instillinger for script:", 16, 335, 393, 57)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Checkbox2 = GUICtrlCreateCheckbox("Highest quality", 159, 359, 97, 17)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
$Checkbox3 = GUICtrlCreateCheckbox("Multithreading", 284, 359, 97, 17)
GUICtrlSetFont(-1, 9, 400, 0, "Segoe UI")
$Button6 = GUICtrlCreateButton("QcTools 1.2", 34, 274, 165, 40)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlSetCursor (-1, 0)
$Group3 = GUICtrlCreateGroup("Andre programmer:", 16, 136, 393, 193)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button7 = GUICtrlCreateButton("VirtualDub 2", 219, 274, 165, 40)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
GUICtrlSetCursor (-1, 0)
$Pic2 = GUICtrlCreatePic("library\data\gui\qctoolslogo.jpg", 72, 174, 100, 100)
$Pic3 = GUICtrlCreatePic("library\data\gui\vdublogo.jpg", 269, 187, 76, 76)
$Pic4 = GUICtrlCreatePic("library\data\gui\midpart.jpg", 424, -2, 100, 720)
$Group4 = GUICtrlCreateGroup("Prioritet", 16, 22, 393, 105)
GUICtrlSetFont(-1, 10, 400, 0, "Segoe UI")
$Radio1 = GUICtrlCreateRadio("Lav", 48, 70, 49, 17)
$Radio2 = GUICtrlCreateRadio("Normal", 175, 70, 73, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Radio3 = GUICtrlCreateRadio("Høy", 302, 70, 73, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END GUI ###



While 1
   $msg = GUIGetMsg()
   Select
      Case $msg = $GUI_EVENT_CLOSE
         ExitLoop
      Case $msg = $Button1
			;run ('P1\P1.bat /K')
			Run(@ScriptDir & '\P1\P1.bat /k', @ScriptDir & '\P1')
      Case $msg = $Button2
			Run(@ScriptDir & '\P2\P2.bat /k', @ScriptDir & '\P2')
		Case $msg = $Button3
			Run(@ScriptDir & '\P3\P3.bat /k', @ScriptDir & '\P3')
      Case $msg = $Button4
        Run(@ScriptDir & '\P4\P4.bat /k', @ScriptDir & '\P4')
		Case $msg = $Button5
			Run(@ScriptDir & '\P1\P1.bat /k', @ScriptDir & '\P1')
			Run(@ScriptDir & '\P2\P2.bat /k', @ScriptDir & '\P2')
			Run(@ScriptDir & '\P3\P3.bat /k', @ScriptDir & '\P3')
			Run(@ScriptDir & '\P4\P4.bat /k', @ScriptDir & '\P4')
      Case $msg = $Button6
        run ('library\QCTools\QCTools.exe')
		Case $msg = $Button7
        run ('library\vdub\VirtualDub.exe')
	   Case $msg = $MenuItem8
		   Sleep(250)
		   Run(@ScriptDir & '\library\bat\readme.bat', @ScriptDir & '\library\bat', @SW_MINIMIZE)
        ;run ('library\ffplay.exe -alwaysontop -noborder -window_title " " library\data\readme.mp4 -x 900 -y 720 -autoexit')
		;ShellExecute(@ScriptDir & "\library\readme.bat", "", "", "", @SW_MINIMIZE)
	   Case $msg = $MenuItem5
		   Sleep(100)
        Exit
      Case $msg = $MenuItem4
        ShellExecute("P1") ;opens folders
		ShellExecute("P2")
		ShellExecute("P3")
		ShellExecute("P4")
		Case $msg = $MenuItem7
        run('cmd /C' & 'echo Dette er alpha versjon 0.1 av SuperbatGUI. Hvis du trenger hjelp, ta kontakt med kjetil.sole@nb.no && pause >nul')
      Case $msg = $MenuItem6
        run('cmd /C for /D %a in ("Ferdig\*") do echo done! > "%a\video.done"', @ScriptDir)
		;Case $msg = $Button1
        ;Insert Code Here
      ;Case $msg = $Button2
        ;Insert Code Here
		;Case $msg = $Button1
        ;Insert Code Here
      ;Case $msg = $Button2
        ;Insert Code Here
   EndSelect
Wend







;While 1
;	$nMsg = GUIGetMsg()
;	Switch $nMsg
;		Case $GUI_EVENT_CLOSE
;			Exit
;
;	EndSwitch
;WEnd
