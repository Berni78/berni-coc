; #FUNCTION# ====================================================================================================================
; Name ..........: CheckVersion
; Description ...: Check if we have last version of program
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: Sardo (2015-06)
; Modified ......:
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

Func CheckVersion()
	If $ichkVersion = 1 Then
		CheckVersionHTML()
		If $lastversion = "" Then
			SetLog("WE CANNOT OBTAIN PRODUCT VERSION AT THIS TIME", $COLOR_ORANGE)
		ElseIf VersionNumFromVersionTXT($sBotVersion) < VersionNumFromVersionTXT($lastversion) Then
			SetLog("WARNING, YOUR BOT VERSION (" & $sBotVersion & ") IS OUT OF DATE.", $COLOR_RED)
			SetLog("PLEASE DOWNLOAD THE LATEST(" & $lastversion & ") FROM https://GameBot.org               ", $COLOR_RED)
			SetLog(" ")
			_PrintLogVersion($oldversmessage)
		ElseIf VersionNumFromVersionTXT($sBotVersion) > VersionNumFromVersionTXT($lastversion) Then
			SetLog("YOU ARE USING A FUTURE VERSION OF CLASH GAMEBOT CHIEF!", $COLOR_GREEN)
			SetLog("YOUR VERSION: " & $sBotVersion, $COLOR_GREEN)
			SetLog("OFFICIAL VERSION: " & $lastversion, $COLOR_GREEN)
			SetLog(" ")
		Else
			SetLog("WELCOME CHIEF, YOU HAVE THE LATEST VERSION OF THE BOT", $COLOR_GREEN)
			SetLog(" ")
			_PrintLogVersion($lastmessage)
		EndIf
	EndIf
EndFunc   ;==>CheckVersion

;~ Func CheckVersionTXT()
;~ 	;download page from site contains last bot version
;~ 	$hLastVersion = InetGet("https://gamebot.org/lastversion.txt", @ScriptDir & "\LastVersion.txt")
;~ 	InetClose($hLastVersion)

;~ 	;search version into downloaded page
;~ 	Local $f, $line, $Casesense = 0
;~ 	$lastversion = ""
;~ 	If FileExists(@ScriptDir & "\LastVersion.txt") Then
;~ 		$f = FileOpen(@ScriptDir & "\LastVersion.txt", 0)
;~ 		; Read in lines of text until the EOF is reached
;~ 		While 1
;~ 			$line = FileReadLine($f)
;~ 			If @error = -1 Then ExitLoop
;~ 			If StringInStr($line, "version=", $Casesense) Then
;~ 				$lastversion = StringMid($line, 9, -1)
;~ 			EndIf
;~ 			If StringInStr($line, "message=", $Casesense) Then
;~ 				$lastmessage = StringMid($line, 9, -1)
;~ 			EndIf
;~ 		WEnd
;~ 		FileClose($f)
;~ 		FileDelete(@ScriptDir & "\LastVersion.txt")
;~ 	EndIf
;~ EndFunc   ;==>CheckVersionTXT


Func CheckVersionHTML()
	If FileExists(@ScriptDir & "\TestVersion.txt") Then
		FileCopy(@ScriptDir & "\TestVersion.txt", @ScriptDir & "\LastVersion.txt", 1)
	Else
		;download page from site contains last bot version
		$hDownload = InetGet("https://raw.githubusercontent.com/ClashGameBot/CGB/master/LastVersion.txt", @ScriptDir & "\LastVersion.txt")

		; Wait for the download to complete by monitoring when the 2nd index value of InetGetInfo returns True.
		Local $i=0
		Do
			Sleep($iDelayCheckVersionHTML1)
			$i +=1
		Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE) or $i > 10

		InetClose($hDownload)
	EndIf

	;search version into downloaded page
	Local $f, $line, $line2, $Casesense = 0, $chkvers = False, $chkmsg = False, $chkmsg2 = False, $i = 0, $versionfile = @ScriptDir & "\LastVersion.txt"
	$lastversion = ""
	If FileExists($versionfile) Then
		$f = FileOpen(@ScriptDir & "\LastVersion.txt", 0)
		$lastversion = IniRead($versionfile,"general","version","")
		$lastmessage  = IniRead($versionfile,"general","messagenew","")
		$oldversmessage  = IniRead($versionfile,"general","messageold","")
		FileClose($f)
		FileDelete(@ScriptDir & "\LastVersion.txt")
	EndIf
EndFunc   ;==>CheckVersionHTML


Func VersionNumFromVersionTXT($versionTXT)
	; remove all after a space from $versionTXT, example "v.4.0.1 MOD" ==> "v.4.0.1"
	Local $versionTXT_clean
	If StringInStr($versionTXT, " ") Then
		$versionTXT_clean = StringLeft($versionTXT, StringInStr($versionTXT, " ") - 1)
	Else
		$versionTXT_clean = $versionTXT
	EndIf

	Local $resultnumber = 0
	If StringLeft($versionTXT_clean, 1) = "v" Then
		Local $versionTXT_Vector = StringSplit(StringMid($versionTXT_clean, 2, -1), ".")
		Local $multiplier = 1000000
		If UBound($versionTXT_Vector) > 0 Then
			For $i = 1 To UBound($versionTXT_Vector) - 1
				$resultnumber = $resultnumber + Number($versionTXT_Vector[$i]) * $multiplier
				$multiplier = $multiplier / 1000
			Next
		Else
			$resultnumber = Number($versionTXT_Vector) * $multiplier
		EndIf
	EndIf
	Return $resultnumber
EndFunc   ;==>VersionNumFromVersionTXT





Func _PrintLogVersion($message)
	Local $messagevet = StringSplit($message, "\n", 1)
	If Not (IsArray($messagevet)) Then
		Setlog($message)
	Else
		For $i = 1 To $messagevet[0]
			If StringLen($messagevet[$i]) <= 53 Then
				SetLog($messagevet[$i], $COLOR_BLACK, "Lucida Console", 8.5)
			Else
				While StringLen($messagevet[$i]) > 53
					Local $sp = StringInStr(StringLeft($messagevet[$i], 53), " ", 0, -1) ; find last occurrence of space
					If $sp = 0 Then ;no found spaces
						Local $sp = StringInStr($messagevet[$i], " ", 0) ; find first occurrence of space
						If $sp = 0 Then
							SetLog($messagevet[$i], $COLOR_BLACK, "Lucida Console", 8.5)
						Else
							SetLog(StringLeft($messagevet[$i], $sp), $COLOR_BLACK, "Lucida Console", 8.5)
							$messagevet[$i] = StringMid($messagevet[$i], $sp + 1, -1)
						EndIf
					Else
						SetLog(StringLeft($messagevet[$i], $sp), $COLOR_BLACK, "Lucida Console", 8.5)
						$messagevet[$i] = StringMid($messagevet[$i], $sp + 1, -1)
					EndIf
				WEnd
				If StringLen($messagevet[$i]) > 0 Then SetLog($messagevet[$i], $COLOR_BLACK, "Lucida Console", 8.5)
			EndIf
		Next
	EndIf
EndFunc   ;==>_PrintLogVersion
