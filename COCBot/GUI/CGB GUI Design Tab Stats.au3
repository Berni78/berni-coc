; #FUNCTION# ====================================================================================================================
; Name ..........: CGB GUI Design
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: GKevinOD (2014)
; Modified ......: DkEd, Hervidero (2015)
; Remarks .......: This file is part of ClashGameBot. Copyright 2015
;                  ClashGameBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================

;~ -------------------------------------------------------------
;~ This dummy is used in btnStart and btnStop to disable/enable all labels, text, buttons etc. on all tabs.
;~ -------------------------------------------------------------
Global $LastControlToHide = GUICtrlCreateDummy()
Global $iPrevState[$LastControlToHide + 1]
;~ -------------------------------------------------------------

;~ -------------------------------------------------------------
;~ Stats Tab
;~ -------------------------------------------------------------
$tabStats = GUICtrlCreateTabItem("Stats")
; started with

Local $x = 30, $y = 150
	$grpResourceOnStart = GUICtrlCreateGroup("Started with", $x - 20, $y - 20, 108, 133)
		$lblResultStatsTemp = GUICtrlCreateLabel("Report" & @CRLF & "will appear" & @CRLF & "here on" & @CRLF & "first run.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65, $y, 16, 16)
		$lblResultGoldStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Gold you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65, $y, 16, 16)
		$lblResultElixirStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Elixir you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		$picResultDEStart = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 65, $y, 16, 16)
		;GUICtrlSetState($picResultDEStart, $GUI_HIDE)
		$lblResultDEStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Dark Elixir you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 65, $y, 16, 16)
		$lblResultTrophyStart = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

; Last Attack

	$x += 113
	$y = 150
	$grpLastAttack = GUICtrlCreateGroup("Last Attack", $x - 20, $y - 20, 108, 133)
		$lblLastAttackTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65, $y, 16, 16)
		$lblGoldLastAttack = GUICtrlCreateLabel("", $x-3, $y-2, 60, 17, $SS_RIGHT)
		$lblLootBonusGold =GUICtrlCreateLabel("", $x-3, $y +11, 60, 17, $SS_RIGHT)
		$lblLootBonusGold1 =GUICtrlCreateLabel("", $x+60, $y +11, 10, 17, $SS_RIGHT)
			$txtTip = "The amount of Gold you gained on the last attack."
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65, $y, 16, 16)
		$lblElixirLastAttack = GUICtrlCreateLabel("", $x-3, $y -2, 60, 17, $SS_RIGHT)
		$lblLootBonusElixir =GUICtrlCreateLabel("", $x-3, $y +11, 60, 17, $SS_RIGHT)
		$lblLootBonusElixir1 =GUICtrlCreateLabel("", $x+60, $y +11, 10, 17, $SS_LEFT)
			$txtTip = "The amount of Elixir you gained on the last attack."
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		$picDarkLastAttack = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 65, $y, 16, 16)
		;GUICtrlSetState($picDarkLastAttack, $GUI_HIDE)
		$lblDarkLastAttack = GUICtrlCreateLabel("", $x-3, $y-2, 60, 17, $SS_RIGHT)
		$lblLootBonusDarkElixir =GUICtrlCreateLabel("", $x-3, $y +11, 60, 17, $SS_RIGHT)
		$lblLootBonusDarkElixir1 =GUICtrlCreateLabel("", $x+60, $y +11, 10, 17, $SS_LEFT)
			$txtTip = "The amount of Dark Elixir you gained on the last attack."
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 65, $y, 16, 16)
		$lblTrophyLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you gained or lost on the last attack."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

