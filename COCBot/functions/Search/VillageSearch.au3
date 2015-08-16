
; #FUNCTION# ====================================================================================================================
; Name ..........: VillageSearch
; Description ...: Searches for a village that until meets conditions
; Syntax ........: VillageSearch()
; Parameters ....:
; Return values .: None
; Author ........: Code Monkey #6
; Modified ......: KGNS (June 2015)
; Remarks .......:This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func VillageSearch() ;Control for searching a village that meets conditions
	$iSkipped = 0

	If $Is_ClientSyncError = False Then
		For $i = 0 to $iModeCount - 1
			$iAimGold[$i] = $iMinGold[$i]
			$iAimElixir[$i] = $iMinElixir[$i]
			$iAimGoldPlusElixir[$i] = $iMinGoldPlusElixir[$i]
			$iAimDark[$i] = $iMinDark[$i]
			$iAimTrophy[$i] = $iMinTrophy[$i]
		Next
	EndIf

	_WinAPI_EmptyWorkingSet(WinGetProcess($Title))

	If _Sleep(1000) Then Return

;	; Check Break Shield button again
;	If _CheckPixel($aBreakShield, $bCapturePixel) Then
;		ClickP($aBreakShield, 1, 0, "#0154");Click Okay To Break Shield
;	EndIf

	For $x = 0 To $iModeCount - 1
		If $x = $iCmbSearchMode Or $iCmbSearchMode = 2 Then

			SetLog(_PadStringCenter(" Searching For " & $sModeText[$x] & " ", 54, "="), $COLOR_BLUE)

			Local $MeetGxEtext = "", $MeetGorEtext = "", $MeetGplusEtext = "", $MeetDEtext = "", $MeetTrophytext = "", $MeetTHtext = "", $MeetTHOtext = "", $MeetWeakBasetext = "", $EnabledAftertext = ""

			SetLog(_PadStringCenter(" SEARCH CONDITIONS ", 50, "~"), $COLOR_BLUE)

			If $iCmbMeetGE[$x] = 0 Then $MeetGxEtext = "Meet: Gold and Elixir"
			If $iCmbMeetGE[$x] = 1 Then $MeetGorEtext = "Meet: Gold or Elixir"
			If $iCmbMeetGE[$x] = 2 Then $MeetGplusEtext = "Meet: Gold + Elixir"
			If $iChkMeetDE[$x] = 1 Then $MeetDEtext = ", Dark"
			If $iChkMeetTrophy[$x] = 1 Then $MeetTrophytext = ", Trophy"
			If $iChkMeetTH[$x] = 1 Then $MeetTHtext = ", Max TH " & $iMaxTH[$x] ;$icmbTH
			If $iChkMeetTHO[$x] = 1 Then $MeetTHOtext = ", TH Outside"
			If $iChkWeakBase[$x] = 1 Then $MeetWeakBasetext = ", Weak Base(Mortar: " & $iCmbWeakMortar[$x] & ", WizTower: " & $iCmbWeakWizTower[$x] & ")"
			If $iChkEnableAfter[$x] = 1 Then $EnabledAftertext = ", Enabled after " & $iEnableAfterCount[$x] & " searches"

			SetLog($MeetGxEtext & $MeetGorEtext & $MeetGplusEtext & $MeetDEtext & $MeetTrophytext & $MeetTHtext & $MeetTHOtext & $MeetWeakBasetext & $EnabledAftertext)

			If $iChkMeetOne[$x] = 1 Then SetLog("Meet One and Attack!")

			SetLog(_PadStringCenter(" RESOURCE CONDITIONS ", 50, "~"), $COLOR_BLUE)
			If $iChkMeetTH[$x] = 1 Then $iAimTHtext[$x] = " [TH]:" & StringFormat("%2s", $iMaxTH[$x]) ;$icmbTH
			If $iChkMeetTHO[$x] = 1 Then $iAimTHtext[$x] &= ", Out"


			If $iCmbMeetGE[$x] = 2 Then
				SetLog("Aim:           [G+E]:" & StringFormat("%7s", $iAimGoldPlusElixir[$x]) & " [D]:" & StringFormat("%5s", $iAimDark[$x]) & " [T]:" & StringFormat("%2s", $iAimTrophy[$x]) & $iAimTHtext[$x] & " for: " & $sModeText[$x], $COLOR_GREEN, "Lucida Console", 7.5)
			Else
				SetLog("Aim: [G]:" & StringFormat("%7s", $iAimGold[$x]) & " [E]:" & StringFormat("%7s", $iAimElixir[$x]) & " [D]:" & StringFormat("%5s", $iAimDark[$x]) & " [T]:" & StringFormat("%2s", $iAimTrophy[$x]) & $iAimTHtext[$x] & " for: " & $sModeText[$x], $COLOR_GREEN, "Lucida Console", 7.5)
			EndIf

		EndIf
	Next

	If $OptBullyMode + $OptTrophyMode + $chkATH > 0 Then
		SetLog(_PadStringCenter(" ADVANCED SETTINGS ", 50, "~"), $COLOR_BLUE)
		Local $YourTHText = "", $AttackTHTypeText = "", $chkATHText = "", $OptTrophyModeText = ""

		If $OptBullyMode = 1 Then
			For $i = 0 To 4
				If $YourTH = $i Then $YourTHText = "TH" & $THText[$i]
			Next
		EndIf

		If $OptBullyMode = 1 Then SetLog("THBully Combo @" & $ATBullyMode & " SearchCount, " & $YourTHText)

		If $chkATH = 1 Then $chkATHText = "AttackTH"
		If $chkATH = 1 And $AttackTHType = 0 Then $AttackTHTypeText = ", Barch"
		If $chkATH = 1 And $AttackTHType = 1 Then $AttackTHTypeText = ", Attack1:Normal"
		If $chkATH = 1 And $AttackTHType = 2 Then $AttackTHTypeText = ", Attack2:Extreme"
		If $chkATH = 1 And $AttackTHType = 3 Then $AttackTHTypeText = ", Attack3:GBarch"
		If $OptTrophyMode = 1 Then $OptTrophyModeText = "THSnipe Combo, " & $THaddtiles & " Tile(s), "
		If $OptTrophyMode = 1 Or $chkATH = 1 Then SetLog($OptTrophyModeText & $chkATHText & $AttackTHTypeText)
	EndIf

	SetLog(_StringRepeat("=", 50), $COLOR_BLUE)

	If $iChkAttackNow = 1 Then
		GUICtrlSetState($btnAttackNowDB, $GUI_SHOW)
		GUICtrlSetState($btnAttackNowLB, $GUI_SHOW)
		GUICtrlSetState($btnAttackNowTS, $GUI_SHOW)
		GUICtrlSetState($pic2arrow, $GUI_HIDE)
		GUICtrlSetState($lblVersion, $GUI_HIDE)
	EndIf

	If $Is_ClientSyncError = False Then
		$SearchCount = 0
	EndIf

	While 1
		If $iVSDelay > 0 Then
			If _Sleep(1000 * $iVSDelay) Then Return
		EndIf

		If $Restart = True Then Return ; exit func
		GetResources() ;Reads Resource Values
		If $Restart = True Then Return ; exit func
		$bBtnAttackNowPressed = False
		;If $bBtnAttackNowPressed = True Then ExitLoop

		If Mod(($iSkipped + 1), 100) = 0 Then
			_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; reduce BS memory
			If _Sleep(1000) Then Return
			If CheckZoomOut() = False Then Return
		EndIf

		Local $noMatchTxt = ""
		Local $dbBase = False
		Local $matchDB = False
		Local $matchLB = False
		Local $isWeakBase[$iModeCount]
		For $x = 0 To $iModeCount - 1
			$isWeakBase[$x] = False
			If ($x = $iCmbSearchMode Or $iCmbSearchMode = 2) And $iChkWeakBase[$x] = 1 Then
				_WinAPI_DeleteObject($hBitmapFirst)
				$hBitmapFirst = _CaptureRegion2()
				Local $resultHere = DllCall($pFuncLib, "str", "CheckConditionForWeakBase", "ptr", $hBitmapFirst, "int", ($iCmbWeakMortar[$x] + 1), "int", ($iCmbWeakWizTower[$x] + 1), "int", 10)
				If $resultHere[0] = "Y" Then
					$isWeakBase[$x] = True
				EndIf
			EndIf
		Next
		If $iCmbSearchMode = 0 Then
			$matchDB = CompareResources($DB, $isWeakBase[$DB])
		ElseIf $iCmbSearchMode = 1 Then
			$matchLB = CompareResources($LB, $isWeakBase[$LB])
		Else
			If IsSearchModeActive($DB) Then $matchDB = CompareResources($DB, $isWeakBase[$DB])
			If IsSearchModeActive($LB) Then $matchLB = CompareResources($LB, $isWeakBase[$LB])
		EndIf
		If $matchDB Or $matchLB Then
			$dbBase = checkDeadBase()
		EndIf
		If $matchDB And $dbBase Then
			SetLog(_PadStringCenter(" Dead Base Found! ", 50, "~"), $COLOR_GREEN)
			$iMatchMode = $DB
			ExitLoop
		ElseIf $matchLB And Not $dbBase Then
			SetLog(_PadStringCenter(" Live Base Found! ", 50, "~"), $COLOR_GREEN)
			$iMatchMode = $LB
			ExitLoop
		ElseIf $matchLB Or $matchDB Then
			If $OptBullyMode = 1 And ($SearchCount >= $ATBullyMode) Then
				If $SearchTHLResult = 1 Then
					SetLog(_PadStringCenter(" Not a match, but TH Bully Level Found! ", 50, "~"), $COLOR_GREEN)
					$iMatchMode = $iTHBullyAttackMode
					ExitLoop
				EndIf
			EndIf
		EndIf
		;If $bBtnAttackNowPressed = True Then ExitLoop
		If $OptTrophyMode = 1 Then ;Enables Triple Mode Settings ;---compare resources
			If SearchTownHallLoc() Then ; attack this base anyway because outside TH found to snipe
				SetLog(_PadStringCenter(" TH Outside Found! ", 50, "~"), $COLOR_GREEN)
				$iMatchMode = $TS
				ExitLoop
			EndIf
		EndIf
		;If $bBtnAttackNowPressed = True Then ExitLoop
		For $x = 0 To $iModeCount - 1
			If ($x = $iCmbSearchMode Or $iCmbSearchMode = 2) And $iChkWeakBase[$x] = 1 And Not $isWeakBase[$x] Then
				$noMatchTxt &= ", Not a Weak Base for " & $sModeText[$x]
			EndIf
		Next
		If $matchDB And Not $dbBase Then
			$noMatchTxt &= ", Not a " & $sModeText[$DB]
		ElseIf $matchLB And $dbBase Then
			$noMatchTxt &= ", Not a " & $sModeText[$LB]
		EndIf
 		If $noMatchTxt <> "" Then
			SetLog(_PadStringCenter(" " & StringMid($noMatchTxt, 3) & " ", 50, "~"), $COLOR_PURPLE)
		EndIf
		;If $bBtnAttackNowPressed = True Then ExitLoop
		If $iChkAttackNow = 1 Then
			If _Sleep(1000 * $iAttackNowDelay) Then Return ; add human reaction time on AttackNow button function
		EndIf
		If $bBtnAttackNowPressed = True Then ExitLoop
		ClickP($NextBtn,1,0,"#0155") ;Click Next
		If _Sleep(500) Then Return
		If isGemOpen(True) = True Then
			Setlog(" Not enough gold to keep searching.....", $COLOR_RED)
			Click(585, 252,1,0,"#0156")  ; Click close gem window "X"
			If _Sleep(500) Then Return
			$OutOfGold = 1  ; Set flag for out of gold to search for attack
			ReturnHome(False, False)
			Return
		EndIf
		$iSkipped = $iSkipped + 1
		GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
	WEnd

	If $bBtnAttackNowPressed = True Then
		Setlog(_PadStringCenter(" Attack Now Pressed! ", 50, "~"), $COLOR_GREEN)
	EndIf

	If $iChkAttackNow = 1 Then
		GUICtrlSetState($btnAttackNowDB, $GUI_HIDE)
		GUICtrlSetState($btnAttackNowLB, $GUI_HIDE)
		GUICtrlSetState($btnAttackNowTS, $GUI_HIDE)
		GUICtrlSetState($pic2arrow, $GUI_SHOW)
		GUICtrlSetState($lblVersion, $GUI_SHOW)
		$bBtnAttackNowPressed = False
	EndIf

	If $AlertSearch = 1 Then
		TrayTip($sModeText[$iMatchMode] & " Match Found!", "Gold: " & $searchGold & "; Elixir: " & $searchElixir & "; Dark: " & $searchDark & "; Trophy: " & $searchTrophy, "", 0)
		If FileExists(@WindowsDir & "\media\Festival\Windows Exclamation.wav") Then
			SoundPlay(@WindowsDir & "\media\Festival\Windows Exclamation.wav", 1)
		ElseIf FileExists(@WindowsDir & "\media\Windows Exclamation.wav") Then
			SoundPlay(@WindowsDir & "\media\Windows Exclamation.wav", 1)
		EndIf
	EndIf

	SetLog(_PadStringCenter(" Search Complete ", 50, "="), $COLOR_BLUE)
	PushMsg("MatchFound")

	; TH Detection Check Once Conditions
	If $OptBullyMode = 0 And $OptTrophyMode = 0 And $iChkMeetTH[$iMatchMode] = 0 And $iChkMeetTHO[$iMatchMode] = 0 And $chkATH = 1 Then
		$searchTH = checkTownhallADV()
		If SearchTownHallLoc() = False And $searchTH <> "-" Then
			SetLog("Checking Townhall location: TH is inside, skip Attack TH")
		ElseIf $searchTH <> "-" Then
			SetLog("Checking Townhall location: TH is outside, Attacking Townhall!")
		Else
			SetLog("Checking Townhall location: Could not locate TH, skipping attack TH...")
		EndIf
	EndIf

;~	_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; reduce BS Memory

;~	readConfig()
	_BlockInputEx(0, "", "", $HWnD) ; block all keyboard keys

	$Is_ClientSyncError = False

EndFunc   ;==>VillageSearch

Func IsSearchModeActive($pMode)
	If $iChkEnableAfter[$pMode] = 0 Then Return True
	If $SearchCount = $iEnableAfterCount[$pMode] Then SetLog(_PadStringCenter(" " & $sModeText[$pMode] & " search conditions are activated! ", 50, "~"), $COLOR_BLUE)
	If $SearchCount >= $iEnableAfterCount[$pMode] Then Return True
	Return False
EndFunc
