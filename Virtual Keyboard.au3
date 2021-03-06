#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=1423911297_17979.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Bass.au3>
;#include "BassFX.au3"
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <Array.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GuiComboBox.au3>
#include <File.au3>
#include <SliderConstants.au3>
#include "LP_Form.au3"
#include "PS_Form.au3"
;==========VAR============
Opt("GUIOnEventMode", 1)
Global $aKeys = _CreateKeyMatrix("z|s|x|d|c|v|g|b|h|n|j|m|q|2|w|3|e|r|5|t|6|y|7|u|i|9|o|0|p", "|")
Global $aNotes[12] = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
Global $Label[29][4], $Msample[2], $LPsample[10], $hTempo, $hChannel, $cNote
Global $q = 3, $Time, $sTone = 'Piano', $Key = 0, $MetroGUI, $Radio1GUI, $Radio2GUI, $Radio3GUI, $MetroTime = TimerInit(), $Bmp = 120, $Metro = False, $SliderGUI, $iMetro = 1, $bMetro = 4, $sRadio, $SliderGUI2, $NL
;PATH
Global $P_Sb = @ScriptDir & '\data\sb\', $P_Me = @ScriptDir & '\data\me\', $P_Fx = @ScriptDir & '\data\fx\', $XS_n, $P_LP = @ScriptDir & '\lp.ini', $P_PS = @ScriptDir & '\ps.ini'
;===========FORM===========
#region ### START Koda GUI section ### Form=