; total loot earned

	$x += 113
	$y = 150
    $grpTotalLoot = GUICtrlCreateGroup("Total Loot Earned", $x - 20, $y - 20, 108, 133)
		$lblTotalLootTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65, $y, 16, 16)
		$lblGoldTotal = GUICtrlCreateLabel("", $x-3, $y -2, 60, 17, $SS_RIGHT)
		$lblTotalBonusGold =GUICtrlCreateLabel("", $x-3, $y +11, 60, 17, $SS_RIGHT)
		$lblTotalBonusGold1 =GUICtrlCreateLabel("", $x+60, $y +11, 10, 17, $SS_LEFT)
			$txtTip = "The total amount of Gold you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65, $y, 16, 16)
		$lblElixirTotal = GUICtrlCreateLabel("", $x-3, $y - 2, 60, 17, $SS_RIGHT)
		$lblTotalBonusElixir =GUICtrlCreateLabel("", $x-3, $y +11, 60, 17, $SS_RIGHT)
		$lblTotalBonusElixir1 =GUICtrlCreateLabel("", $x+60, $y +11, 10, 17, $SS_LEFT)
			$txtTip = "The total amount of Elixir you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		$picDarkLoot = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 66, $y, 16, 16)
		;GUICtrlSetState($picDarkLoot, $GUI_HIDE)
        $lblDarkTotal = GUICtrlCreateLabel("", $x-3, $y -2, 60, 17, $SS_RIGHT)
		$lblTotalBonusDark =GUICtrlCreateLabel("", $x-3, $y +11, 60, 17, $SS_RIGHT)
		$lblTotalBonusDark1 =GUICtrlCreateLabel("", $x+60, $y +11, 10, 17, $SS_LEFT)
			$txtTip = "The total amount of Dark Elixir you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 65, $y, 16, 16)
		$lblTrophyLoot = GUICtrlCreateLabel("", 258, $y + 2, 55, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you gained or lost while the Bot is running."
			GUICtrlSetTip(-1, $txtTip)
    GUICtrlCreateGroup("", -99, -99, 1, 1)

; net Gain loss plus per hour rate

	$x += 113
	$y = 150

	$grpHourlyStats = GUICtrlCreateGroup("Net Gain / Loss", $x - 20, $y - 20, 108, 133)
	$lblHourlyStatsTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreateIcon ($pIconLib, $eIcnGold, $x + 65, $y, 16, 16)
		$lblGoldGain =  GUICtrlCreateLabel("", $x-3, $y -2, 60, 17, $SS_RIGHT)
		$lblHourlyStatsGold = GUICtrlCreateLabel("", $x-3, $y +11, 60, 17, $SS_RIGHT)
			$txtTip = "Net Gold gain per hour"
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		GUICtrlCreateIcon ($pIconLib, $eIcnElixir, $x + 65, $y, 16, 16)
		$lblElixirGain =  GUICtrlCreateLabel("", $x-3, $y -2, 60, 17, $SS_RIGHT)
		$lblHourlyStatsElixir = GUICtrlCreateLabel("", $x-3, $y +11, 60, 17, $SS_RIGHT)
			$txtTip = "Net Elixir gain per hour"
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		$picHourlyStatsDark = GUICtrlCreateIcon ($pIconLib, $eIcnDark, $x + 65, $y, 16, 16)
		;GUICtrlSetState($picHourlyStatsDark, $GUI_HIDE)
		$lblDarkGain =  GUICtrlCreateLabel("", $x-3, $y -2, 60, 17, $SS_RIGHT)
		$lblHourlyStatsDark = GUICtrlCreateLabel("", $x-3, $y +11, 60, 17, $SS_RIGHT)
			$txtTip = "Net Dark Elixir gain per hour"
			GUICtrlSetTip(-1, $txtTip)
		$y +=30
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x + 65, $y, 16, 16)
		$lblHourlyStatsTrophy = GUICtrlCreateLabel("", $x - 10, $y + 2, 65, 17, $SS_RIGHT)
			$txtTip = "Net Trophy gain per hour"
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

#cs
	$x = 395
	$y = 135
	$btnMoreStats = GUICtrlCreateButton ("More Stats", $x, $y, 60,21)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=25
	$btnExportCSV = GUICtrlCreateButton ("Export CSV", $x, $y, 60,21)
		GUICtrlSetState(-1, $GUI_DISABLE)
#ce

	$x = 30
	$y = 300
	$grpStatsMisc = GUICtrlCreateGroup("Stats: Misc", $x - 20, $y - 20, 450, 80)
		$y -=2
		GUICtrlCreateIcon ($pIconLib, $eIcnTH1, $x - 10, $y + 7, 24, 24)
		GUICtrlCreateIcon ($pIconLib, $eIcnTH10, $x + 16, $y + 7, 24, 24)
        $lblvillagesattacked = GUICtrlCreateLabel("Attacked:", $x + 45, $y + 2, -1, 17)
        $lblresultvillagesattacked = GUICtrlCreateLabel("0", $x + 65, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Villages that were attacked by the Bot."
			GUICtrlSetTip(-1, $txtTip)
		$y += 17
        $lblvillagesskipped = GUICtrlCreateLabel("Skipped:", $x + 45, $y + 2, -1, 17)
        $lblresultvillagesskipped = GUICtrlCreateLabel("0", $x + 65, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Villages that were skipped during search by the Bot."
			GUICtrlSetTip(-1, $txtTip)
		$x = 185
		$y = 300
		GUICtrlCreateIcon ($pIconLib, $eIcnTrophy, $x, $y, 16, 16)
        $lbltrophiesdropped = GUICtrlCreateLabel("Dropped:", $x + 20, $y + 2, -1, 17)
        $lblresulttrophiesdropped = GUICtrlCreateLabel("0", $x + 80, $y + 2, 30, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies dropped by the Bot due to Trophy Settings (on Misc Tab)."
			GUICtrlSetTip(-1, $txtTip)
        $y += 17
        GUICtrlCreateIcon ($pIconLib, $eIcnHourGlass, $x, $y, 16, 16)
        $lblruntime = GUICtrlCreateLabel("Runtime:", $x + 20, $y + 2, -1, 17)
        $lblresultruntime = GUICtrlCreateLabel("00:00:00", $x + 50, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The total Running Time of the Bot."
			GUICtrlSetTip(-1, $txtTip)
		$x = 330
		$y = 300
		GUICtrlCreateIcon ($pIconLib, $eIcnWall, $x - 7, $y + 7, 24, 24)
        $lblwallbygold = GUICtrlCreateLabel("Upg. by Gold:", $x + 20, $y + 2, -1, 17)
		$lblWallgoldmake =  GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Walls upgraded by Gold."
			GUICtrlSetTip(-1, $txtTip)
		$y += 17
		$lblwallbyelixir = GUICtrlCreateLabel("Upg. by Elixir:", $x + 20, $y + 2, -1, 17)
		$lblWallelixirmake =  GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Walls upgraded by Elixir."
			GUICtrlSetTip(-1, $txtTip)
        $lbloutofsync = GUICtrlCreateLabel("Out Of Sync :", $x - 310, $y + 19, 100, 17) ; another stats next post
        $lblresultoutofsync = GUICtrlCreateLabel("0", $x - 285, $y + 19, 60, 17, $SS_RIGHT) ; another stats next post
	    $txtTip = "Restarted after Out of Sync Error:"
			 GUICtrlSetTip(-1, $txtTip)
	  GUICtrlCreateGroup("", -99, -99, 1, 1)
        $x = 30
        $y = 390
        $grpSmartZap = GUICtrlCreateGroup("Stats: Smart Zap", $x - 20, $y - 20, 95, 40)
	    $picSmartZap = GUICtrlCreateIcon ($LibDir & "\CGBBOT.dll", 11, $x + 55, $y, 16, 16)
	    $lblSmartZap = GUICtrlCreateLabel("", $x, $y + 2, 55, 17, $SS_RIGHT)
	    $txtTip = "The amount of Dark Elixir you zapped."
	    GUICtrlSetTip(-1, $txtTip)
	  GUICtrlCreateGroup("", -99, -99, 1, 1)

		$x = 395
        $y = 370
         $btnLoots = GUICtrlCreateButton ("Loots", $x, $y, 60,21)
          GUICtrlSetOnEvent(-1, "btnLoots")
          $y +=25
          $btnLogs = GUICtrlCreateButton ("Logs", $x, $y, 60,21)
        GUICtrlSetOnEvent(-1, "btnLogs")