$Form1 = GUICreate("Virtual Keyboard v2.0 by LNQ-SW", 1002, 283, 198, 190)
GUISetBkColor(0x000000)
XPStyle(1)
;=========G1===================
$Group1 = GUICtrlCreateGroup("Display", 104, 72, 729, 41)
GUICtrlSetColor(-1, 0xFFFFFF)
XPStyle(0)
$Button1 = GUICtrlCreateButton("<<", 152, 88, 25, 17)
GUICtrlSetColor(-1, 0x000000)
$Button2 = GUICtrlCreateButton(">>", 200, 88, 25, 17)
GUICtrlSetColor(-1, 0x000000)
$Label1 = GUICtrlCreateLabel("", 568, 85, 49, 20) ;C3-C6
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Input2 = GUICtrlCreateInput("Piano", 392, 84, 153, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_READONLY))
$Label3 = GUICtrlCreateLabel("Octave:", 112, 88, 40, 17, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xFFFFFF)
$Label6 = GUICtrlCreateLabel("", 184, 88, 11, 20)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$Slider1 = GUICtrlCreateSlider(704, 88, 105, 20)
GUICtrlSetLimit(-1, 100, 0)
GUICtrlSetData(-1, 100)
GUICtrlSetBkColor(-1, 0x000000)
$Label8 = GUICtrlCreateLabel("100", 808, 88, 22, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
$Label9 = GUICtrlCreateLabel("Volume:", 664, 88, 42, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
$Label4 = GUICtrlCreateLabel("Transpose:", 220+30, 88, 50, 17, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xFFFFFF)
$Button5 = GUICtrlCreateButton("-", 272+30, 88, 25, 17)
$Label5 = GUICtrlCreateLabel("0", 296+30, 90, 23, 20, $SS_CENTER)
GUICtrlSetColor(-1, 0xFFFFFF)
$Button6 = GUICtrlCreateButton("+", 320+30, 88, 25, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
;===============G2================
XPStyle(1)
$Group2 = GUICtrlCreateGroup("Controller", 104, 0, 569, 73)
GUICtrlSetColor(-1, 0xFFFFFF)
XPStyle(0)
$Label2 = GUICtrlCreateLabel("Sound:", 112, 16, 50, 24, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$Combo1 = GUICtrlCreateCombo("", 160, 16, 111, 25, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE))
$Button4 = GUICtrlCreateButton("Load", 278, 16, 33, 22)
$Edit1 = GUICtrlCreateInput("", 320, 16, 337, 21)
$Input3 = GUICtrlCreateInput("", 320, 45, 337, 21)
$BtnHelp = GUICtrlCreateButton("Help", 112, 48, 49, 17)
$BtnAbout = GUICtrlCreateButton("About", 168, 48, 49, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
;=========G3 LP================
XPStyle(1)
$Group3 = GUICtrlCreateGroup("LaunchPad", 840, 0, 153, 273)
GUICtrlSetColor(-1, 0xFFFFFF)
XPStyle(0)
Dim $LPButton[10]
$LPButton[7] = GUICtrlCreateButton("7", 848, 24, 41, 41)
$LPButton[8] = GUICtrlCreateButton("8", 896, 24, 41, 41)
$LPButton[9] = GUICtrlCreateButton("9", 944, 24, 41, 41)
$LPButton[4] = GUICtrlCreateButton("4", 848, 72, 41, 41)
$LPButton[5] = GUICtrlCreateButton("5", 896, 72, 41, 41)
$LPButton[6] = GUICtrlCreateButton("6", 944, 72, 41, 41)
$LPButton[1] = GUICtrlCreateButton("1", 848, 120, 41, 41)
$LPButton[2] = GUICtrlCreateButton("2", 896, 120, 41, 41)
$LPButton[3] = GUICtrlCreateButton("3", 944, 120, 41, 41)
$Button16 = GUICtrlCreateButton("Manager", 936, 240, 49, 25)
$Slider2 = GUICtrlCreateSlider(888, 176, 85, 20, BitOR($GUI_SS_DEFAULT_SLIDER, $TBS_NOTICKS))
GUICtrlSetLimit(-1, 10, 0)
GUICtrlSetData(-1, 10)
GUICtrlSetBkColor(-1, 0x000000)
$Label14 = GUICtrlCreateLabel("Volume:", 848, 176, 42, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
$Label15 = GUICtrlCreateLabel("10", 972, 176, 16, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
$Label16 = GUICtrlCreateLabel("Numlock", 848, 200, 46, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
$Label17 = GUICtrlCreateLabel("●", 896, 197, 10, 17)
GUICtrlSetFont(-1, 12)
GUICtrlCreateGroup("", -99, -99, 1, 1)
XPStyle(1)
;===============G4 Metro======
$Group4 = GUICtrlCreateGroup("Metronome", 680, 0, 153, 73)
GUICtrlSetColor(-1, 0xFFFFFF)
$Checkbox1 = GUICtrlCreateCheckbox("On/Off", 688, 16, 100, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
$Input1 = GUICtrlCreateInput("120", 728, 32, 25, 16)
$Label7 = GUICtrlCreateLabel("BMP", 760, 32, 27, 17, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xFFFFFF)
$Label10 = GUICtrlCreateLabel("Tempo:", 688, 32, 40, 17, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xFFFFFF)
$Label11 = GUICtrlCreateLabel("0", 792, 8, 17, 25, $SS_CENTERIMAGE)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetFont(-1, 18, 400, 0, "MS Sans Serif")
$Label12 = GUICtrlCreateLabel("/", 808, 16, 9, 28)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
$Label13 = GUICtrlCreateLabel("4", 813, 32, 10, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
$Radio1 = GUICtrlCreateRadio("2/4", 688, 53, 35, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
$Radio2 = GUICtrlCreateRadio("4/4", 725, 53, 35, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetState(-1, $GUI_CHECKED)
$Radio3 = GUICtrlCreateRadio("0", 800, 52, 25, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
$Radio4 = GUICtrlCreateRadio("3/4", 762, 53, 35, 17)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup(" Preset ", 8, 0, 89, 273)
GUICtrlSetColor(-1, 0xFFFFFF)
XPStyle(0)
Dim $PSButton[13]
$PSButton[1] = GUICtrlCreateButton("F1", 16, 16, 33, 25)
$PSButton[2] = GUICtrlCreateButton("F2", 56, 16, 33, 25)
$PSButton[3] = GUICtrlCreateButton("F3", 16, 48, 33, 25)
$PSButton[4] = GUICtrlCreateButton("F4", 56, 48, 33, 25)
$PSButton[5] = GUICtrlCreateButton("F5", 16, 80, 33, 25)
$PSButton[6] = GUICtrlCreateButton("F6", 56, 80, 33, 25)
$PSButton[8] = GUICtrlCreateButton("F8", 56, 112, 33, 25)
$PSButton[7] = GUICtrlCreateButton("F7", 16, 112, 33, 25)
$PSButton[9] = GUICtrlCreateButton("F9", 16, 144, 33, 25)
$PSButton[10] = GUICtrlCreateButton("F10", 56, 144, 33, 25)
$PSButton[12] = GUICtrlCreateButton("F12", 56, 176, 33, 25)
$PSButton[11] = GUICtrlCreateButton("F11", 16, 176, 33, 25)
$PSButton[0] = GUICtrlCreateButton("Manager", 16, 208, 73, 17)
$Button3 = GUICtrlCreateButton("Bend", 15, 245, 71, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Dim $Form1_1_AccelTable[24][2] = [["a", $Button1],["'", $Button2],['{NUMPAD1}', $LPButton[1]],['{NUMPAD2}', $LPButton[2]],['{NUMPAD3}', $LPButton[3]],['{NUMPAD4}', $LPButton[4]],['{NUMPAD5}', $LPButton[5]],['{NUMPAD6}', $LPButton[6]],['{NUMPAD7}', $LPButton[7]],['{NUMPAD8}', $LPButton[8]],['{NUMPAD9}', $LPButton[9]],['{F1}', $PSButton[1]],['{F2}', $PSButton[2]],['{F3}', $PSButton[3]],['{F4}', $PSButton[4]],['{F5}', $PSButton[5]],['{F6}', $PSButton[6]],['{F7}', $PSButton[7]],['{F8}', $PSButton[8]],['{F9}', $PSButton[9]],['{F10}', $PSButton[10]],['{F11}', $PSButton[11]],['{F12}', $PSButton[12]],['{SPACE}', $Button3]]
GUISetAccelerators($Form1_1_AccelTable)



GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
_CreateKeyboard(112, 120, 713, 153, $aKeys)
#endregion ### END Koda GUI section ###
;======Set Data for Form
GUICtrlSetData($Label6, $q)
GUICtrlSetData($Label1, 'C' & $q & '-' & 'E' & $q + 2)
$Lsoundbank = _FileListToArray($P_Sb, '*', 1)
GUICtrlSetData($Combo1, StringReplace(_ArrayToString($Lsoundbank, '|', 1), '.wav', ''))
_GUICtrlComboBox_SetCurSel($Combo1, 12)
;======Start Bass======
_BASS_Startup()
;_BASS_FX_Startup()
_BASS_Init(0, -1, 44100, 0, "")

;=====Var 2=======
Global $aSample[$aKeys[0] + 1]
$aSample[0] = $aKeys[0]
$A1 = 45
Global $fFreqOriginal = _Note2Freq(69)


;===========Xay dung phim==============
Global $tKeys = DllStructCreate('byte[256];')
Global $pKeys = DllStructGetPtr($tKeys)
DllCall('user32.dll', 'int', 'GetKeyboardState', 'ptr', DllStructGetPtr($tKeys))
Global $aToogle[$aKeys[0] + 1]
For $i = 1 To $aKeys[0]
	$aToogle[$i] = BitAND(DllStructGetData($tKeys, 1, $aKeys[$i]), 0x0F)

Next

;=======Set Event========
GUICtrlSetOnEvent($Button1, '_Button')
GUICtrlSetOnEvent($Button2, '_Button')
GUICtrlSetOnEvent($Button4, '_Button')
GUICtrlSetOnEvent($Button5, '_Button')
GUICtrlSetOnEvent($Button6, '_Button')
GUICtrlSetOnEvent($BtnHelp, '_Button')
GUICtrlSetOnEvent($BtnAbout, '_Button')

GUICtrlSetOnEvent($LPButton[7], '_LP');7
GUICtrlSetOnEvent($LPButton[8], '_LP');8
GUICtrlSetOnEvent($LPButton[9], '_LP');9
GUICtrlSetOnEvent($LPButton[4], '_LP');4
GUICtrlSetOnEvent($LPButton[5], '_LP');5
GUICtrlSetOnEvent($LPButton[6], '_LP');6
GUICtrlSetOnEvent($LPButton[1], '_LP');1
GUICtrlSetOnEvent($LPButton[2], '_LP');2
GUICtrlSetOnEvent($LPButton[3], '_LP');3
GUICtrlSetOnEvent($Button16, '_LP');Manager

GUICtrlSetOnEvent($LP_Button1, '_LPm')
GUICtrlSetOnEvent($LP_Button2, '_LPm')
GUICtrlSetOnEvent($LP_Button3, '_LPm')
GUICtrlSetOnEvent($LP_Button4, '_LPm')
GUICtrlSetOnEvent($LP_Button5, '_LPm')
GUICtrlSetOnEvent($LP_Button6, '_LPm')
GUICtrlSetOnEvent($LP_Button7, '_LPm')
GUICtrlSetOnEvent($LP_Button8, '_LPm')
GUICtrlSetOnEvent($LP_Button9, '_LPm')

GUICtrlSetOnEvent($LP_Button11, '_LPm')
GUICtrlSetOnEvent($LP_Button12, '_LPm')

For $k = 0 To 12
	GUICtrlSetOnEvent($PSButton[$k], '_PS')
Next
GUICtrlSetOnEvent($Button3, '_Button');bend
GUICtrlSetOnEvent($PS_Button1, '_PSm')
GUICtrlSetOnEvent($PS_Button2, '_PSm')
;======Set SOund======
_KeySetSound(3, $sTone, -1)
_MetroSetSound('1p.wav', '0p.wav')
_LPSetSound()
_LPRefeshKey()
_PSRefeshKey()
_PSLoad()
;===SHOW GUI====
$Cnl = _WinAPI_GetKeyboardState()
If $Cnl[1] = 1 Then
	GUICtrlSetColor($Label17, 0x00FF00)
Else
	GUICtrlSetColor($Label17, 0xFF0000)
EndIf
GUISetState(@SW_SHOW)
;======WHILE===============
While 1
	_KeyEventWhile()
	_KeyResetWhile()
	_MetroWhile()
	_GUIdataChange()
	Sleep(10)
WEnd

;=====FUNC=======
Func _PSm()
	Switch @GUI_CtrlId
		Case $PS_Button2;save
			_PSSave()
			GUISetState(@SW_HIDE, $PS_Form1)
		Case $PS_Button1;cancel
			GUISetState(@SW_HIDE, $PS_Form1)
	EndSwitch
EndFunc   ;==>_PSm

Func _PS()
	Switch @GUI_CtrlId
		Case $PSButton[0]
			_PSLoad()
			GUISetState(@SW_SHOW, $PS_Form1)
		Case $PSButton[1]
			_PSSetSound(GUICtrlRead($PS_Combo[1]))
		Case $PSButton[2]
			_PSSetSound(GUICtrlRead($PS_Combo[2]))
		Case $PSButton[3]
			_PSSetSound(GUICtrlRead($PS_Combo[3]))
		Case $PSButton[4]
			_PSSetSound(GUICtrlRead($PS_Combo[4]))
		Case $PSButton[5]
			_PSSetSound(GUICtrlRead($PS_Combo[5]))
		Case $PSButton[6]
			_PSSetSound(GUICtrlRead($PS_Combo[6]))
		Case $PSButton[7]
			_PSSetSound(GUICtrlRead($PS_Combo[7]))
		Case $PSButton[8]
			_PSSetSound(GUICtrlRead($PS_Combo[8]))
		Case $PSButton[9]
			_PSSetSound(GUICtrlRead($PS_Combo[9]))
		Case $PSButton[10]
			_PSSetSound(GUICtrlRead($PS_Combo[10]))
		Case $PSButton[11]
			_PSSetSound(GUICtrlRead($PS_Combo[11]))
		Case $PSButton[12]
			_PSSetSound(GUICtrlRead($PS_Combo[12]))
	EndSwitch
EndFunc   ;==>_PS

Func _LPm()
	Switch @GUI_CtrlId
		Case $LP_Button1
			_MultiButton($LP_Input[1])
		Case $LP_Button2
			_MultiButton($LP_Input[2])
		Case $LP_Button3
			_MultiButton($LP_Input[3])
		Case $LP_Button4
			_MultiButton($LP_Input[4])
		Case $LP_Button5
			_MultiButton($LP_Input[5])
		Case $LP_Button6
			_MultiButton($LP_Input[6])
		Case $LP_Button7
			_MultiButton($LP_Input[7])
		Case $LP_Button8
			_MultiButton($LP_Input[8])
		Case $LP_Button9
			_MultiButton($LP_Input[9])
		Case $LP_Button12
			_LPSave()
			MsgBox(0, 'Virtual Key', 'Save complete!')
			GUISetState(@SW_HIDE, $LP_Form1)
		Case $LP_Button11
			GUISetState(@SW_HIDE, $LP_Form1)
	EndSwitch
EndFunc   ;==>_LPm

Func _LP()
	Switch @GUI_CtrlId
		Case $Button16
			_LPLoad()
			GUISetState(@SW_SHOW, $LP_Form1)
		Case $LPButton[7];7
			_LPPlaySound(7)
		Case $LPButton[8];8
			_LPPlaySound(8)
		Case $LPButton[9];9
			_LPPlaySound(9)
		Case $LPButton[4];4
			_LPPlaySound(4)
		Case $LPButton[5];5
			_LPPlaySound(5)
		Case $LPButton[6];6
			_LPPlaySound(6)
		Case $LPButton[1];1
			_LPPlaySound(1)
		Case $LPButton[2];2
			_LPPlaySound(2)
		Case $LPButton[3];3
			_LPPlaySound(3)
	EndSwitch
EndFunc   ;==>_LP

Func _KeyEventWhile()
	DllCall('user32.dll', 'int', 'GetKeyboardState', 'ptr', DllStructGetPtr($tKeys))
	For $i = 1 To $aKeys[0]
		If BitAND(DllStructGetData($tKeys, 1, $aKeys[$i]), 0xF0) Then
			If ControlGetFocus($Form1, '') <> $Edit1 Then ControlFocus($Form1, '', $Edit1)
			If _KeyIsBlack($i - 1) Then
				If $Label[$i - 1][3] <> 1 Then
					GUICtrlSetStyle($Label[$i - 1][0], -1, $WS_EX_CLIENTEDGE)
					GUICtrlSetBkColor($Label[$i - 1][0], '0xFFFFA9')
					GUICtrlSetBkColor($Label[$i - 1][1], '0xFFFFA9')
					GUICtrlSetBkColor($Label[$i - 1][2], '0xFFFFA9')
				EndIf
				$Label[$i - 1][3] = 1
				_Play($i, BitAND(DllStructGetData($tKeys, 1, $aKeys[$i]), 0x0F))
				$Time = TimerInit()
			Else
				If $Label[$i - 1][3] <> 1 Then
					GUICtrlSetStyle($Label[$i - 1][0], -1, $WS_EX_CLIENTEDGE)
					GUICtrlSetBkColor($Label[$i - 1][0], '0xFFFFA9')
					GUICtrlSetBkColor($Label[$i - 1][1], '0xFFFFA9')
					GUICtrlSetBkColor($Label[$i - 1][2], '0xFFFFA9')
				EndIf
				$Label[$i - 1][3] = 1
				_Play($i, BitAND(DllStructGetData($tKeys, 1, $aKeys[$i]), 0x0F))
				$Time = TimerInit()
			EndIf
		EndIf
	Next
EndFunc   ;==>_KeyEventWhile

Func _KeyResetWhile()
	For $i = 1 To $aKeys[0]
		If Not _IsPressed($aKeys[$i]) And $Label[$i - 1][3] = 1 And TimerDiff($Time) > 30 Then
			If _KeyIsBlack($i - 1) Then
				GUICtrlSetBkColor($Label[$i - 1][0], '0x000000')
				GUICtrlSetBkColor($Label[$i - 1][1], '0x000000')
				GUICtrlSetBkColor($Label[$i - 1][2], '0x000000')
			Else
				GUICtrlSetBkColor($Label[$i - 1][0], '0xFFFFFF')
				GUICtrlSetBkColor($Label[$i - 1][1], '0xFFFFFF')
				GUICtrlSetBkColor($Label[$i - 1][2], '0xFFFFFF')
			EndIf
			GUICtrlSetStyle($Label[$i - 1][0], -1, '')
			$Label[$i - 1][3] = ''
			$Time = TimerInit()
		EndIf
	Next
EndFunc   ;==>_KeyResetWhile

Func _Button()
	$a = @GUI_CtrlId
	Switch $a
		Case $Button1; <<
			If $q > 1 Then _KeySetSound($q - 1, $sTone, -1)
		Case $Button2; >>
			If $q < 4 Then _KeySetSound($q + 1, $sTone, -1)
			;Case $Button3; Change
			;	IF GUICtrlRead($Input1)+0 > 0 And  GUICtrlRead($Input1)+0 < 6 Then
			;		_SetSound(GUICtrlRead($Input1)+0, $sTone, -1)
			;		$q = GUICtrlRead($Input1)+0
			;	EndIF
		Case $Button4; set Tone
			_KeySetSound($q, GUICtrlRead($Combo1), -1)
		Case $Button5; <
			If $Key > 0 Then _KeySetSound(-1, -1, $Key - 1)
		Case $Button6; >
			If $Key < 12 Then _KeySetSound(-1, -1, $Key + 1)
		Case $Button3;bend
			$q2 = _Note2Freq(69 + ($cNote + 2) - 13 - (3 - $q) * 12 + $Key) * 44100 / $fFreqOriginal
			$db = _BASS_ChannelSlideAttribute($hChannel, $BASS_ATTRIB_FREQ, $q2, 500)
			;_BASS_ChannelSetAttribute($hChannel, $BASS_ATTRIB_MUSIC_BPM, 30)
		Case $BtnAbout
			MsgBox(64, "Virtual Keyboard", "VK 2.0 by LN Quy 02/2015")

		Case $BtnHelp
			ShellExecute("huongdan.bmp")
	EndSwitch
	_SetLCtroller()
EndFunc   ;==>_Button

Func _GUIdataChange()
	If $SliderGUI <> GUICtrlRead($Slider1) Then
		GUICtrlSetData($Label8, GUICtrlRead($Slider1))
		$SliderGUI = GUICtrlRead($Slider1)
	EndIf
	If $SliderGUI2 <> GUICtrlRead($Slider2) Then
		GUICtrlSetData($Label15, GUICtrlRead($Slider2))
		$SliderGUI2 = GUICtrlRead($Slider2)
	EndIf
	$Cnl = _WinAPI_GetKeyboardState()
	If $NL <> $Cnl[1] Then
		If $Cnl[1] = 1 Then
			GUICtrlSetColor($Label17, 0x00FF00)
		Else
			GUICtrlSetColor($Label17, 0xFF0000)
		EndIf
		$NL = $Cnl[1]
	EndIf
EndFunc   ;==>_GUIdataChange
;Phat cac not
Func _Play($iNote, $bToogle)
	If $aToogle[$iNote] = $bToogle Then Return
	$aToogle[$iNote] = $bToogle
	Global $hChannel = _BASS_SampleGetChannel($aSample[$iNote], False)
	Global $cNote = $iNote
	_BASS_ChannelPlay($hChannel, True)
	_BASS_ChannelSetVolume($hChannel, GUICtrlRead($Slider1))
	GUICtrlSetData($Input3, GuiCtrlRead($Input3)&'-'&$aNotes[_Return($iNote, 12) - 1] & (_Times($iNote-1, 12) + $q))
EndFunc   ;==>_Play

Func _Note2Freq($iNote, $iConcertPitch = 440)
	Return $iConcertPitch * 2 ^ (($iNote - 69) / 12)
EndFunc   ;==>_Note2Freq

Func _CreateKeyMatrix($sKeys, $sDelim = "|")
	Local $aSplit = StringSplit($sKeys, $sDelim)
	Local $aKeys[$aSplit[0] + 1]
	$aKeys[0] = $aSplit[0]
	For $i = 1 To $aSplit[0]
		$aKeys[$i] = Asc(StringUpper($aSplit[$i])) + 1
	Next
	Return $aKeys
EndFunc   ;==>_CreateKeyMatrix

Func _CreateKeyboard($iX, $iY, $iW, $iH, $aKeys)
	Local $fX = $iX
	Local $fW = Floor($iW / (7 * $aKeys[0] / 12))
	For $i = 0 To $aKeys[0] - 1
		Switch _KeyIsBlack($i)
			Case False
				$Label[$i][0] = GUICtrlCreateLabel("", $fX, $iY, $fW - 1, $iH)
				GUICtrlSetBkColor(-1, 0xFFFFFF)
				GUICtrlSetState(-1, $GUI_DISABLE)
				$Label[$i][1] = GUICtrlCreateLabel(Chr($aKeys[$i + 1] - 1), $fX + 3, $iY + $iH - 20, $fW - 6, 15, 0x01)
				GUICtrlSetBkColor(-1, 0xFFFFFF)
				$Label[$i][2] = GUICtrlCreateLabel($aNotes[_Return($i + 1, 12) - 1] & (_Times($i, 12) + $q), $fX + 3, $iY + $iH - 40, $fW - 6, 20, 0x01)
				GUICtrlSetBkColor(-1, 0xFFFFFF)
				GUICtrlSetState(-1, $GUI_DISABLE)
				$fX += $fW
		EndSwitch
	Next
	$fX = $iX
	For $i = 0 To $aKeys[0] - 1
		Switch _KeyIsBlack($i)
			Case False
				$fX += $fW
			Case Else
				$Label[$i][0] = GUICtrlCreateLabel("", $fX - $fW * 0.3, $iY, $fW * 0.7, $iH * 0.6)
				GUICtrlSetBkColor(-1, 0)
				GUICtrlSetState(-1, $GUI_DISABLE)
				$Label[$i][1] = GUICtrlCreateLabel(Chr($aKeys[$i + 1] - 1), $fX - $fW * 0.2, $iY + $iH * 0.6 - 20, $fW * 0.4, 15, 0x01)
				GUICtrlSetColor(-1, 0xFFFFFF)
				$Label[$i][2] = GUICtrlCreateLabel($aNotes[_Return($i + 1, 12) - 1] & (_Times($i, 12) + $q), $fX - $fW * 0.25, $iY + $iH * 0.6 - 40, $fW * 0.6, 20, 0x01)
				GUICtrlSetFont(-1, 9)
				GUICtrlSetColor(-1, 0xFFFFFF)
				GUICtrlSetBkColor(-1, 0)
				GUICtrlSetState(-1, $GUI_DISABLE)
		EndSwitch
	Next
EndFunc   ;==>_CreateKeyboard

Func _SetLabel($ob)
	For $i = 0 To $aKeys[0] - 1
		If _KeyIsBlack($i) Then
			$Note = StringLeft(GUICtrlRead($Label[$i][2]), 2)
		Else
			$Note = StringLeft(GUICtrlRead($Label[$i][2]), 1)
		EndIf
		GUICtrlSetData($Label[$i][2], $Note & (_Times($i, 12) + $q))
	Next
EndFunc   ;==>_SetLabel

Func _SetLCtroller()
	GUICtrlSetData($Label5, $Key)
	GUICtrlSetData($Label6, $q)
	GUICtrlSetData($Label1, 'C' & $q & '-' & 'E' & $q + 2)
EndFunc   ;==>_SetLCtroller

Func _KeyIsBlack($iNote)
	Switch Mod($iNote, 12)
		Case 1, 3, 6, 8, 10
			Return True
		Case Else
			Return False
	EndSwitch
EndFunc   ;==>_KeyIsBlack

Func _Return($idex, $vong)
	If $idex <= $vong Then
		Return $idex
	Else
		Return _Return($idex - $vong, $vong)
	EndIf
EndFunc   ;==>_Return

Func _Times($idex, $vong)
	If $idex < $vong Then
		Return 0
	Else
		Return Int($idex / $vong)
	EndIf
EndFunc   ;==>_Times

Func _KeySetSound($ob, $soundbank, $delta)
	If $ob = -1 Then $ob = $q
	If $soundbank = -1 Then $soundbank = $sTone
	If $delta = -1 Then $delta = $Key
	$sPath = $P_Sb & $soundbank & '.wav'
	For $i = 1 To $aKeys[0]
		$aSample[$i] = _Bass_SampleLoad(False, $sPath, 0, 0, 12, 0) ; C4
		$aInfo = _BASS_SampleGetInfo($aSample[$i]) ;Get info
		$aInfo[0] = _Note2Freq(69 + $i - 13 - (3 - $ob) * 12 + $delta) * $aInfo[0] / $fFreqOriginal ;Tao Freq
		_BASS_SampleSetInfo($aSample[$i], $aInfo) ;Set Freq
		;GUICtrlSetData($Progress1, Round(($i / $aKeys[0]) * 100))
	Next
	$q = $ob
	$sTone = $soundbank
	$Key = $delta
	_SetLabel($ob)
	GUICtrlSetData($Input2, $soundbank)
EndFunc   ;==>_KeySetSound

Func _MetroSetSound($1p, $0p)
	$Msample[0] = _Bass_SampleLoad(False, $P_Me & $1p, 0, 0, 12, 0); Phach 1
	$Msample[1] = _Bass_SampleLoad(False, $P_Me & $0p, 0, 0, 12, 0); Phach 0
EndFunc   ;==>_MetroSetSound

Func _MetroSetStatus($stt)
	If $stt = $GUI_CHECKED Then
		$Metro = True
		$Bmp = GUICtrlRead($Input1) + 0
		$iMetro = 1
	Else
		$Metro = False
	EndIf
EndFunc   ;==>_MetroSetStatus

Func _MetroWhile()
	;Check On/Off
	If $MetroGUI <> GUICtrlRead($Checkbox1) Then
		_MetroSetStatus(GUICtrlRead($Checkbox1))
		$MetroGUI = GUICtrlRead($Checkbox1)
	EndIf
	;Check Bar
	If GUICtrlRead($Radio1) & GUICtrlRead($Radio2) & GUICtrlRead($Radio3) & GUICtrlRead($Radio4) <> $sRadio Then
		If GUICtrlRead($Radio1) = $GUI_CHECKED Then
			$bMetro = 2
			GUICtrlSetData($Label13, 2)
		ElseIf GUICtrlRead($Radio2) = $GUI_CHECKED Then
			$bMetro = 4
			GUICtrlSetData($Label13, 4)
		ElseIf GUICtrlRead($Radio3) = $GUI_CHECKED Then
			$bMetro = 0
			GUICtrlSetData($Label13, 'N')
		Else
			$bMetro = 3
			GUICtrlSetData($Label13, 3)
		EndIf
		$sRadio = GUICtrlRead($Radio1) & GUICtrlRead($Radio2) & GUICtrlRead($Radio3) & GUICtrlRead($Radio4)
		$iMetro = 1
	EndIf
	;Play sound


	If TimerDiff($MetroTime) > (60 / $Bmp * 1000) And $Metro = True Then
		Local $MChannel
		If $iMetro = 1 Then
			$MChannel = _BASS_SampleGetChannel($Msample[0], False)
			GUICtrlSetColor($Label11, 0x00FF00)
		Else
			$MChannel = _BASS_SampleGetChannel($Msample[1], False)
			GUICtrlSetColor($Label11, 0xFFFFFF)
		EndIf
		GUICtrlSetData($Label11, $iMetro)
		_BASS_ChannelPlay($MChannel, True)
		;Check bMetro & iMetro
		If $bMetro <> 0 Then
			If $iMetro = $bMetro Then
				$iMetro = 1
			Else
				$iMetro += 1
			EndIf
		Else
			$iMetro = 0
			GUICtrlSetData($Label11, 0)
		EndIf
		$MetroTime = TimerInit()
	EndIf
EndFunc   ;==>_MetroWhile

Func _LPSetSound()
	For $k = 1 To 9
		If IniRead($P_LP, $k, 'Path', '') <> '' Then $LPsample[$k] = _Bass_SampleLoad(False, IniRead($P_LP, $k, 'Path', ''), 0, 0, 12, 0)
	Next
EndFunc   ;==>_LPSetSound

Func _LPPlaySound($idex)
	If $LPsample[$idex] <> '' Then
		$LPChannel = _BASS_SampleGetChannel($LPsample[$idex], False)
		_BASS_ChannelPlay($LPChannel, True)
		_BASS_ChannelSetVolume($LPChannel, GUICtrlRead($Slider2) * 10)
	EndIf
EndFunc   ;==>_LPPlaySound

Func _MultiButton($iHandle)
	$TFile = FileOpenDialog('Load file...', '', 'SoundFX(*.wav)')
	If Not @error Then GUICtrlSetData($iHandle, $TFile)
EndFunc   ;==>_MultiButton

Func _LPSave()
	For $k = 1 To 9
		IniWrite($P_LP, $k, 'Path', GUICtrlRead($LP_Input[$k]))
	Next
	_LPRefeshKey()
EndFunc   ;==>_LPSave

Func _LPLoad()
	For $k = 1 To 9
		GUICtrlSetData($LP_Input[$k], IniRead($P_LP, $k, 'Path', ''))
	Next
EndFunc   ;==>_LPLoad

Func _LPRefeshKey()
	Local $Tstt
	For $k = 1 To 9
		If IniRead($P_LP, $k, 'Path', '') = '' Then
			$Tstt = $GUI_DISABLE
		Else
			$Tstt = $GUI_ENABLE
		EndIf
		GUICtrlSetState($LPButton[$k], $Tstt)
	Next
EndFunc   ;==>_LPRefeshKey

Func _PSSave()
	For $k = 1 To 12
		IniWrite($P_PS, $k, 'Path', GUICtrlRead($PS_Combo[$k]))
	Next
	MsgBox(0, 'Virtual Keyboad', 'Save complete!')
	_PSRefeshKey()
EndFunc   ;==>_PSSave

Func _PSLoad()
	Local $data = 'None|' & StringReplace(_ArrayToString($Lsoundbank, '|', 1), '.wav', '')
	For $k = 1 To 12
		GUICtrlSetData($PS_Combo[$k], $data)
	Next

	For $k = 1 To 12
		_GUICtrlComboBox_SetCurSel($PS_Combo[$k], _GUICtrlComboBox_FindString($PS_Combo[$k], IniRead($P_PS, $k, 'Path', '')))
	Next
EndFunc   ;==>_PSLoad

Func _PSRefeshKey()
	Local $Tstt
	For $k = 1 To 12
		If IniRead($P_PS, $k, 'Path', '') = 'None' Then
			$Tstt = $GUI_DISABLE
		Else
			$Tstt = $GUI_ENABLE
		EndIf
		GUICtrlSetState($PSButton[$k], $Tstt)
	Next
EndFunc   ;==>_PSRefeshKey

Func _PSSetSound($Sound)
	If $Sound <> 'None' Then
		_KeySetSound(-1, $Sound, -1)
	EndIf
EndFunc   ;==>_PSSetSound

Func _WinAPI_GetKeyboardState()
	Local $tByteArray, $pByteArray, $oArray[3]
	Local $aRet, $avKeys[3] = ["0x14", "0x90", "0x91"], $k ; cap,num,scroll
	$tByteArray = DllStructCreate('ubyte[256]')
	$pByteArray = DllStructGetPtr($tByteArray)
	$aRet = DllCall('user32.dll', 'int', 'GetKeyboardState', 'ptr', $pByteArray)
	If @error Or $aRet[0] = 0 Then Return SetError(1, 0, 0)

	For $k = 0 To 2
		If BitAND(1, DllStructGetData($tByteArray, 1, $avKeys[$k] + 1)) Then
			$oArray[$k] = 1
		Else
			$oArray[$k] = 0
		EndIf
	Next
	Return $oArray
EndFunc   ;==>_WinAPI_GetKeyboardState

Func XPStyle($onoff = 1)
	If Not StringInStr(@OSType, "WIN32_NT") Then Return
	If $onoff Then
		$XS_n = DllCall('uxtheme.dll', 'int', "GetThemeAppProperties")
		DllCall('uxtheme.dll', 'none', 'SetThemeAppProperties', 'int', 0)
		Return 1
	ElseIf IsArray($XS_n) Then
		DllCall('uxtheme.dll', 'none', 'SetThemeAppProperties', 'int', $XS_n[0])
		$XS_n = ''
		Return 1
	EndIf
	Return 0
EndFunc   ;==>XPStyle

Func _Exit()
	For $i = 1 To $aSample[0]
		_BASS_SampleFree($aSample[$i])
	Next
	For $i = 1 To 9
		_Bass_SampleFree($LPsample[$i])
	Next
	_Bass_SampleFree($Msample[0])
	_Bass_SampleFree($Msample[1])
	_BASS_Free()
	Exit
EndFunc   ;==>_Exit