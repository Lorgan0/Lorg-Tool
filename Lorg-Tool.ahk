; #############################################################
; #  LORG-TOOL v5.0 - INTERFACE REDESSINEE
; #############################################################

#NoEnv
#SingleInstance Force
#MaxHotkeysPerInterval 200
SendMode Event
SetBatchLines, -1
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetWinDelay, 0
SetMouseDelay, 25
SetKeyDelay, 10


; #############################################################
; #  SECTION 1 : CONFIGURATION
; #############################################################

; ---------- Délais FOLLOW ----------
followWindowDelay := 110
followClickDelay  := 35
followF1Delay     := 70
followReturnDelay := 80

; ---------- Délais AUTOJOIN ----------
joinWindowDelay     := 60
joinRightClickDelay := 60
joinF1Delay         := 70
joinLeaderDelay     := 1100
joinActivateDelay   := 40    ; ms : pause après activation d’une fenêtre
joinMoveDelay       := 30    ; ms : pause avant le clic droit
joinLeaderReturnDelay := 100 ; ms : pause après retour au leader
joinWiggle          := 4     ; px : petit décalage avant le clic pour forcer un vrai mouvement de souris dans la fenêtre
joinWiggleDelay     := 15    ; ms : pause entre le décalage et la position exacte
joinOutsideDelay    := 150   ; ms : stabilisation du focus quand on arrive depuis une autre appli (Chrome...)

; ---------- Tolérance de détection de clicktarget (0 = exact, 255 = très permissif) ----------
clickTolerance := 5

; ---------- Délais IMAGE SCAN ----------
imageScanInterval := 300
clickImageScanInterval := 300 ; ms : fréquence de recherche de clicktarget.png
endFightScanInterval := 300   ; ms : fréquence de recherche de fin de combat

; ---------- Délais END FIGHT ----------
endFightDelay := 100
endFightBlockAfterStart := 10000  ; ms : après le début d'un combat (ready.png / join des mules), AUCUN Échap EndFight

; ---------- Attente de ready.png après le clic droit ----------
readyScanInterval := 50    ; vérifie ready.png toutes les 100 ms
readyTimeout      := 100   ; abandonne après 5 s si ready.png n'apparaît pas

; ---------- Délais WHEEL ----------
wheelClickDelay := 25
wheelEndDelay   := 200

; ---------- Délai global de stabilisation ----------
stabilizationDelay := 20

; ---------- Offset du clic sur l'image cible ----------
clickOffsetX := 5
clickOffsetY := 40

; ---------- Fichiers image utilisés ----------
imageFile      := A_ScriptDir "\target_ultra.png"
clickImageFile := A_ScriptDir "\clicktarget_ultra.png"
endFightImage  := A_ScriptDir "\endfight_ultra.png"
readyImage      := A_ScriptDir "\ready.png"

; ---------- PIERRES (double-clic automatique sur pierres.png) ----------
pierresImage        := A_ScriptDir "\pierres.png"
pierresScanInterval := 300    ; ms : fréquence de recherche de pierres.png
pierresTolerance    := 20     ; tolérance de détection (0 = exact, 255 = très permissif)
pierresCooldown     := 1500   ; ms : pause après un double-clic (évite de re-cliquer pendant que le jeu réagit)
pierresHoverDelay   := 40     ; ms : pause entre le déplacement de la souris et le double-clic
pierresOffsetX      := 5      ; px : décalage utilisé si la taille de l'image n'a pas pu être lue
pierresOffsetY      := 5
pierresAfterEscOnly   := true  ; true = Pierres ne s'exécute QU'APRÈS l'Échap de fin de combat (EndFight ON ou x1) ; false = scan continu
pierresAfterEscDelay  := 300   ; ms : pause après l'Échap, le temps que le panneau se ferme
pierresAfterEscTimeout := 3000 ; ms : durée max pendant laquelle on cherche pierres.png après l'Échap
pierresRetryInterval  := 150   ; ms : délai entre deux recherches pendant cette attente
pierresClickIfFound   := false ; false = si pierres.png est détectée, on NE clique PAS ; true = on clique dessus (ancien comportement)
pierresFallbackClick  := true  ; true = si l'image n'est pas détectée après l'Échap, double-clic quand même à la position mémorisée
pierresFallbackAfter  := 1000  ; ms : délai avant ce clic de secours (quand une position est mémorisée)
pierresBlockAfterReady := 10000 ; ms : après le début d'un combat (ready.png ou join des mules), Pierres est bloquée

; ---------- PASSTURN (F1 = passe le tour + switch sur le personnage suivant) ----------
passTurnSwitchDelay := 120   ; ms : pause entre le F1 envoyé au jeu et le switch vers la fenêtre suivante

; ---------- Fenêtre principale ----------
mainWindow := "Malyna-[Era]"

; ---------- DÉLAIS MODIFIABLES DU PLACEMENT UNIQUEMENT (en ms) ----------
; Tu peux modifier ces valeurs sans toucher aux délais des autres fonctions.
; 1000 ms = 1 seconde.
placeNames := ["Malyna"]
placementBeforeClickDelay := 40  ; attente avant le clic de placement
placementClickDelay       := 40  ; pause autour de chaque clic de placement
placementHoverDelay       := 40  ; laisse le jeu enregistrer la case survolée
placementAfterClickDelay  := 10  ; attente après le clic de placement
placementFocusDelay       := 40 ; attente après activation de la fenêtre avant la détection
placementCaptureKey := "F9"  ; touche pour capturer la position de la souris dans l'éditeur
placementTeamColor := "0xFF0000"   ; couleur exacte fournie : RGB(255, 0, 0) / #FF0000
placementColorTolerance := 60       ; tolérance RGB élargie pour mieux accepter les variations de rouge
placementColorBox := 15            ; recherche dans un carré de +/- 15 px autour de la case
placementDetectTimeout := 5000     ; ms : temps max pendant lequel on attend l'apparition des cases rouges
placementDetectInterval := 50      ; ms : délai entre deux recherches de la case rouge
placementCurrent := 0              ; position (1 ou 2) retenue pour le combat en cours
placementLog := A_ScriptDir "\placement.log"   ; journal de diagnostic du placement (vidé à chaque lancement)
joinLog := A_ScriptDir "\join.log"             ; journal de diagnostic du join des mules (vidé à chaque lancement)

; ---------- MONSTRES (détection des Gelées par couleur + clic) ----------
; Les couleurs, la zone et les réglages sont enregistrés dans ScriptPosition.ini ([Monstres])
; via la fenêtre "Monstres...". rgb = -1 : couleur pas encore prélevée.
monsterSlots := [{name: "Bleue", on: true, rgb: -1}, {name: "Rouge", on: true, rgb: -1}, {name: "Verte", on: true, rgb: -1}]
monsterTol       := 30       ; tolérance de couleur par canal RGB (0 = exact, 255 = tout)
monsterMin       := 40       ; nombre minimum de pixels de la couleur pour compter comme une Gelée
monsterBox       := 80       ; px : taille de la zone d'analyse autour d'un pixel trouvé (≈ taille d'une Gelée)
monsterCooldown  := 15000    ; ms : pause après un clic (le temps que le perso marche et que le combat démarre)
monsterFightMax  := 180      ; s : sécurité - reprise de la recherche si la fin de combat n'a pas été vue
monsterAfterFight := 3000    ; ms : pause après la détection de fin de combat
monsterInterval  := 700      ; ms : fréquence de recherche
monsterZoneSet   := false    ; false = zone par défaut (carte sans la barre du bas)
monsterZ         := [0, 0, 0, 0]   ; zone personnalisée, relative à la fenêtre Malyna (x1, y1, x2, y2)

; ---------- REPOSITIONNEMENT (clic droit à une position fixe, après la fin de combat) ----------
repositionAfterDelay := 600    ; ms : pause après l'Échap de fin de combat, avant le clic de repositionnement
repositionWalkDelay  := 4000   ; ms : le module Monstres attend ce délai (le personnage marche) avant de chercher une Gelée

; ---------- Fichier de sauvegarde de position GUI ----------
IniFile := A_ScriptDir "\ScriptPosition.ini"


; #############################################################
; #  SECTION 2 : ETATS (VARIABLES GLOBALES)
; #############################################################

panelClosed      := false
scriptEnabled    := true
imageDetected    := false
imageClicked     := false
endFightEnabled  := false
endFightMode     := 0       ; 0 = OFF, 1 = ON (Echap sur toutes les fenêtres), 2 = x1 (Echap sur Malyna uniquement)
autoJoinFight    := true
targetSearchEnabled := true

; Groupes de verrouillage (évitent que 2 routines tournent en même temps)
groupFollow      := false
groupImage       := false
groupImageStart  := 0
groupEndFight    := false
groupClickImage  := false
joinDone         := {}      ; mules déjà cliquées pendant le join en cours (clé = ID de fenêtre)
joinAttempts     := 0       ; nombre de tentatives de join pour la cible en cours
groupWheel       := false
groupGrouper     := false
groupPierres     := false
pierresEnabled   := false
repositionEnabled := false  ; bouton Repositionnement : clic droit à une position fixe après EndFight
repositionX      := -1      ; position du clic, relative à la fenêtre Malyna (-1 = non définie)
repositionY      := -1
monstersEnabled  := false   ; bouton Monstres : clic automatique sur les Gelées détectées
groupMonster     := false
monsterBlockUntil := 0
monsterInFight   := false
monsterFightStart := 0
monsterSeenFightTick := 0
monsterLastX     := -9999
monsterLastY     := -9999
monsterLastTick  := 0
monsterCaptureMode := ""    ; "", "color", "zone1" ou "zone2" : ce que la touche F7 doit capturer
monsterCaptureSlot := 0
monsterZoneTmpX  := 0
monsterZoneTmpY  := 0
monGuiOpen       := false
passTurnEnabled  := false   ; bouton PassTurn : F1 passe le tour puis switch sur la fenêtre suivante
groupPassTurn    := false
charsOpen        := false   ; fenêtre "Personnages" ouverte ?
charsSnapshot    := ""
pierresLastClick := 0
fightStartTick   := 0       ; dernier moment de début de combat (ready.png ou join des mules) : bloque Pierres et l'Échap EndFight
pierresW         := 0       ; taille de pierres.png (lue au 1er usage)
pierresH         := 0
waitingReady     := false   ; vrai pendant l'attente de ready.png
waitStart        := 0
readySequenceStart := 0
followX          := 0
followY          := 0


; #############################################################
; #  SECTION 3 : INTERFACE (GUI)
; #############################################################

IniRead, GuiX, %IniFile%, GUI, X, 0
IniRead, GuiY, %IniFile%, GUI, Y, 0

; Position du clic de repositionnement (relative à la fenêtre Malyna ; -1 = aucune)
IniRead, repositionX, %IniFile%, Reposition, X, -1
IniRead, repositionY, %IniFile%, Reposition, Y, -1
repositionX := repositionX + 0
repositionY := repositionY + 0

; Tolérance de couleur de la détection de la case rouge (Placement), réglable dans "Placement..."
IniRead, plcTolRaw, %IniFile%, Placement, ColorTol, %placementColorTolerance%
if plcTolRaw is integer
    placementColorTolerance := Min(255, Max(0, plcTolRaw))

; Position mémorisée de pierres.png (relative à la fenêtre Malyna ; -1 = aucune)
IniRead, pierresPosX, %IniFile%, Pierres, X, -1
IniRead, pierresPosY, %IniFile%, Pierres, Y, -1
pierresPosX := pierresPosX + 0
pierresPosY := pierresPosY + 0

; Ordre des personnages choisi dans la fenêtre "Personnages..." (noms séparés par |)
IniRead, charsOrderRaw, %IniFile%, Chars, Order, ERROR
if (charsOrderRaw = "ERROR")
    charsOrderRaw := ""
charsOrder := StrSplit(charsOrderRaw, "|")

; ----- Placement : OFF ou AUTO (la couleur décide entre la position 1 et la position 2) -----
FileDelete, %placementLog%
FileAppend, % "=== Placement log - " A_Now " ===`n", %placementLog%, UTF-8

FileDelete, %joinLog%
FileAppend, % "=== Join log - " A_Now " ===`n", %joinLog%, UTF-8

IniRead, plcEnabledRaw, %IniFile%, Placement, Enabled, 0
placementEnabled := ((plcEnabledRaw + 0) > 0)

; Les positions sont désormais stockées RELATIVEMENT à la fenêtre Malyna-[Era]
; (0 = anciennes valeurs en coordonnées écran, converties automatiquement au 1er usage).
IniRead, plcRelRaw, %IniFile%, Placement, Relative, 0
placeRelative := ((plcRelRaw + 0) > 0)

placeX := []
placeY := []

Loop, 2
{
    plcP := A_Index
    plcPre := (plcP = 1) ? "" : "P" plcP   ; placement 1 : clés X1.. / placement 2 : clés P2X1..

    placeX[plcP] := []
    placeY[plcP] := []

    Loop % placeNames.Length()
    {
        IniRead, plcX, %IniFile%, Placement, %plcPre%X%A_Index%, 0
        IniRead, plcY, %IniFile%, Placement, %plcPre%Y%A_Index%, 0
        placeX[plcP].Push(plcX)
        placeY[plcP].Push(plcY)
    }
}

; ----- Fenêtre principale : une seule image dessinée par le script (GDI+) -----
; Tout est dessiné dans UiRefresh() ; un clic est traduit en action par UiMainClick.
uiW := 300
uiH := 526
uiHit := []
uiHover := 0
uiGdipToken := 0
MonstersLoad()
UiGdipStart()

Gui, +AlwaysOnTop +Caption +ToolWindow -DPIScale +HwndMainGuiHwnd
Gui, Color, 1E2024
Gui, Margin, 0, 0
Gui, Add, Picture, x0 y0 w%uiW% h%uiH% +0xE hwndUiPic gUiMainClick

RefreshGui()

Gui, Show, x%GuiX% y%GuiY% AutoSize, Lorg-Tool v5.0

; Survol : la zone sous la souris s'éclaircit / s'assombrit et le curseur devient une main
OnMessage(0x20, "UiSetCursor")
SetTimer, UiHoverTick, 40

; Barre de titre sombre (Windows 10 1903+ / 11 ; sans effet sur les versions plus anciennes)
DllCall("dwmapi\DwmSetWindowAttribute", "Ptr", MainGuiHwnd, "Int", 20, "Int*", 1, "Int", 4)


; #############################################################
; #  SECTION 4 : TIMERS (LANCEMENT DES BOUCLES DE FOND)
; #############################################################

SetTimer, CheckImage, %imageScanInterval%
SetTimer, CheckEndFight, %endFightScanInterval%
SetTimer, CheckClickImage, %clickImageScanInterval%

return


; #############################################################
; #  SECTION 5 : FONCTIONS UTILITAIRES
; #############################################################

; ---------------------------------------------------------------
; Active une fenêtre seulement si elle n'est pas déjà au premier plan
; ---------------------------------------------------------------
ActivateIfNeeded(id)
{
    Loop, 3
    {
        WinGet, active_id, ID, A

        if (active_id = id)
            return true

        WinActivate, ahk_id %id%
        WinWaitActive, ahk_id %id%,, 0.5
    }

    WinGet, active_id, ID, A
    return (active_id = id)
}

; ---------------------------------------------------------------
; Vérifie si l'image "target.png" est visible sur la fenêtre principale
; ---------------------------------------------------------------
IsTargetVisible()
{
    global imageFile, mainWindow

    WinGet, mainID, ID, %mainWindow%

    if (!mainID)
        return false

    WinGetPos, winX, winY, winW, winH, ahk_id %mainID%

    x2 := winX + winW
    y2 := winY + winH

    ImageSearch, fx, fy, %winX%, %winY%, %x2%, %y2%, *20 %imageFile%

    return (ErrorLevel = 0)
}


; ---------------------------------------------------------------
; Vérifie si l'image "ready.png" est visible sur la fenêtre principale
; ---------------------------------------------------------------
IsReadyVisible()
{
    global readyImage, mainWindow

    WinGet, mainID, ID, %mainWindow%

    if (!mainID)
        return false

    WinGetPos, winX, winY, winW, winH, ahk_id %mainID%

    x2 := winX + winW
    y2 := winY + winH

    ImageSearch, fx, fy, %winX%, %winY%, %x2%, %y2%, *20 %readyImage%

    return (ErrorLevel = 0)
}


; ---------------------------------------------------------------
; Journal de diagnostic du placement (fichier placement.log)
; ---------------------------------------------------------------
PlcLog(msg)
{
    global placementLog

    FileAppend, % A_Hour ":" A_Min ":" A_Sec "." A_MSec "  " msg "`n", %placementLog%, UTF-8
}


; ---------------------------------------------------------------
; Journal de diagnostic du join des mules (fichier join.log)
; ---------------------------------------------------------------
JoinLog(msg)
{
    global joinLog

    FileAppend, % A_Hour ":" A_Min ":" A_Sec "." A_MSec "  " msg "`n", %joinLog%, UTF-8
}


; ---------------------------------------------------------------
; Position et taille de la fenêtre Malyna-[Era].
; Renvoie son ID, ou 0 si elle est introuvable ou réduite.
; ---------------------------------------------------------------
PlcWindowRect(ByRef wx, ByRef wy, ByRef ww, ByRef wh)
{
    global mainWindow

    WinGet, wid, ID, %mainWindow%

    if (!wid)
        return 0

    WinGet, mm, MinMax, ahk_id %wid%

    if (mm = -1)
        return 0

    WinGetPos, wx, wy, ww, wh, ahk_id %wid%

    return wid
}


; ---------------------------------------------------------------
; Migration unique : convertit les anciennes positions (coordonnées écran)
; en positions relatives à la fenêtre Malyna, d'après sa place actuelle.
; Renvoie false si Malyna est introuvable (rien n'est modifié).
; ---------------------------------------------------------------
PlcEnsureRelative()
{
    global placeRelative, placeX, placeY, placeNames, IniFile

    if (placeRelative)
        return true

    if (!PlcWindowRect(ox, oy, ow, oh))
        return false

    Loop, 2
    {
        mp := A_Index
        mpre := (mp = 1) ? "" : "P" mp

        Loop % placeNames.Length()
        {
            mi := A_Index
            mx := placeX[mp][mi]
            my := placeY[mp][mi]

            if (mx = "" || my = "" || (mx = 0 && my = 0))
                continue

            mx := mx - ox
            my := my - oy

            placeX[mp][mi] := mx
            placeY[mp][mi] := my

            IniWrite, %mx%, %IniFile%, Placement, %mpre%X%mi%
            IniWrite, %my%, %IniFile%, Placement, %mpre%Y%mi%
        }
    }

    IniWrite, 1, %IniFile%, Placement, Relative
    placeRelative := true
    PlcLog("positions converties en relatif a la fenetre Malyna (origine " ox "/" oy ")")

    return true
}


; ---------------------------------------------------------------
; Texte du bouton Placement (OFF / AUTO)
; ---------------------------------------------------------------
PlacementButtonText()
{
    global placementEnabled

    return placementEnabled ? "Placement AUTO" : "Placement OFF"
}


; ---------------------------------------------------------------
; Regarde si la case "pos 1" de Malyna (puis la "pos 2") est de la
; couleur de l'équipe (rouge). Renvoie 1, 2, ou 0 si aucune.
; Les cases rouges et bleues peuvent s'inverser d'un combat à l'autre :
; c'est la case qui est rouge qui indique où cliquer.
; Au lancement du combat, les cases mettent parfois un instant à
; s'afficher : on réessaie pendant placementDetectTimeout ms.
; ---------------------------------------------------------------
DetectPlacement(mainID)
{
    global placeX, placeY, placementTeamColor, placementColorTolerance, placementColorBox
    global placementDetectTimeout, placementDetectInterval, placementFocusDelay
	

    ; Le PixelSearch lit l'écran.
    ; On force Malyna au premier plan avant CHAQUE série de détection.
    if (mainID)
    {
        if (!ActivateIfNeeded(mainID))
        {
            PlcLog("detection : impossible de mettre Malyna au premier plan")
            ToolTip, Placement : Malyna n'a pas le focus
            SetTimer, RemoveToolTip, -1500
            return 0
        }

        Sleep, %placementFocusDelay%
    }

    if (!PlcEnsureRelative())
    {
        PlcLog("detection : fenetre Malyna introuvable (conversion des positions impossible)")
        return 0
    }

    detStart := A_TickCount
    tries := 0

    Loop
    {
        tries++

        ; Position et taille ACTUELLES de la fenêtre Malyna (elle peut avoir bougé).
        if (!PlcWindowRect(wx, wy, ww, wh))
        {
            PlcLog("detection : fenetre Malyna introuvable ou reduite")
            ToolTip, Placement : fenêtre Malyna introuvable
            SetTimer, RemoveToolTip, -1500
            return 0
        }

        ; Vérifie d'abord la position 1, puis la position 2.
        Loop, 2
        {
            p := A_Index
            rx := placeX[p][1]
            ry := placeY[p][1]

            if (rx = "" || ry = "" || (rx = 0 && ry = 0))
            {
                if (tries = 1)
                    PlcLog("pos " p " : non enregistree, ignoree")
                continue
            }

            ; Coordonnées écran = origine de la fenêtre Malyna + position relative.
            cx := wx + rx
            cy := wy + ry

            ; On ne cherche QUE dans la fenêtre Malyna.
            if (cx < wx || cy < wy || cx >= wx + ww || cy >= wy + wh)
            {
                if (tries = 1)
                    PlcLog("pos " p " : hors de la fenetre Malyna (" rx "/" ry "), ignoree")
                continue
            }

            ; Recherche dans toute la zone autour du point mémorisé.
            ; La zone est limitée aux bords de la fenêtre Malyna.
            x1 := Max(wx, cx - placementColorBox)
            y1 := Max(wy, cy - placementColorBox)
            x2 := Min(wx + ww - 1, cx + placementColorBox)
            y2 := Min(wy + wh - 1, cy + placementColorBox)

            PixelSearch, foundPX, foundPY, %x1%, %y1%, %x2%, %y2%, %placementTeamColor%, %placementColorTolerance%, Fast RGB

            if (ErrorLevel = 0)
            {
                elapsed := A_TickCount - detStart
                ; Lit et journalise le code RGB exact du pixel qui a correspondu.
                PixelGetColor, foundColor, %foundPX%, %foundPY%, RGB

                PlcLog("pos " p " (" cx "/" cy ") : ROUGE TROUVE en " foundPX "/" foundPY ", couleur RGB=" foundColor ", cible=" placementTeamColor ", tolerance=" placementColorTolerance ", essai " tries ", " elapsed " ms")

                ToolTip, Placement : ROUGE détecté sur POS %p%`nCoordonnées : %cx% / %cy%
                SetTimer, RemoveToolTip, -1000

                return p
            }
        }

        ; Respecte le délai maximal défini dans la configuration.
        if (A_TickCount - detStart >= placementDetectTimeout)
            break

        Sleep, %placementDetectInterval%
    }

    elapsed := A_TickCount - detStart
    PlcLog("aucune case rouge apres " tries " essais, " elapsed " ms")

    ToolTip, Placement : aucune case rouge détectée
    SetTimer, RemoveToolTip, -1500

    return 0
}


; ---------------------------------------------------------------
; Choisit la position (1 ou 2) selon la couleur. Renvoie true si une
; case rouge a été trouvée. "force" = true pour tester même en OFF.
; ---------------------------------------------------------------
PlacementChoose(force := false)
{
    global placementEnabled, placementCurrent, mainWindow

    placementCurrent := 0

    if (!placementEnabled && !force)
    {
        PlcLog("placement OFF : rien a faire")
        return false
    }

    WinGet, mainID, ID, %mainWindow%

    p := DetectPlacement(mainID)

    if (!p)
    {
        PlcLog("case rouge NON detectee")
        ToolTip, Placement : case rouge non détectée
        SetTimer, RemoveToolTip, -1500
        return false
    }

    placementCurrent := p
    return true
}


; ---------------------------------------------------------------
; Malyna clique sur la position retenue.
; Vrai déplacement de la souris + vrai clic à la position ÉCRAN capturée
; (même repère que la capture), puis la souris revient où elle était.
; Une infobulle indique ce qui s'est passé (ou pourquoi rien ne s'est passé).
; ---------------------------------------------------------------
PlacementClickLeader()
{
    global placementCurrent, placeX, placeY, placementClickDelay, mainWindow

    if (!placementCurrent)
    {
        PlcLog("clic annule : aucune position retenue")
        return
    }

    if (!PlcEnsureRelative())
    {
        PlcLog("clic annule : fenetre Malyna introuvable (conversion des positions impossible)")
        return
    }

    px := placeX[placementCurrent][1]
    py := placeY[placementCurrent][1]

    if (px = "" || py = "" || (px = 0 && py = 0))
    {
        PlcLog("clic annule : pos " placementCurrent " non enregistree")
        ToolTip, Placement : pos %placementCurrent% non enregistrée
        SetTimer, RemoveToolTip, -2000
        return
    }

    WinGet, wid, ID, %mainWindow%

    if (!wid)
    {
        PlcLog("clic annule : fenetre Malyna introuvable")
        return
    }

    if (!ActivateIfNeeded(wid))
    {
        PlcLog("clic annule : Malyna n'a pas pris le focus")
        ToolTip, Placement : Malyna n'a pas pu prendre le focus
        SetTimer, RemoveToolTip, -2000
        return
    }

    ; Position relative -> position écran, d'après la fenêtre Malyna ACTUELLE.
    if (!PlcWindowRect(wx, wy, ww, wh) || px < 0 || py < 0 || px >= ww || py >= wh)
    {
        PlcLog("clic annule : position hors de la fenetre Malyna (" px "/" py ")")
        ToolTip, Placement : position hors de la fenêtre Malyna
        SetTimer, RemoveToolTip, -2000
        return
    }

    px := wx + px
    py := wy + py

    MouseGetPos, oldX, oldY

    Sleep, placementClickDelay
    MouseMove, %px%, %py%, 0
    Sleep, placementHoverDelay      ; laisse le jeu enregistrer la case survolée
    Click
    Sleep, placementClickDelay

    MouseMove, 2400, 700, 0  ; position fixe apres le clic sur la case rouge

    PlcLog("clic effectue en " px "/" py " (pos " placementCurrent ")")
    ToolTip, Placement : clic sur la pos %placementCurrent% (%px% / %py%)
    SetTimer, RemoveToolTip, -1500
}


; ---------------------------------------------------------------
; Clic dans la fenêtre principale : on retrouve la zone touchée et on lance
; le label correspondant (les mêmes qu'avant : ToggleScript, ToggleEndFight...).
; ---------------------------------------------------------------
UiHoverTick:
    VarSetCapacity(htPt, 8, 0)
    DllCall("GetCursorPos", "Ptr", &htPt)
    htIdx := 0
    ; la fenêtre sous la souris est bien notre image (pas une autre fenêtre par-dessus)
    if (DllCall("WindowFromPoint", "Int64", NumGet(htPt, 0, "Int64"), "Ptr") = uiPic)
    {
        DllCall("ScreenToClient", "Ptr", MainGuiHwnd, "Ptr", &htPt)
        htX := NumGet(htPt, 0, "Int")
        htY := NumGet(htPt, 4, "Int")
        for htI, htR in uiHit
        {
            if (htX >= htR.x && htX < htR.x + htR.w && htY >= htR.y && htY < htR.y + htR.h)
            {
                htIdx := htI
                break
            }
        }
    }
    if (htIdx != uiHover)
    {
        uiHover := htIdx
        RefreshGui()
    }
return

UiMainClick:
    VarSetCapacity(mcPt, 8, 0)
    DllCall("GetCursorPos", "Ptr", &mcPt)
    DllCall("ScreenToClient", "Ptr", MainGuiHwnd, "Ptr", &mcPt)
    mcX := NumGet(mcPt, 0, "Int")
    mcY := NumGet(mcPt, 4, "Int")

    mcLabel := ""
    for mcI, mcR in uiHit
    {
        if (mcX >= mcR.x && mcX < mcR.x + mcR.w && mcY >= mcR.y && mcY < mcR.y + mcR.h)
        {
            mcLabel := mcR.label
            break
        }
    }

    if (mcLabel != "")
        Gosub, %mcLabel%
return


; ---------------------------------------------------------------
; Outils de dessin GDI+ (Ui...) : fonctions courtes, variables locales.
; ---------------------------------------------------------------
UiSetCursor(wParam, lParam, msg, hwnd)
{
    global uiPic, uiHover
    if (wParam = uiPic && uiHover > 0)
    {
        DllCall("SetCursor", "Ptr", DllCall("LoadCursor", "Ptr", 0, "Ptr", 32649, "Ptr"))   ; IDC_HAND
        return true
    }
}

UiGdipStart()
{
    global uiGdipToken
    DllCall("LoadLibrary", "Str", "gdiplus")
    VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0)
    NumPut(1, si, 0, "UInt")
    DllCall("gdiplus\GdiplusStartup", "Ptr*", tok, "Ptr", &si, "Ptr", 0)
    uiGdipToken := tok
}

UiBrush(rgb, a := 255)
{
    DllCall("gdiplus\GdipCreateSolidFill", "UInt", (a << 24) | rgb, "Ptr*", b)
    return b
}

UiPen(rgb, w := 1.5)
{
    DllCall("gdiplus\GdipCreatePen1", "UInt", (255 << 24) | rgb, "Float", w, "Int", 2, "Ptr*", p)
    DllCall("gdiplus\GdipSetPenLineCap197819", "Ptr", p, "Int", 2, "Int", 2, "Int", 0)
    DllCall("gdiplus\GdipSetPenLineJoin", "Ptr", p, "Int", 1)
    return p
}

UiRoundPath(x, y, w, h, r)
{
    DllCall("gdiplus\GdipCreatePath", "Int", 0, "Ptr*", p)
    d := r * 2
    DllCall("gdiplus\GdipAddPathArc", "Ptr", p, "Float", x,         "Float", y,         "Float", d, "Float", d, "Float", 180, "Float", 90)
    DllCall("gdiplus\GdipAddPathArc", "Ptr", p, "Float", x + w - d, "Float", y,         "Float", d, "Float", d, "Float", 270, "Float", 90)
    DllCall("gdiplus\GdipAddPathArc", "Ptr", p, "Float", x + w - d, "Float", y + h - d, "Float", d, "Float", d, "Float", 0,   "Float", 90)
    DllCall("gdiplus\GdipAddPathArc", "Ptr", p, "Float", x,         "Float", y + h - d, "Float", d, "Float", d, "Float", 90,  "Float", 90)
    DllCall("gdiplus\GdipClosePathFigure", "Ptr", p)
    return p
}

UiFillRound(G, rgb, x, y, w, h, r)
{
    p := UiRoundPath(x, y, w, h, r)
    b := UiBrush(rgb)
    DllCall("gdiplus\GdipFillPath", "Ptr", G, "Ptr", b, "Ptr", p)
    DllCall("gdiplus\GdipDeleteBrush", "Ptr", b)
    DllCall("gdiplus\GdipDeletePath", "Ptr", p)
}

UiStrokeRound(G, rgb, x, y, w, h, r)
{
    p := UiRoundPath(x + 0.5, y + 0.5, w - 1, h - 1, r)
    pen := UiPen(rgb, 1)
    DllCall("gdiplus\GdipDrawPath", "Ptr", G, "Ptr", pen, "Ptr", p)
    DllCall("gdiplus\GdipDeletePen", "Ptr", pen)
    DllCall("gdiplus\GdipDeletePath", "Ptr", p)
}

UiFillRect(G, rgb, x, y, w, h)
{
    b := UiBrush(rgb)
    DllCall("gdiplus\GdipFillRectangle", "Ptr", G, "Ptr", b, "Float", x, "Float", y, "Float", w, "Float", h)
    DllCall("gdiplus\GdipDeleteBrush", "Ptr", b)
}

UiFillEllipse(G, rgb, x, y, w, h)
{
    b := UiBrush(rgb)
    DllCall("gdiplus\GdipFillEllipse", "Ptr", G, "Ptr", b, "Float", x, "Float", y, "Float", w, "Float", h)
    DllCall("gdiplus\GdipDeleteBrush", "Ptr", b)
}

; Polyligne ou polygone : pts = "x1,y1,x2,y2,..." décalés de (ox, oy)
UiPoly(G, pen, pts, ox, oy, closed := false)
{
    arr := StrSplit(pts, ",")
    n := arr.Length() // 2
    VarSetCapacity(buf, n * 8, 0)
    Loop % n
    {
        NumPut(ox + arr[2 * A_Index - 1], buf, (A_Index - 1) * 8, "Float")
        NumPut(oy + arr[2 * A_Index], buf, (A_Index - 1) * 8 + 4, "Float")
    }
    if (closed)
        DllCall("gdiplus\GdipDrawPolygon", "Ptr", G, "Ptr", pen, "Ptr", &buf, "Int", n)
    else
        DllCall("gdiplus\GdipDrawLines", "Ptr", G, "Ptr", pen, "Ptr", &buf, "Int", n)
}

; Texte : align 0 = gauche, 1 = centré, 2 = droite ; valign 0 = haut, 1 = milieu
UiText(G, txt, x, y, w, h, rgb, size, bold := false, align := 0, valign := 1)
{
    generic := false
    if (DllCall("gdiplus\GdipCreateFontFamilyFromName", "WStr", "Segoe UI", "Ptr", 0, "Ptr*", fam) != 0)
    {
        if (DllCall("gdiplus\GdipCreateFontFamilyFromName", "WStr", "Arial", "Ptr", 0, "Ptr*", fam) != 0)
        {
            DllCall("gdiplus\GdipGetGenericFontFamilySansSerif", "Ptr*", fam)
            generic := true
        }
    }

    DllCall("gdiplus\GdipCreateFont", "Ptr", fam, "Float", size, "Int", bold ? 1 : 0, "Int", 2, "Ptr*", font)
    DllCall("gdiplus\GdipCreateStringFormat", "Int", 0, "Int", 0, "Ptr*", fmt)
    DllCall("gdiplus\GdipSetStringFormatAlign", "Ptr", fmt, "Int", align)
    DllCall("gdiplus\GdipSetStringFormatLineAlign", "Ptr", fmt, "Int", valign)
    DllCall("gdiplus\GdipSetStringFormatFlags", "Ptr", fmt, "Int", 0x1000)

    VarSetCapacity(rc, 16, 0)
    NumPut(x, rc, 0, "Float")
    NumPut(y, rc, 4, "Float")
    NumPut(w, rc, 8, "Float")
    NumPut(h, rc, 12, "Float")

    b := UiBrush(rgb)
    DllCall("gdiplus\GdipDrawString", "Ptr", G, "WStr", txt, "Int", -1, "Ptr", font, "Ptr", &rc, "Ptr", fmt, "Ptr", b)

    DllCall("gdiplus\GdipDeleteBrush", "Ptr", b)
    DllCall("gdiplus\GdipDeleteStringFormat", "Ptr", fmt)
    DllCall("gdiplus\GdipDeleteFont", "Ptr", font)
    if (!generic)
        DllCall("gdiplus\GdipDeleteFontFamily", "Ptr", fam)
}

; Icônes simples (boîte de 16 x 16, sauf play/pause : 20 x 20)
UiIcon(G, name, x, y, rgb)
{
    pen := UiPen(rgb, 1.5)

    if (name = "exit")
    {
        UiPoly(G, pen, "9,2,3,2,3,14,9,14", x, y)
        UiPoly(G, pen, "7,8,14,8", x, y)
        UiPoly(G, pen, "11.5,5.5,14,8,11.5,10.5", x, y)
    }
    else if (name = "usersplus")
    {
        DllCall("gdiplus\GdipDrawEllipse", "Ptr", G, "Ptr", pen, "Float", x + 2.5, "Float", y + 2, "Float", 6, "Float", 6)
        DllCall("gdiplus\GdipDrawArc", "Ptr", G, "Ptr", pen, "Float", x + 0.75, "Float", y + 10, "Float", 9.5, "Float", 9, "Float", 180, "Float", 180)
        UiPoly(G, pen, "10.5,5,15.5,5", x, y)
        UiPoly(G, pen, "13,2.5,13,7.5", x, y)
    }
    else if (name = "switch")
    {
        UiPoly(G, pen, "2,5,13,5", x, y)
        UiPoly(G, pen, "10.5,2.5,13,5,10.5,7.5", x, y)
        UiPoly(G, pen, "14,11,3,11", x, y)
        UiPoly(G, pen, "5.5,8.5,3,11,5.5,13.5", x, y)
    }
    else if (name = "skip")
    {
        UiPoly(G, pen, "3,3,11,8,3,13", x, y, true)
        UiPoly(G, pen, "13.5,3,13.5,13", x, y)
    }
    else if (name = "diamond")
    {
        UiPoly(G, pen, "8,1.5,14.5,8,8,14.5,1.5,8", x, y, true)
    }
    else if (name = "target")
    {
        DllCall("gdiplus\GdipDrawEllipse", "Ptr", G, "Ptr", pen, "Float", x + 1.5, "Float", y + 1.5, "Float", 13, "Float", 13)
        DllCall("gdiplus\GdipDrawEllipse", "Ptr", G, "Ptr", pen, "Float", x + 4.5, "Float", y + 4.5, "Float", 7, "Float", 7)
        UiFillEllipse(G, rgb, x + 7, y + 7, 2, 2)
    }
    else if (name = "group")
    {
        DllCall("gdiplus\GdipDrawEllipse", "Ptr", G, "Ptr", pen, "Float", x + 2, "Float", y + 1.5, "Float", 5, "Float", 5)
        DllCall("gdiplus\GdipDrawArc", "Ptr", G, "Ptr", pen, "Float", x + 0.5, "Float", y + 9.5, "Float", 8.5, "Float", 8, "Float", 180, "Float", 180)
        DllCall("gdiplus\GdipDrawEllipse", "Ptr", G, "Ptr", pen, "Float", x + 9.5, "Float", y + 1.5, "Float", 5, "Float", 5)
        DllCall("gdiplus\GdipDrawArc", "Ptr", G, "Ptr", pen, "Float", x + 8.5, "Float", y + 9.5, "Float", 7.5, "Float", 8, "Float", 180, "Float", 180)
    }
    else if (name = "cursor")
    {
        UiPoly(G, pen, "3.5,2.5,3.5,13.5,6.5,10.5,8.5,14.5,10.5,13.5,8.5,9.5,12.5,9.5", x, y, true)
    }
    else if (name = "blob")
    {
        DllCall("gdiplus\GdipDrawArc", "Ptr", G, "Ptr", pen, "Float", x + 2, "Float", y + 2.5, "Float", 12, "Float", 12, "Float", 180, "Float", 180)
        UiPoly(G, pen, "2,8.5,2,13,14,13,14,8.5", x, y)
        UiFillEllipse(G, rgb, x + 4.5, y + 8, 2, 2)
        UiFillEllipse(G, rgb, x + 9.5, y + 8, 2, 2)
    }
    else if (name = "play")
    {
        DllCall("gdiplus\GdipDeletePen", "Ptr", pen)
        pen := UiPen(rgb, 2)
        UiPoly(G, pen, "5.5,3.5,16,10,5.5,16.5", x, y, true)
    }
    else if (name = "pause")
    {
        DllCall("gdiplus\GdipDeletePen", "Ptr", pen)
        pen := UiPen(rgb, 2.5)
        UiPoly(G, pen, "6.5,4,6.5,16", x, y)
        UiPoly(G, pen, "13.5,4,13.5,16", x, y)
    }

    DllCall("gdiplus\GdipDeletePen", "Ptr", pen)
}

; Pastille d'état : state = "on" (vert), "mid" (orange), "off" (gris)
UiPill(G, txt, state, rightX, cy)
{
    if (state = "on")
    {
        bg := 0x1F3A28
        fg := 0x5FD47A
    }
    else if (state = "mid")
    {
        bg := 0x4A3A14
        fg := 0xF0C05A
    }
    else
    {
        bg := 0x33363D
        fg := 0x9AA0A8
    }

    w := (StrLen(txt) >= 4) ? 50 : 40
    x := rightX - w
    y := cy - 10

    UiFillRound(G, bg, x, y, w, 20, 10)
    UiText(G, txt, x, y, w, 20, fg, 11, true, 1, 1)
}

; ---------------------------------------------------------------
; Dessine toute la fenêtre d'après les variables d'état, puis l'affiche.
; (c'est la fonction appelée par tous les boutons quand un état change)
; ---------------------------------------------------------------
RefreshGui()
{
    global scriptEnabled, endFightMode, autoJoinFight, targetSearchEnabled
    global passTurnEnabled, pierresEnabled, placementEnabled, monstersEnabled, repositionEnabled
    global uiHit, uiPic, uiW, uiH, uiHover

    ; ----- Image de travail (DIB 32 bits) + contexte GDI+ -----
    hdc := DllCall("CreateCompatibleDC", "Ptr", 0, "Ptr")
    VarSetCapacity(bi, 40, 0)
    NumPut(40, bi, 0, "UInt")
    NumPut(uiW, bi, 4, "Int")
    NumPut(-uiH, bi, 8, "Int")
    NumPut(1, bi, 12, "UShort")
    NumPut(32, bi, 14, "UShort")
    hbm := DllCall("CreateDIBSection", "Ptr", hdc, "Ptr", &bi, "UInt", 0, "Ptr*", 0, "Ptr", 0, "UInt", 0, "Ptr")
    obm := DllCall("SelectObject", "Ptr", hdc, "Ptr", hbm, "Ptr")
    DllCall("gdiplus\GdipCreateFromHDC", "Ptr", hdc, "Ptr*", G)
    DllCall("gdiplus\GdipSetSmoothingMode", "Ptr", G, "Int", 4)
    DllCall("gdiplus\GdipSetTextRenderingHint", "Ptr", G, "Int", 4)
    DllCall("gdiplus\GdipGraphicsClear", "Ptr", G, "UInt", 0xFF1E2024)

    uiHit := []

    ; ----- Bandeau : script actif / coupé -----
    if (scriptEnabled)
    {
        UiFillRound(G, (uiHover = 1) ? 0x25472F : 0x1F3A28, 10, 10, 280, 58, 6)
        UiStrokeRound(G, 0x2F6B44, 10, 10, 280, 58, 6)
        UiIcon(G, "play", 24, 29, 0x3FB950)
        UiText(G, "Script actif", 54, 17, 180, 22, 0xE6F4EA, 15, true)
        UiText(G, "F11 pour couper", 54, 39, 180, 16, 0x8FC9A1, 11)
        UiFillRound(G, 0x3FB950, 240, 29, 38, 20, 10)
        UiFillEllipse(G, 0xFFFFFF, 240 + 38 - 18, 31, 16, 16)
    }
    else
    {
        UiFillRound(G, (uiHover = 1) ? 0x482626 : 0x3A1F1F, 10, 10, 280, 58, 6)
        UiStrokeRound(G, 0x6B2F2F, 10, 10, 280, 58, 6)
        UiIcon(G, "pause", 24, 29, 0xF85149)
        UiText(G, "Script coupé", 54, 17, 180, 22, 0xF8E6E6, 15, true)
        UiText(G, "F11 pour relancer", 54, 39, 180, 16, 0xD99A9A, 11)
        UiFillRound(G, 0x5A5F68, 240, 29, 38, 20, 10)
        UiFillEllipse(G, 0xFFFFFF, 242, 31, 16, 16)
    }
    uiHit.Push({x: 10, y: 10, w: 280, h: 58, label: "ToggleScript"})

    ; ----- Libellés d'état -----
    if (endFightMode = 0)
    {
        efTxt := "OFF"
        efSt := "off"
    }
    else if (endFightMode = 1)
    {
        efTxt := "ON"
        efSt := "on"
    }
    else
    {
        efTxt := "x1"
        efSt := "mid"
    }

    ; ----- Section Combat -----
    UiText(G, "Combat", 12, 80, 200, 16, 0x9AA0A8, 11)
    UiFillRound(G, 0x25282D, 10, 98, 280, 128, 6)

    rowDefs := []
    rowDefs.Push(["exit",      "EndFight",      efTxt,                                 efSt,                                  "ToggleEndFight"])
    rowDefs.Push(["usersplus", "AutoJoinFight", autoJoinFight ? "ON" : "OFF",          autoJoinFight ? "on" : "off",          "ToggleAutoJoin"])
    rowDefs.Push(["switch",    "Switch",        targetSearchEnabled ? "ON" : "OFF",    targetSearchEnabled ? "on" : "off",    "ToggleTargetSearch"])
    rowDefs.Push(["skip",      "PassTurn",      passTurnEnabled ? "ON" : "OFF",        passTurnEnabled ? "on" : "off",        "TogglePassTurn"])

    for ri, rd in rowDefs
    {
        ry := 98 + (ri - 1) * 32
        if (ri > 1)
            UiFillRect(G, 0x33363D, 11, ry, 278, 1)
        hv := (uiHover = uiHit.Length() + 1)
        UiIcon(G, rd[1], 24, ry + 8, hv ? 0xFFFFFF : 0x9AA0A8)
        UiText(G, rd[2], 48, ry, 150, 32, hv ? 0xFFFFFF : 0xE6E8EB, 13)
        UiPill(G, rd[3], rd[4], 278, ry + 16)
        uiHit.Push({x: 10, y: ry, w: 280, h: 32, label: rd[5]})
    }
    UiStrokeRound(G, 0x3A3E46, 10, 98, 280, 128, 6)

    ; ----- Section Automatisations -----
    UiText(G, "Automatisations", 12, 238, 200, 16, 0x9AA0A8, 11)
    UiFillRound(G, 0x25282D, 10, 256, 280, 128, 6)

    rowDefs := []
    rowDefs.Push(["diamond", "Pierres",   pierresEnabled ? "ON" : "OFF",   pierresEnabled ? "on" : "off",   "TogglePierres"])
    rowDefs.Push(["target",  "Placement", placementEnabled ? "AUTO" : "OFF", placementEnabled ? "mid" : "off", "TogglePlacement"])
    rowDefs.Push(["blob",    "Monstres",  monstersEnabled ? "ON" : "OFF",  monstersEnabled ? "on" : "off",  "ToggleMonsters"])
    rowDefs.Push(["cursor",  "Repositionnement", repositionEnabled ? "ON" : "OFF", repositionEnabled ? "on" : "off", "ToggleReposition"])

    for ri, rd in rowDefs
    {
        ry := 256 + (ri - 1) * 32
        if (ri > 1)
            UiFillRect(G, 0x33363D, 11, ry, 278, 1)
        hv := (uiHover = uiHit.Length() + 1)
        UiIcon(G, rd[1], 24, ry + 8, hv ? 0xFFFFFF : 0x9AA0A8)
        UiText(G, rd[2], 48, ry, 150, 32, hv ? 0xFFFFFF : 0xE6E8EB, 13)
        UiPill(G, rd[3], rd[4], 278, ry + 16)
        uiHit.Push({x: 10, y: ry, w: 280, h: 32, label: rd[5]})
    }
    UiStrokeRound(G, 0x3A3E46, 10, 256, 280, 128, 6)

    ; ----- Section Outils -----
    UiText(G, "Outils", 12, 396, 200, 16, 0x9AA0A8, 11)

    hv := (uiHover = uiHit.Length() + 1)
    UiFillRound(G, hv ? 0x234A8C : 0x2F5FB3, 10, 414, 280, 34, 6)
    UiIcon(G, "group", 104, 423, 0xFFFFFF)
    UiText(G, "Grouper", 128, 414, 120, 34, 0xFFFFFF, 13, true)
    uiHit.Push({x: 10, y: 414, w: 280, h: 34, label: "RunGrouper"})

    btnDefs := [["Placement…", "OpenPlacementEditor"], ["Personnages…", "OpenChars"], ["Monstres…", "OpenMonsters"]]
    for bi, bd in btnDefs
    {
        bx := 10 + (bi - 1) * 96
        hv := (uiHover = uiHit.Length() + 1)
        UiFillRound(G, hv ? 0x30343B : 0x25282D, bx, 456, 88, 30, 6)
        UiStrokeRound(G, hv ? 0x5A606B : 0x3A3E46, bx, 456, 88, 30, 6)
        UiText(G, bd[1], bx, 456, 88, 30, 0xE6E8EB, 11, false, 1, 1)
        uiHit.Push({x: bx, y: 456, w: 88, h: 30, label: bd[2]})
    }

    ; ----- Pied de page : raccourcis -----
    UiFillRect(G, 0x15171A, 0, 500, 300, 26)
    UiText(G, "F8 pos. pierres", 10, 500, 120, 26, 0x9AA0A8, 11, false, 0, 1)
    UiText(G, "F10 test", 0, 500, 300, 26, 0x9AA0A8, 11, false, 1, 1)
    UiText(G, "F12 quitter", 170, 500, 120, 26, 0x9AA0A8, 11, false, 2, 1)

    ; ----- Affichage : on remplace l'image du contrôle et on supprime l'ancienne -----
    DllCall("gdiplus\GdipDeleteGraphics", "Ptr", G)
    DllCall("SelectObject", "Ptr", hdc, "Ptr", obm)
    DllCall("DeleteDC", "Ptr", hdc)

    old := DllCall("SendMessage", "Ptr", uiPic, "UInt", 0x172, "Ptr", 0, "Ptr", hbm, "Ptr")
    if (old)
        DllCall("DeleteObject", "Ptr", old)
}

; #############################################################
; #  SECTION 6 : GESTION DES BOUTONS (TOGGLES)
; #############################################################

; ---------------------------------------------------------------
; Bouton principal : active/désactive tout le script
; ---------------------------------------------------------------
ToggleScript:
    scriptEnabled := !scriptEnabled

    if (!scriptEnabled)
    {
        SetTimer, StartPlacementSequence, Off
        SetTimer, CheckReady, Off
        waitingReady := false
        readySequenceStart := 0
        SetTimer, StartPlacementSequence, Off
        groupImage := false
        groupImageStart := 0
        groupFollow := false
        groupClickImage := false
    }
    else
    {
        imageDetected := false
    }

    RefreshGui()
return

; ---------------------------------------------------------------
; Bouton EndFight : active/désactive la fermeture auto du panneau de fin de combat
; ---------------------------------------------------------------
ToggleEndFight:
    ; Cycle : OFF -> ON -> x1 -> OFF
    endFightMode := Mod(endFightMode + 1, 3)
    endFightEnabled := (endFightMode > 0)

    RefreshGui()
return

; ---------------------------------------------------------------
; Bouton AutoJoinFight : active/désactive le clic automatique sur clicktarget.png
; ---------------------------------------------------------------
ToggleAutoJoin:
    autoJoinFight := !autoJoinFight

    RefreshGui()
return

; ---------------------------------------------------------------
; Bouton Switch : active/désactive la recherche d'image target.png (rejoin des mules)
; ---------------------------------------------------------------
ToggleTargetSearch:
    targetSearchEnabled := !targetSearchEnabled

    ; on force une nouvelle détection propre à la réactivation
    if (targetSearchEnabled)
        imageDetected := false

    RefreshGui()
return

; ---------------------------------------------------------------
; Bouton Placement : OFF <-> AUTO (la couleur choisit la position 1 ou 2)
; ---------------------------------------------------------------
TogglePlacement:
    placementEnabled := !placementEnabled

    RefreshGui()
    IniWrite, % (placementEnabled ? 1 : 0), %IniFile%, Placement, Enabled
return

; ---------------------------------------------------------------
; Bouton PassTurn : F1 passe le tour + switch sur la fenêtre suivante
; ---------------------------------------------------------------
TogglePassTurn:
    passTurnEnabled := !passTurnEnabled

    RefreshGui()
return

; ---------------------------------------------------------------
; Bouton Pierres : active/désactive le double-clic auto sur pierres.png
; ---------------------------------------------------------------
TogglePierres:
    pierresEnabled := !pierresEnabled

    if (pierresEnabled)
    {
        if (!FileExist(pierresImage))
        {
            pierresEnabled := false
            ToolTip, Pierres : fichier introuvable`n%pierresImage%
            SetTimer, RemoveToolTip, -3000
        }
        else
        {
            pierresLastClick := 0
            if (!pierresAfterEscOnly)
                SetTimer, CheckPierres, %pierresScanInterval%
        }
    }

    if (!pierresEnabled)
        SetTimer, CheckPierres, Off

    RefreshGui()
return

; ---------------------------------------------------------------
; Éditeur de placement : 2 positions pour Malyna (X, Y, bouton Capturer)
; ---------------------------------------------------------------
OpenPlacementEditor:
    ; Les positions sont relatives à la fenêtre Malyna : elle doit être ouverte.
    if (!PlcEnsureRelative())
    {
        ToolTip, Ouvre la fenêtre Malyna-[Era] avant d'ouvrir l'éditeur
        SetTimer, RemoveToolTip, -2500
        return
    }

    Gui, Plc:Destroy
    Gui, Plc:+AlwaysOnTop +ToolWindow

    Gui, Plc:Add, Text, xm w70, Perso
    Gui, Plc:Add, Text, x+5 w170 Center, Pos 1
    Gui, Plc:Add, Text, x+25 w170 Center, Pos 2

    Loop % placeNames.Length()
    {
        plcRow := A_Index
        plcName := placeNames[plcRow]

        Gui, Plc:Add, Text, xm w70 h22 +0x200, %plcName%

        Loop, 2
        {
            plcP := A_Index
            plcVX := placeX[plcP][plcRow]
            plcVY := placeY[plcP][plcRow]
            plcGap := (plcP = 1) ? 5 : 25

            Gui, Plc:Add, Edit, x+%plcGap% w50 vPlcX%plcP%_%plcRow%, %plcVX%
            Gui, Plc:Add, Edit, x+5 w50 vPlcY%plcP%_%plcRow%, %plcVY%
            Gui, Plc:Add, Button, x+5 w60 gPlcCapture vPlcCap%plcP%_%plcRow%, Capturer
        }
    }

    Gui, Plc:Add, Text, xm w440 h60, AUTO : si la case Pos 1 est rouge, Malyna clique dessus ; sinon elle clique sur Pos 2 (si elle est rouge). Pos 1 = la case voulue dans un groupe de cases, Pos 2 = la case équivalente dans l'autre groupe. Clique sur Enregistrer après chaque capture. Les mules ne sont pas concernées.

    Gui, Plc:Add, Text, xm y+12 w440, REPOSITIONNEMENT : après la fin de combat (EndFight), Malyna fait un clic gauche à cette position (bouton Repositionnement du tableau principal).
    Gui, Plc:Add, Text, xm y+6 w130 h22 +0x200, Position (clic gauche)
    plcRX := (repositionX >= 0) ? repositionX : ""
    plcRY := (repositionY >= 0) ? repositionY : ""
    Gui, Plc:Add, Edit, x+5 w50 vPlcRepoX, %plcRX%
    Gui, Plc:Add, Edit, x+5 w50 vPlcRepoY, %plcRY%
    Gui, Plc:Add, Button, x+5 w70 gPlcRepoCapture, Capturer
    Gui, Plc:Add, Button, x+5 w110 gPlcRepoTest, Cliquer (test)

    Gui, Plc:Add, Text, xm y+12 w250 h22 +0x200, Tolérance de couleur de la case rouge (0-255)
    Gui, Plc:Add, Edit, x+5 w60 Number vPlcTol, %placementColorTolerance%

    Gui, Plc:Add, Button, xm w110 gPlcSave, Enregistrer
    Gui, Plc:Add, Button, x+5 w110 gPlcClear, Tout effacer

    Gui, Plc:Add, Button, xm w110 gPlcTestClick1, Cliquer pos 1
    Gui, Plc:Add, Button, x+5 w110 gPlcTestClick2, Cliquer pos 2
    Gui, Plc:Add, Button, x+5 w110 gPlcTestDetect, Tester détection
    Gui, Plc:Show,, Placement
return

; Capture : place la souris sur la case puis appuie sur la touche de capture
PlcCapture:
    capParts := StrSplit(SubStr(A_GuiControl, 7), "_")   ; "PlcCap2_3" -> placement 2, ligne 3
    capP := capParts[1]
    capIdx := capParts[2]
    capName := placeNames[capIdx]

    ToolTip, Pos %capP% : place la souris sur la case de %capName%`nPuis appuie sur %placementCaptureKey% (Échap = annuler)

    capStart := A_TickCount
    capOk := false

    Loop
    {
        if (GetKeyState("Escape", "P") || A_TickCount - capStart > 30000)
            break

        if (GetKeyState(placementCaptureKey, "P"))
        {
            MouseGetPos, capX, capY
            capOk := true
            break
        }

        Sleep, 15
    }

    ToolTip

    ; Conversion écran -> relatif à la fenêtre Malyna (et refus si hors fenêtre)
    if (capOk)
    {
        if (!PlcWindowRect(capWX, capWY, capWW, capWH))
        {
            capOk := false
            ToolTip, Capture annulée : fenêtre Malyna introuvable
            SetTimer, RemoveToolTip, -2000
        }
        else
        {
            capX := capX - capWX
            capY := capY - capWY

            if (capX < 0 || capY < 0 || capX >= capWW || capY >= capWH)
            {
                capOk := false
                ToolTip, Capture annulée : le point est hors de la fenêtre Malyna
                SetTimer, RemoveToolTip, -2000
            }
        }
    }

    if (capOk)
    {
        GuiControl, Plc:, PlcX%capP%_%capIdx%, %capX%
        GuiControl, Plc:, PlcY%capP%_%capIdx%, %capY%
        KeyWait, %placementCaptureKey%
    }
return

PlcSave:
    Gui, Plc:Submit, NoHide

    ; Position du repositionnement (vide = aucune)
    rcVX := Trim(PlcRepoX)
    rcVY := Trim(PlcRepoY)
    rcValid := true
    if rcVX is not integer
        rcValid := false
    if rcVY is not integer
        rcValid := false
    if (rcValid && rcVX >= 0 && rcVY >= 0)
    {
        repositionX := rcVX + 0
        repositionY := rcVY + 0
        IniWrite, %repositionX%, %IniFile%, Reposition, X
        IniWrite, %repositionY%, %IniFile%, Reposition, Y
    }
    else if (rcVX = "" && rcVY = "")
    {
        repositionX := -1
        repositionY := -1
        repositionEnabled := false
        IniWrite, -1, %IniFile%, Reposition, X
        IniWrite, -1, %IniFile%, Reposition, Y
        RefreshGui()
    }

    plcTolV := Trim(PlcTol)
    if plcTolV is integer
    {
        placementColorTolerance := Min(255, Max(0, plcTolV))
        IniWrite, %placementColorTolerance%, %IniFile%, Placement, ColorTol
    }

    Loop, 2
    {
        plcP := A_Index
        plcPre := (plcP = 1) ? "" : "P" plcP

        Loop % placeNames.Length()
        {
            plcRow := A_Index

            vx := Trim(PlcX%plcP%_%plcRow%)
            vy := Trim(PlcY%plcP%_%plcRow%)

            if vx is not integer
                vx := 0
            if vy is not integer
                vy := 0

            placeX[plcP][plcRow] := vx
            placeY[plcP][plcRow] := vy

            IniWrite, %vx%, %IniFile%, Placement, %plcPre%X%plcRow%
            IniWrite, %vy%, %IniFile%, Placement, %plcPre%Y%plcRow%
        }
    }

    ToolTip, Placements enregistrés
    SetTimer, RemoveToolTip, -1200
return

PlcClear:
    Loop, 2
    {
        plcP := A_Index

        Loop % placeNames.Length()
        {
            GuiControl, Plc:, PlcX%plcP%_%A_Index%, 0
            GuiControl, Plc:, PlcY%plcP%_%A_Index%, 0
        }
    }
return

; ----- Tests : enregistrent d'abord les champs, puis Malyna clique (à faire pendant un placement) -----
PlcTestClick1:
    Gosub, PlcSave
    placementCurrent := 1
    PlacementClickLeader()
return

PlcTestClick2:
    Gosub, PlcSave
    placementCurrent := 2
    PlacementClickLeader()
return

PlcTestDetect:
    Gosub, PlcSave

    if (PlacementChoose(true))
        PlacementClickLeader()
return

PlcGuiClose:
PlcGuiEscape:
    Gui, Plc:Destroy
return

RemoveToolTip:
    ToolTip
return

; ---------------------------------------------------------------
; Fermeture de la fenêtre : sauvegarde la position puis quitte
; ---------------------------------------------------------------
GuiClose:
    WinGetPos, GuiX, GuiY,,, A

    IniWrite, %GuiX%, %IniFile%, GUI, X
    IniWrite, %GuiY%, %IniFile%, GUI, Y

    ExitApp


; #############################################################
; #  SECTION 7 : RACCOURCIS CLAVIER GLOBAUX
; #############################################################

F12::ExitApp

F11::
    Gosub, ToggleScript
return

; F8 : enregistre la position de la souris comme position des pierres
; (relative à la fenêtre Malyna) : c'est là que le clic de secours aura lieu
; quand pierres.png n'est pas détectée.
F8::
    if (!PlcWindowRect(cpX, cpY, cpW, cpH))
    {
        ToolTip, Pierres : fenêtre Malyna introuvable ou réduite
        SetTimer, RemoveToolTip, -2500
        return
    }

    MouseGetPos, cpMX, cpMY

    cpRX := cpMX - cpX
    cpRY := cpMY - cpY

    if (cpRX < 0 || cpRY < 0 || cpRX >= cpW || cpRY >= cpH)
    {
        ToolTip, Pierres : la souris doit être dans la fenêtre Malyna
        SetTimer, RemoveToolTip, -2500
        return
    }

    pierresPosX := cpRX
    pierresPosY := cpRY
    IniWrite, %pierresPosX%, %IniFile%, Pierres, X
    IniWrite, %pierresPosY%, %IniFile%, Pierres, Y
    JoinLog("Pierres : position enregistree a la main " pierresPosX "/" pierresPosY " (relative a Malyna)")

    ToolTip, Pierres : position enregistrée (%pierresPosX% / %pierresPosY%)
    SetTimer, RemoveToolTip, -2000
return

; F10 : TEST Pierres. Cherche pierres.png une fois (même si le bouton Pierres est OFF),
; affiche le résultat en infobulle et place la souris dessus SANS cliquer.
F10::
    if (!PlcWindowRect(tpX, tpY, tpW, tpH))
    {
        ToolTip, Test Pierres : fenêtre Malyna introuvable ou réduite
        SetTimer, RemoveToolTip, -3000
        return
    }

    if (!FileExist(pierresImage))
    {
        ToolTip, Test Pierres : fichier introuvable`n%pierresImage%
        SetTimer, RemoveToolTip, -4000
        return
    }

    tpX2 := tpX + tpW
    tpY2 := tpY + tpH

    ImageSearch, tpFX, tpFY, %tpX%, %tpY%, %tpX2%, %tpY2%, *%pierresTolerance% %pierresImage%
    tpErr := ErrorLevel

    if (tpErr = 0)
    {
        PierresReadSize()
        tpCX := tpFX + (pierresW > 0 ? pierresW // 2 : pierresOffsetX)
        tpCY := tpFY + (pierresH > 0 ? pierresH // 2 : pierresOffsetY)
        MouseMove, %tpCX%, %tpCY%, 0
        ToolTip, Test Pierres : TROUVÉE en %tpFX% / %tpFY%`nTaille image : %pierresW% x %pierresH%`nTolérance : %pierresTolerance%
        JoinLog("Pierres TEST : trouvee en " tpFX "/" tpFY)
    }
    else if (tpErr = 1)
    {
        ToolTip, Test Pierres : NON trouvée`nTolérance : %pierresTolerance%
        JoinLog("Pierres TEST : non trouvee (tolerance " pierresTolerance ")")
    }
    else
    {
        ToolTip, Test Pierres : erreur de lecture de l'image
        JoinLog("Pierres TEST : erreur de lecture de l'image")
    }

    SetTimer, RemoveToolTip, -4000
return


; ---------------------------------------------------------------
; PassTurn : quand le bouton est ON et qu'une fenêtre Dofus est active,
; F1 passe le tour du personnage puis active le personnage suivant
; (ordre de la fenêtre "Personnages...", retour au premier après le dernier).
; Quand le bouton est OFF, F1 reste le F1 normal du jeu.
; Le "$" empêche les F1 envoyés par le script de relancer ce raccourci.
; ---------------------------------------------------------------
#If (passTurnEnabled && WinActive("ahk_exe Dofus Retro.exe"))
$F1::
    ; Une autre routine tourne : on laisse simplement passer le F1 normal.
    if (!scriptEnabled || groupPassTurn || groupFollow || groupEndFight || groupClickImage || groupWheel || groupGrouper)
    {
        SendInput, {F1}
        KeyWait, F1, P
        return
    }

    PassTurnAndSwitch()

    ; Évite la répétition si F1 reste enfoncée
    KeyWait, F1, P
return
#If

PassTurnAndSwitch()
{
    global passTurnSwitchDelay, groupPassTurn

    groupPassTurn := true

    ; ----- Passe le tour sur la fenêtre active -----
    WinGet, curID, ID, A
    SendInput, {F1}
    Sleep, %passTurnSwitchDelay%

    ; ----- Fenêtre suivante dans l'ordre des personnages -----
    chars := GetDofusChars()
    total := chars.Length()

    if (total > 1)
    {
        curIdx := 0

        Loop, %total%
        {
            if ((chars[A_Index].id + 0) = (curID + 0))
            {
                curIdx := A_Index
                break
            }
        }

        ; On cherche la prochaine fenêtre non réduite (au pire, on revient sur la même)
        Loop, %total%
        {
            nextIdx := Mod(curIdx + A_Index - 1, total) + 1
            nextID := chars[nextIdx].id

            if ((nextID + 0) = (curID + 0))
                break

            WinGet, nextMM, MinMax, ahk_id %nextID%

            if (nextMM = -1)
                continue

            ActivateIfNeeded(nextID)
            break
        }
    }

    groupPassTurn := false
}


; #############################################################
; #  SECTION 8 : MODULE - DETECTION IMAGE LEADER (REJOIN MULES)
; #############################################################

; ---------------------------------------------------------------
; Scanne target.png sur la fenêtre principale. Si détectée pour la
; première fois, active la fenêtre principale puis bascule sur la
; première mule trouvée.
; ---------------------------------------------------------------
CheckImage:

    ; Sécurité : si un ancien passage a laissé le verrou Switch bloqué,
    ; on le libère après 5 secondes pour éviter de bloquer le placement.
    if (groupImage && groupImageStart && A_TickCount - groupImageStart > 5000)
    {
        groupImage := false
        groupImageStart := 0
        PlcLog("securite : verrou Switch bloque, liberation automatique")
    }

    ; Ne pas laisser Switch changer de fenetre pendant le placement / l'attente de ready.png.
    if (!scriptEnabled || !targetSearchEnabled || waitingReady || groupImage || groupFollow || groupEndFight || groupClickImage)
        return

    groupImage := true
    groupImageStart := A_TickCount

    WinGet, mainID, ID, %mainWindow%

    if (!mainID)
    {
        groupImage := false
        groupImageStart := 0
        return
    }

    WinGetPos, winX, winY, winW, winH, ahk_id %mainID%

    x2 := winX + winW
    y2 := winY + winH

    ImageSearch, foundX, foundY, %winX%, %winY%, %x2%, %y2%, *20 %imageFile%

    if (ErrorLevel = 0 && !imageDetected)
    {
        imageDetected := true

        ActivateIfNeeded(mainID)

        Sleep, joinLeaderDelay

        WinGet, id, List, ahk_exe Dofus Retro.exe

        Loop, %id%
        {
            this_id := id%A_Index%

            if (this_id != mainID)
            {
                ActivateIfNeeded(this_id)
                break
            }
        }
    }
    else if (ErrorLevel != 0)
    {
        imageDetected := false
    }

    groupImage := false
    groupImageStart := 0

return


; #############################################################
; #  SECTION 9 : MODULE - CLIC AUTO SUR CIBLE DE COMBAT
; #############################################################

; ---------------------------------------------------------------
; Scanne clicktarget.png. Si détectée : clic droit sur chaque mule,
; retour sur le leader si target.png est visible, puis F1 sur tous.
; ---------------------------------------------------------------
CheckClickImage:

    if (!scriptEnabled || !autoJoinFight || groupFollow || groupImage || groupEndFight || groupClickImage)
        return

    groupClickImage := true

    WinGet, mainID, ID, %mainWindow%

    if (!mainID)
    {
        groupClickImage := false
        return
    }

    WinGetPos, winX, winY, winW, winH, ahk_id %mainID%

    x2 := winX + winW
    y2 := winY + winH

    ImageSearch, foundX, foundY, %winX%, %winY%, %x2%, %y2%, *%clickTolerance% %clickImageFile%

    if (ErrorLevel = 0 && !imageClicked)
    {
        clickX := foundX + clickOffsetX
        clickY := foundY + clickOffsetY
        missed := false
        joinAttempts++
        fightStartTick := A_TickCount   ; début de combat : bloque Pierres

        WinGet, joinStartProc, ProcessName, A
        JoinLog("--- tentative " joinAttempts " : cible en " foundX "/" foundY " -> clic " clickX "/" clickY " (fenetre active au depart : " joinStartProc ")")

        WinGet, id, List, ahk_exe Dofus Retro.exe

        ; Si on arrive depuis une autre application (Chrome...), Windows met plus
        ; de temps à donner le focus : on active d'abord le leader et on laisse
        ; le focus se stabiliser avant de commencer les clics.
        if (!WinActive("ahk_exe Dofus Retro.exe"))
        {
            ActivateIfNeeded(mainID)
            Sleep, %joinOutsideDelay%
        }

        ; ----- Clic droit sur chaque mule -----
        Loop, %id%
        {
            this_id := id%A_Index%

            if (this_id = mainID)
                continue

            ; Mule déjà cliquée lors d'une tentative précédente : on ne reclique pas.
            if (joinDone[this_id])
                continue

            ; Si la fenêtre n'a pas pu prendre le focus, on ne clique pas
            ; (sinon le clic partirait dans la mauvaise fenêtre)
            if (!ActivateIfNeeded(this_id))
            {
                missed := true
                JoinLog("mule " this_id " : focus impossible, a retenter")
                continue
            }

            Sleep, %joinActivateDelay%

            ; Vérifie que la mule a VRAIMENT le focus avant de cliquer
            ; (sinon le clic part dans Chrome ou dans une autre fenêtre).
            if (!WinActive("ahk_id " this_id))
            {
                ActivateIfNeeded(this_id)
                Sleep, %joinOutsideDelay%

                if (!WinActive("ahk_id " this_id))
                {
                    missed := true
                    JoinLog("mule " this_id " : focus perdu apres activation, a retenter")
                    continue
                }
            }

            ; La souris est déjà sur la cible depuis la mule précédente : sans vrai
            ; mouvement, la nouvelle fenêtre peut garder son ancienne case survolée.
            ; On passe donc d'abord à côté, puis sur la cible exacte.
            MouseMove, % clickX - joinWiggle, % clickY - joinWiggle, 0
            Sleep, %joinWiggleDelay%
            MouseMove, %clickX%, %clickY%, 0
            Sleep, %joinMoveDelay%

            ; Dernière vérification JUSTE avant le clic : focus + position de la souris
            ; (si tu bouges la souris pendant la routine, on la remet sur la cible).
            MouseGetPos, curX, curY

            if (!WinActive("ahk_id " this_id) || Abs(curX - clickX) > 2 || Abs(curY - clickY) > 2)
            {
                JoinLog("mule " this_id " : correction avant clic (souris " curX "/" curY ")")

                ActivateIfNeeded(this_id)
                MouseMove, %clickX%, %clickY%, 0
                Sleep, %joinMoveDelay%

                if (!WinActive("ahk_id " this_id))
                {
                    missed := true
                    JoinLog("mule " this_id " : focus perdu avant le clic, a retenter")
                    continue
                }
            }

            Click, Right
            joinDone[this_id] := true
            JoinLog("mule " this_id " : clic droit effectue")

            Sleep, joinRightClickDelay
        }

        ; Une mule a été ratée : on réessaie au prochain scan SANS refaire les clics
        ; ni le F1 des autres. Après 3 tentatives, on passe à la suite quand même.
        if (missed && joinAttempts < 3)
        {
            JoinLog("tentative incomplete : nouvel essai au prochain scan")
            imageClicked := false
        }
        else
        {
            ; ----- Retour sur le leader si toujours visible -----
            if (IsTargetVisible())
            {
                ActivateIfNeeded(mainID)
                Sleep, %joinLeaderReturnDelay%
            }

            ; ----- F1 sur toutes les fenêtres -----
            Loop, %id%
            {
                this_id := id%A_Index%

                ActivateIfNeeded(this_id)

                SendInput, {F1}

                Sleep, joinF1Delay
            }

            ActivateIfNeeded(mainID)

            missedTxt := missed ? "oui" : "non"
            JoinLog("join termine (tentatives : " joinAttempts ", mule(s) ratee(s) : " missedTxt ")")
            imageClicked := true
            fightStartTick := A_TickCount   ; fin du join : Pierres reste bloquée pendant le début du combat
        }
    }
    else if (ErrorLevel != 0)
    {
        imageClicked := false
        joinDone := {}
        joinAttempts := 0
    }

    groupClickImage := false

return


; #############################################################
; #  SECTION 10 : MODULE - FOLLOW (CLIC DROIT PARTAGÉ)
; #############################################################

; ---------------------------------------------------------------
; Reproduit le clic droit de la souris sur toutes les mules,
; à la même position relative, puis envoie F1 sur toutes.
; ---------------------------------------------------------------
; Le "~" laisse TOUJOURS passer le vrai clic droit : il ne peut plus être bloqué.
#IfWinActive ahk_exe Dofus Retro.exe
~RButton::

    if (!scriptEnabled)
    {
        PlcLog("clic droit ignore : script desactive")
        return
    }

    ; Les autres routines restent prioritaires, mais Switch (groupImage)
    ; ne doit plus faire ignorer ce clic droit de placement.
    if (groupFollow || groupEndFight || groupClickImage)
    {
        if (groupFollow)
            PlcLog("clic droit ignore : Grouper (groupFollow) deja en cours")
        else if (groupEndFight)
            PlcLog("clic droit ignore : EndFight deja en cours")
        else if (groupClickImage)
            PlcLog("clic droit ignore : detection/clic image deja en cours")
        return
    }

    ; On mémorise la position de la souris pour la routine.
    MouseGetPos, followX, followY

    ; Une séquence placement/ready est déjà en cours.
    if (waitingReady)
    {
        PlcLog("clic droit ignore : sequence placement/ready deja en cours")
        return
    }

    ; Verrouiller immédiatement Switch, avant même la recherche de couleur.
    waitingReady := true
    readySequenceStart := A_TickCount

    ; Si Switch était déjà en train de changer de fenêtre, attendre sa fin
    ; via un timer (ne pas attendre dans cette routine, car AHK la suspendrait).
    if (groupImage)
    {
        PlcLog("clic droit recu : attente de la fin de Switch avant le placement")
        SetTimer, StartPlacementSequence, 20
        return
    }

    Gosub, StartPlacementSequence
return

; Lance le placement une fois que Switch a fini son éventuel changement de fenêtre.
StartPlacementSequence:
    if (!waitingReady)
    {
        PlcLog("demarrage placement ignore : waitingReady est deja a false")
        return
    }

    if (groupImage)
    {
        SetTimer, StartPlacementSequence, 20
        return
    }

    SetTimer, StartPlacementSequence, Off

PlcLog("sequence placement demarree ; placementEnabled=" placementEnabled)

; ----- Détection du placement (uniquement si Placement = AUTO) -----

placementFound := false

if (placementEnabled)
{
    waitPlacementStart := A_TickCount

    Loop
    {
        if (PlacementChoose())
        {
            placementFound := true
            break
        }

        if (A_TickCount - waitPlacementStart >= 15000)
            break

        Sleep, 100
    }

    if (placementFound)
    {
        Sleep, %placementBeforeClickDelay%
        PlacementClickLeader()
        Sleep, %placementAfterClickDelay%
    }
}

; Le chrono de ready.png démarre maintenant (et non au clic droit)
readySequenceStart := A_TickCount
waitStart := A_TickCount
SetTimer, CheckReady, %readyScanInterval%
return
#IfWinActive


; ---------------------------------------------------------------
; Attend ready.png après le clic droit. Dès qu'il est visible :
; routine complète (clic droit sur les mules + F1 sur toutes).
; ---------------------------------------------------------------
CheckReady:

    ; Délai dépassé (ou script coupé) : on abandonne
    ; Timeout absolu : ne pas remettre le chrono à zéro si une autre
    ; routine reste bloquée, sinon le clic droit peut être verrouillé indéfiniment.
    if (!scriptEnabled || (readySequenceStart && A_TickCount - readySequenceStart > readyTimeout))
    {
        SetTimer, CheckReady, Off
        SetTimer, StartPlacementSequence, Off
        waitingReady := false
        readySequenceStart := 0
        PlcLog("securite : sequence placement/ready abandonnee (timeout)")
        return
    }

    ; Une autre routine est en cours : on réessaie au prochain passage
    ; (et on remet le chrono à zéro pour ne pas abandonner pendant ce temps)
    if (groupFollow || groupEndFight || groupImage || groupClickImage || groupWheel)
    {
        waitStart := A_TickCount
        return
    }

    if (!IsReadyVisible())
        return

    ; ----- ready.png détecté : routine complète -----
    fightStartTick := A_TickCount   ; début de combat : bloque Pierres un moment
    SetTimer, CheckReady, Off
    waitingReady := false
    readySequenceStart := 0

    groupFollow := true

    WinGet, mainID, ID, %mainWindow%

    if (!mainID)
    {
        groupFollow := false
        return
    }

    WinGet, id, List, ahk_exe Dofus Retro.exe

    ; ready.png détecté : la routine continue comme avant.
    ; Le placement a déjà été vérifié avant le démarrage de cette détection.
    PlcLog("ready.png detecte : debut de la routine")

    ; Clic droit sur toutes les mules
    Loop, %id%
    {
        this_id := id%A_Index%

        if (this_id = mainID)
            continue

        WinGet, MinMax, MinMax, ahk_id %this_id%

        if (MinMax = -1)
            continue

        ActivateIfNeeded(this_id)

        Sleep, followClickDelay

        ControlClick, x%followX% y%followY%, ahk_id %this_id%,, Right, 1, NA

        Sleep, followWindowDelay
    }

    ; F1 sur toutes les fenêtres
    Loop, %id%
    {
        this_id := id%A_Index%

        WinGet, MinMax, MinMax, ahk_id %this_id%

        if (MinMax = -1)
            continue

        ActivateIfNeeded(this_id)

        Sleep, stabilizationDelay

        SendInput, {F1}

        Sleep, followF1Delay
    }

    ActivateIfNeeded(mainID)

    Sleep, followReturnDelay

    ; Après le follow, on réévalue clicktarget à neuf
    imageClicked := false

    fightStartTick := A_TickCount   ; fin de la routine : Pierres reste bloquée pendant le début du combat

    groupFollow := false

return


; #############################################################
; #  SECTION 11 : MODULE - WHEEL (CLIC GAUCHE PARTAGÉ)
; #############################################################

; ---------------------------------------------------------------
; Reproduit un clic gauche à la même position relative sur toutes
; les fenêtres (ex : lancer de sort/roue), puis revient au leader.
; ---------------------------------------------------------------
; XButton2 et XButton1 ne fonctionnent que si une fenêtre Dofus est active
#IfWinActive ahk_exe Dofus Retro.exe

$XButton2::

    if (!scriptEnabled || groupEndFight || groupWheel || groupFollow)
        return

    groupWheel := true

    MouseGetPos, relX, relY

    WinGet, id, List, ahk_exe Dofus Retro.exe

    Loop, %id%
    {
        this_id := id%A_Index%

        ActivateIfNeeded(this_id)

        ControlClick, x%relX% y%relY%, ahk_id %this_id%,, Left, 1, NA

        Sleep, wheelClickDelay
    }

    ; ----- Retour sur Malyna à la fin (on réessaie jusqu'à 3 fois si besoin) -----
    WinGet, mainID, ID, %mainWindow%

    Loop, 3
    {
        ActivateIfNeeded(mainID)

        WinGet, activeNow, ID, A

        if (activeNow = mainID)
            break

        Sleep, 50
    }

    Sleep, wheelEndDelay

    groupWheel := false

return


; #############################################################
; #  SECTION 11 bis : BOUTON LATERAL "ARRIERE" (XButton1)
; #############################################################

; ---------------------------------------------------------------
; Clic droit + switch sur chaque mule (x7), puis F1 sur chaque
; fenêtre (x8, mules + Malyna), puis retour sur Malyna.
; Les nombres suivent les fenêtres Dofus ouvertes (7 mules + Malyna).
; ---------------------------------------------------------------
$XButton1::

    if (!scriptEnabled)
    {
        Click, X1
        return
    }

    if (groupFollow || groupWheel || groupEndFight || groupGrouper)
        return

    groupFollow := true

    WinGet, mainID, ID, %mainWindow%

    if (!mainID)
    {
        groupFollow := false
        return
    }

    MouseGetPos, xbX, xbY

    WinGet, xbWin, List, ahk_exe Dofus Retro.exe

    ; ----- Clic droit + switch sur les mules (x7) -----
    Loop, %xbWin%
    {
        this_id := xbWin%A_Index%

        if (this_id = mainID)
            continue

        WinGet, MinMax, MinMax, ahk_id %this_id%

        if (MinMax = -1)
            continue

        ActivateIfNeeded(this_id)

        Sleep, followClickDelay

        ControlClick, x%xbX% y%xbY%, ahk_id %this_id%,, Right, 1, NA

        Sleep, followWindowDelay
    }

    ; ----- F1 sur toutes les fenêtres (x8) -----
    Loop, %xbWin%
    {
        this_id := xbWin%A_Index%

        WinGet, MinMax, MinMax, ahk_id %this_id%

        if (MinMax = -1)
            continue

        ActivateIfNeeded(this_id)

        Sleep, stabilizationDelay

        SendInput, {F1}

        Sleep, followF1Delay
    }

    ; ----- Retour sur Malyna -----
    Loop, 3
    {
        ActivateIfNeeded(mainID)

        WinGet, activeNow, ID, A

        if (activeNow = mainID)
            break

        Sleep, 50
    }

    Sleep, followReturnDelay

    groupFollow := false

return


; Fin de la restriction aux fenêtres Dofus
#IfWinActive


; #############################################################
; #  SECTION 12 : MODULE - FERMETURE AUTO FIN DE COMBAT
; #############################################################

; ---------------------------------------------------------------
; Scanne endfight.png. Si détectée : envoie Echap sur toutes les
; fenêtres pour fermer le panneau de fin de combat.
; ---------------------------------------------------------------
CheckEndFight:

    if (!scriptEnabled || !endFightEnabled || groupEndFight)
        return

    ; Début de combat : pas d'Échap maintenant (sinon, s'il n'y a rien à fermer,
    ; il ouvre le menu du jeu sur Malyna). Le vrai Échap de fin de combat arrive bien plus tard.
    if (fightStartTick && A_TickCount - fightStartTick < endFightBlockAfterStart)
        return

    ; ----- Mode x1 : un simple Echap sur Malyna, SANS verrou et sans switch -----
    ; On ne pose pas groupEndFight pour ne jamais bloquer le join des mules
    ; (CheckClickImage / CheckImage / RButton testent ce verrou).
    ; On n'envoie rien tant qu'une autre routine travaille sur les fenetres.
    if (endFightMode = 2)
    {
        if (groupFollow || groupClickImage || groupWheel || groupGrouper || groupImage || waitingReady)
            return

        ; Variables propres a ce bloc (xf*) : pas de risque d'ecraser celles des autres routines.
        WinGet, xfMain, ID, %mainWindow%

        if (!xfMain)
            return

        WinGetPos, xfX, xfY, xfW, xfH, ahk_id %xfMain%

        xfX2 := xfX + xfW
        xfY2 := xfY + xfH

        ImageSearch, xfFoundX, xfFoundY, %xfX%, %xfY%, %xfX2%, %xfY2%, *20 %endFightImage%

        if (ErrorLevel = 0)
        {
            monsterInFight := false
            monsterBlockUntil := A_TickCount + monsterAfterFight
            xfEscSent := false
            xfOnMalyna := false

            ; Re-vérification ATOMIQUE : pendant la recherche d'image, le join des mules
            ; (ou un F1) a pu démarrer. Critical = aucune autre routine ne peut s'intercaler
            ; entre ce test et l'envoi de l'Echap.
            Critical

            ; On re-teste aussi le blocage "début de combat" : la recherche d'image ci-dessus a pu être
            ; interrompue par le join des mules, et reprendre juste après sa fin avec un résultat périmé.
            xfStartBlock := (fightStartTick && A_TickCount - fightStartTick < endFightBlockAfterStart)

            if (!(groupFollow || groupClickImage || groupWheel || groupGrouper || groupImage || waitingReady || groupEndFight || xfStartBlock))
            {
                WinGet, xfActive, ID, A

                if (xfActive = xfMain)
                    SendInput, {Esc}
                else
                    ControlSend,, {Esc}, ahk_id %xfMain%

                xfActiveTxt := (xfActive = xfMain) ? "oui" : "non"
                JoinLog("EndFight x1 : Echap envoye sur Malyna (Malyna etait active : " xfActiveTxt ")")
                xfEscSent := true
                xfOnMalyna := (xfActive = xfMain)
            }

            Critical, Off

            ; Pierres : seulement si le panneau était bien sur MALYNA (Malyna au premier plan).
            ; ImageSearch lit l'écran : si une mule était affichée, c'est son panneau qui a été vu.
            if (xfEscSent && xfOnMalyna && pierresAfterEscOnly)
                PierresRun(true)
            else if (xfEscSent)
                JoinLog("Pierres : ignoree, le panneau n'etait pas sur Malyna (une mule etait au premier plan)")

            ; Repositionnement : clic gauche à la position enregistrée (après les Pierres)
            if (xfEscSent && xfOnMalyna)
                RepositionRun()
        }

        return
    }

    ; Mode ON : on ne démarre pas pendant que le join, le follow, la molette ou le
    ; grouper envoient leurs touches / clics (sinon l'Echap tombe au mauvais moment).
    if (groupFollow || groupClickImage || groupWheel || groupGrouper)
        return

    groupEndFight := true

    WinGet, mainID, ID, %mainWindow%

    if (!mainID)
    {
        groupEndFight := false
        return
    }

    WinGetPos, winX, winY, winW, winH, ahk_id %mainID%

    x2 := winX + winW
    y2 := winY + winH

    ImageSearch, foundX, foundY, %winX%, %winY%, %x2%, %y2%, *20 %endFightImage%

    if (ErrorLevel = 0)
    {
        ; Le panneau est visible : on retente Echap a chaque detection.
        ; Si un premier Echap n'a pas pris le focus, le suivant fonctionnera.
        monsterInFight := false
        monsterBlockUntil := A_TickCount + monsterAfterFight
        panelClosed := false
        efEscSent := false
        efMainEsc := false

        WinGet, id, List, ahk_exe Dofus Retro.exe

        Loop, %id%
        {
            this_id := id%A_Index%

            ; Force le vrai focus de la fenetre avant Echap.
            WinActivate, ahk_id %this_id%
            WinWaitActive, ahk_id %this_id%,, 0.5
            Sleep, 50

            ; On verifie que le panneau est bien visible SUR CETTE FENETRE
            ; avant d'envoyer Echap (sinon on passe a la suivante).
            WinGetPos, wX, wY, wW, wH, ahk_id %this_id%

            wX2 := wX + wW
            wY2 := wY + wH

            ImageSearch, fx, fy, %wX%, %wY%, %wX2%, %wY2%, *20 %endFightImage%

            if (ErrorLevel != 0)
                continue

            SendInput, {Esc}
            JoinLog("EndFight ON : Echap envoye sur la fenetre " this_id)
            efEscSent := true

            if (this_id = mainID)
                efMainEsc := true

            Sleep, endFightDelay
        }

        ActivateIfNeeded(mainID)

        ; Pierres : seulement si un Échap a été envoyé sur MALYNA elle-même (pas sur une mule).
        if (efMainEsc && pierresAfterEscOnly)
            PierresRun(true)
        else if (efEscSent)
            JoinLog("Pierres : ignoree, le panneau n'etait pas sur Malyna (Echap envoye seulement sur une mule)")

        ; Repositionnement : clic gauche à la position enregistrée (après les Pierres)
        if (efMainEsc)
            RepositionRun()
    }
    else
    {
        ; L'image a disparu : le panneau est bien ferme.
        panelClosed := true
    }

    groupEndFight := false

return

; #############################################################
; #  SECTION 14 : MODULE - DOUBLE-CLIC AUTO SUR PIERRES
; #############################################################

; ---------------------------------------------------------------
; Lit la taille de pierres.png (pour cliquer au centre de l'image).
; Si la lecture échoue, on retombe sur pierresOffsetX / pierresOffsetY.
; ---------------------------------------------------------------
PierresReadSize()
{
    global pierresImage, pierresW, pierresH, PierresPic

    if (pierresW > 0 && pierresH > 0)
        return

    Gui, PierresSize:Default
    Gui, PierresSize:-DPIScale
    Gui, PierresSize:Add, Picture, vPierresPic, %pierresImage%
    GuiControlGet, psz, PierresSize:Pos, PierresPic
    Gui, PierresSize:Destroy
    Gui, 1:Default

    pierresW := pszW + 0
    pierresH := pszH + 0
}

; ---------------------------------------------------------------
; Timer (scan continu) : utilisé seulement si pierresAfterEscOnly := false
; ---------------------------------------------------------------
CheckPierres:
    PierresRun(false)
return


; ---------------------------------------------------------------
; Double-clic en (x, y) sur la fenêtre wid, puis la souris revient où elle était.
; ---------------------------------------------------------------
PierresDoubleClick(wid, x, y, label)
{
    global pierresHoverDelay, pierresLastClick

    pierresLastClick := A_TickCount

    if (!ActivateIfNeeded(wid))
    {
        JoinLog("Pierres : Malyna n'a pas pris le focus, double-clic annule")
        return false
    }

    MouseGetPos, oldX, oldY

    ; Critical : aucune autre routine ne peut s'intercaler pendant le double-clic.
    Critical

    MouseMove, %x%, %y%, 0
    Sleep, %pierresHoverDelay%
    Click, 2
    Sleep, %pierresHoverDelay%
    MouseMove, %oldX%, %oldY%, 0

    Critical, Off

    JoinLog("Pierres : double-clic effectue (" label ") en " x "/" y)
    return true
}


; ---------------------------------------------------------------
; Cherche pierres.png dans la fenêtre Malyna. Si elle est détectée : AUCUN
; clic (sauf si pierresClickIfFound := true). Si elle n'est PAS détectée
; (après un Échap) : double-clic à la position mémorisée (F8 pour la définir).
; afterEsc = true : appelée juste après l'Échap sur Malyna ; on attend
; que le panneau se ferme, puis on réessaie jusqu'au délai max.
; Tout est journalisé dans join.log (lignes "Pierres : ...").
; ---------------------------------------------------------------
PierresRun(afterEsc := false)
{
    global

    if (!scriptEnabled || !pierresEnabled || groupPierres)
    {
        if (afterEsc)
            JoinLog("Pierres : appelee apres Echap mais ignoree (script ON=" scriptEnabled ", Pierres ON=" pierresEnabled ", deja en cours=" groupPierres ")")
        return
    }

    ; Début de combat (ready.png détecté il y a peu) : jamais de clic Pierres maintenant.
    if (fightStartTick && A_TickCount - fightStartTick < pierresBlockAfterReady)
    {
        JoinLog("Pierres : bloquee, debut de combat (ready.png detecte il y a " A_TickCount - fightStartTick " ms)")
        return
    }

    ; Pause après un double-clic : laisse le jeu réagir.
    if (A_TickCount - pierresLastClick < pierresCooldown)
    {
        if (afterEsc)
            JoinLog("Pierres : ignoree (pause apres le dernier double-clic)")
        return
    }

    ; Laisse le panneau de fin de combat se fermer après l'Échap.
    if (afterEsc)
    {
        JoinLog("Pierres : declenchee apres Echap, attente " pierresAfterEscDelay " ms")
        Sleep, %pierresAfterEscDelay%
    }

    ; Y a-t-il une position mémorisée pour le clic de secours ?
    prHasFallback := (pierresFallbackClick && pierresPosX >= 0 && pierresPosY >= 0)
    prLimit := prHasFallback ? pierresFallbackAfter : pierresAfterEscTimeout

    prStart := A_TickCount
    prTries := 0
    groupPierres := true

    Loop
    {
        ; Ne pas gêner les routines qui utilisent déjà la souris / les fenêtres.
        ; (groupEndFight n'est pas testé quand on est appelé depuis l'EndFight lui-même.)
        prBusy := (groupFollow || groupImage || groupClickImage || groupWheel || groupGrouper || waitingReady)

        if (!afterEsc && groupEndFight)
            prBusy := true

        if (fightStartTick && A_TickCount - fightStartTick < pierresBlockAfterReady)
            prBusy := true

        if (prBusy)
        {
            if (afterEsc)
                JoinLog("Pierres : abandon, une autre routine travaille (follow=" groupFollow " switch=" groupImage " join=" groupClickImage " molette=" groupWheel " grouper=" groupGrouper " ready=" waitingReady ")")
            break
        }

        prMain := PlcWindowRect(prX, prY, prW, prH)

        if (!prMain)
        {
            JoinLog("Pierres : abandon, fenetre Malyna introuvable ou reduite")
            break
        }

        ; ImageSearch lit l'écran : si une mule est au premier plan, on verrait SON contenu.
        ; Pierres ne travaille donc que si Malyna est la fenêtre active.
        if (!WinActive("ahk_id " prMain))
        {
            if (afterEsc)
                JoinLog("Pierres : abandon, Malyna n'est pas au premier plan (une mule est affichee)")
            break
        }

        prX2 := prX + prW
        prY2 := prY + prH

        prTries++
        ImageSearch, prFoundX, prFoundY, %prX%, %prY%, %prX2%, %prY2%, *%pierresTolerance% %pierresImage%
        prErr := ErrorLevel

        if (prErr = 2)
        {
            ; Problème avec le fichier image : on coupe proprement le module.
            JoinLog("Pierres : ERREUR de lecture de " pierresImage " -> module coupe")
            pierresEnabled := false
            SetTimer, CheckPierres, Off
            RefreshGui()
            ToolTip, Pierres : impossible de lire pierres.png
            SetTimer, RemoveToolTip, -3000
            break
        }

        if (prErr = 0)
        {
            PierresReadSize()

            if (pierresW > 0 && pierresH > 0)
            {
                prClickX := prFoundX + pierresW // 2
                prClickY := prFoundY + pierresH // 2
            }
            else
            {
                prClickX := prFoundX + pierresOffsetX
                prClickY := prFoundY + pierresOffsetY
            }

            JoinLog("Pierres : IMAGE TROUVEE en " prFoundX "/" prFoundY " (taille " pierresW "x" pierresH ", essai " prTries ")")

            ; Image détectée : par défaut on ne clique PAS (on ne clique que si elle est absente).
            if (!pierresClickIfFound)
            {
                JoinLog("Pierres : image detectee -> pas de clic")
                break
            }

            PierresDoubleClick(prMain, prClickX, prClickY, "image detectee")

            ; Mémorise cette position (relative à la fenêtre Malyna) pour le clic de secours.
            prRelX := prClickX - prX
            prRelY := prClickY - prY

            if (prRelX != pierresPosX || prRelY != pierresPosY)
            {
                pierresPosX := prRelX
                pierresPosY := prRelY
                IniWrite, %pierresPosX%, %IniFile%, Pierres, X
                IniWrite, %pierresPosY%, %IniFile%, Pierres, Y
                JoinLog("Pierres : position memorisee " pierresPosX "/" pierresPosY " (relative a Malyna)")
            }

            break
        }

        ; Pas trouvée : en mode scan continu on s'arrête là (le timer repassera).
        if (!afterEsc)
            break

        ; Après un Échap : on réessaie jusqu'au délai, puis clic de secours.
        if (A_TickCount - prStart >= prLimit)
        {
            if (prHasFallback && fightStartTick && A_TickCount - fightStartTick < pierresBlockAfterReady)
            {
                JoinLog("Pierres : clic de secours annule, un combat vient de demarrer")
            }
            else if (prHasFallback)
            {
                prFbX := prX + pierresPosX
                prFbY := prY + pierresPosY
                JoinLog("Pierres : image NON trouvee apres " prTries " essais, clic de secours a la position memorisee")
                PierresDoubleClick(prMain, prFbX, prFbY, "position memorisee")
            }
            else
            {
                JoinLog("Pierres : image NON trouvee apres " prTries " essais (" A_TickCount - prStart " ms), tolerance=" pierresTolerance ", aucune position memorisee (F8 pour en enregistrer une)")
            }

            break
        }

        Sleep, %pierresRetryInterval%
    }

    groupPierres := false
}


; #############################################################
; #  SECTION 15 : MODULE - PERSONNAGES (DÉTECTION PAR TITRE DE FENÊTRE)
; #############################################################

; ---------------------------------------------------------------
; Extrait le nom du personnage d'un titre de fenêtre Dofus, par ex :
;   "Malyna-[Era] - Dofus Retro v1.49.9"  ->  "Malyna"
; Renvoie "" si le titre ne contient pas de personnage (écran de connexion...).
; ---------------------------------------------------------------
DofusCharName(title)
{
    if (RegExMatch(title, "^(.+?)-\[[^\]]*\]\s*-\s*Dofus", m))
        return Trim(m1)

    if (RegExMatch(title, "^(.+?)\s+-\s+Dofus", m))
        return Trim(m1)

    return ""
}

; ---------------------------------------------------------------
; Liste des personnages connectés : tableau d'objets {id, name}, dans
; l'ordre choisi par l'utilisateur (sauvegardé dans le .ini). Les
; personnages inconnus sont ajoutés à la fin : le chef (Malyna) d'abord,
; puis les autres par ordre alphabétique.
; ---------------------------------------------------------------
GetDofusChars()
{
    global mainWindow, charsOrder

    found := {}
    others := ""
    leaderName := ""

    WinGet, leaderId, ID, %mainWindow%
    WinGet, ids, List, ahk_exe Dofus Retro.exe

    Loop, %ids%
    {
        wid := ids%A_Index%
        WinGetTitle, t, ahk_id %wid%
        nm := DofusCharName(t)

        if (nm = "")
            continue

        found[nm] := wid

        if (leaderId && (wid + 0) = (leaderId + 0))
            leaderName := nm
    }

    result := []
    used := {}

    ; 1. Ordre sauvegardé
    for i, n in charsOrder
    {
        if (n != "" && found.HasKey(n) && !used.HasKey(n))
        {
            result.Push({id: found[n], name: n})
            used[n] := true
        }
    }

    ; 2. Nouveaux personnages : le chef d'abord, puis les autres par ordre alphabétique
    if (leaderName != "" && !used.HasKey(leaderName))
    {
        result.Push({id: found[leaderName], name: leaderName})
        used[leaderName] := true
    }

    for n, wid2 in found
    {
        if (!used.HasKey(n))
            others .= n "`t" wid2 "`n"
    }

    Sort, others

    Loop, Parse, others, `n, `r
    {
        if (A_LoopField = "")
            continue

        parts := StrSplit(A_LoopField, "`t")
        result.Push({id: parts[2], name: parts[1]})
    }

    return result
}

; ---------------------------------------------------------------
; Sauvegarde l'ordre (noms) dans le .ini. Les noms connus mais hors ligne
; sont conservés à la fin.
; ---------------------------------------------------------------
CharsSaveOrder(names)
{
    global IniFile, charsOrder

    saved := ""

    for i, n in names
        saved .= n "|"

    for i, o in charsOrder
    {
        isShown := false

        for j, n in names
        {
            if (n = o)
                isShown := true
        }

        if (o != "" && !isShown)
            saved .= o "|"
    }

    saved := RTrim(saved, "|")
    IniWrite, %saved%, %IniFile%, Chars, Order
    charsOrder := StrSplit(saved, "|")
}

; ---------------------------------------------------------------
; Monte (dir = -1) ou descend (dir = 1) la ligne sélectionnée du tableau.
; ---------------------------------------------------------------
CharsMove(dir)
{
    global charsSnapshot

    Gui, Chars:Default

    row := LV_GetNext(0)
    count := LV_GetCount()
    newRow := row + dir

    if (!row || newRow < 1 || newRow > count)
        return

    names := []

    Loop, %count%
    {
        LV_GetText(nm, A_Index, 1)
        names.Push(nm)
    }

    tmp := names[row]
    names[row] := names[newRow]
    names[newRow] := tmp

    CharsSaveOrder(names)

    ; Rafraîchit tout de suite le tableau, puis re-sélectionne la ligne déplacée.
    charsSnapshot := ""
    Gosub, RefreshChars

    Gui, Chars:Default
    LV_Modify(newRow, "Select Focus")
}

; ---------------------------------------------------------------
; Fenêtre "Personnages" : tableau des noms détectés (dans TON ordre),
; mis à jour toutes les 1,5 s. Boutons Monter / Descendre pour classer.
; ---------------------------------------------------------------
OpenChars:
    if (charsOpen)
    {
        Gui, Chars:Show
        return
    }

    Gui, Chars:+AlwaysOnTop +ToolWindow
    Gui, Chars:Add, ListView, r10 w260 vCharsLV -Multi NoSortHdr, Personnage|Rôle
    Gui, Chars:Add, Button, w125 gCharsUp, ▲ Monter
    Gui, Chars:Add, Button, x+10 w125 gCharsDown, ▼ Descendre
    Gui, Chars:Show, , Personnages

    charsOpen := true
    charsSnapshot := ""

    Gosub, RefreshChars
    SetTimer, RefreshChars, 1500
return

CharsUp:
    CharsMove(-1)
return

CharsDown:
    CharsMove(1)
return

RefreshChars:
    if (!charsOpen)
        return

    ; Variables préfixées "rc" : ne jamais écraser celles du Grouper (même timer partagé).
    rcChars := GetDofusChars()
    WinGet, rcLeader, ID, %mainWindow%

    rcSnap := ""
    for rcI, rcC in rcChars
        rcSnap .= rcC.name "|" rcC.id "`n"

    if (rcSnap = charsSnapshot)
        return

    charsSnapshot := rcSnap

    Gui, Chars:Default
    LV_Delete()

    for rcI, rcC in rcChars
    {
        rcRole := (rcLeader && (rcC.id + 0) = (rcLeader + 0)) ? "Chef" : "Mule"
        LV_Add("", rcC.name, rcRole)
    }

    LV_ModifyCol(1, 150)
    LV_ModifyCol(2, "AutoHdr")
return

CharsGuiClose:
CharsGuiEscape:
    SetTimer, RefreshChars, Off
    charsOpen := false
    Gui, Chars:Destroy
return


; #############################################################
; #  SECTION 13 : MODULE - GROUPER (INVITATIONS AUTO)
; #############################################################

; ---------------------------------------------------------------
; Invite chaque perso de la liste "persos" un par un depuis le
; leader, accepte l'invitation sur la fenêtre correspondante, puis
; clique sur un point fixe (ex : bouton "groupe") sur chaque fenêtre.
; ---------------------------------------------------------------
RunGrouper:

    if (!scriptEnabled || groupGrouper || groupFollow || groupImage || groupEndFight || groupClickImage || groupWheel)
        return

    groupGrouper := true

    ; Les personnages sont détectés automatiquement d'après le titre des fenêtres Dofus
    ; ("Nom-[Serveur] - Dofus Retro ..."). Le chef (Malyna) est en premier de la liste.
    chars := GetDofusChars()
    WinGet, leader, ID, %mainWindow%

    ; Invités = tous les personnages sauf le chef, dans l'ordre du tableau "Personnages..."
    invitees := []
    leaderFound := false

    for gi, gc in chars
    {
        if (leader && (gc.id + 0) = (leader + 0))
            leaderFound := true
        else
            invitees.Push(gc)
    }

    if (!leader || !leaderFound || invitees.Length() < 1)
    {
        JoinLog("Grouper : abandon (" chars.Length() " personnage(s) detecte(s), Malyna introuvable ou sans nom lisible)")
        groupGrouper := false
        return
    }

    ; ----- Invitations -----
    Loop % invitees.Length()
    {
        name := invitees[A_Index].name
        target := invitees[A_Index].id

        JoinLog("Grouper : invitation de " name)

        ActivateIfNeeded(leader)
        Sleep, 300

        Send, {Enter}
        Sleep, 100
        SendInput, /invite %name%
        Sleep, 100
        Send, {Enter}

        Sleep, 700

        ActivateIfNeeded(target)
        Sleep, 300

        Send, {Enter}
        Sleep, 500
    }

    ; ----- Clic sur chaque fenêtre Dofus -----
    grouperClickX := 2195
    grouperClickY := 160

    Loop % chars.Length()
    {
        current := chars[A_Index].id

        ActivateIfNeeded(current)
        Sleep, 100

        Click, %grouperClickX%, %grouperClickY%
        Sleep, 100
    }

    ; ----- Retour au leader -----
    ActivateIfNeeded(leader)

    groupGrouper := false

return


; #############################################################
; #  SECTION 16 : MODULE - MONSTRES (détection des Gelées par couleur + clic)
; #############################################################
; Principe : on cherche à l'écran (zone de la carte de Malyna) des amas de pixels de la
; couleur prélevée. Un amas = au moins "monsterMin" pixels proches de la couleur dans une
; zone de "monsterBox" px. Le script fait alors un clic DROIT au centre de l'amas ; le join des mules
; existant (CheckClickImage) prend ensuite le relais. Pendant un combat, plus aucun clic.

ToggleMonsters:
    MonToggle()
return

OpenMonsters:
    MonOpen()
return

MonsterTick:
    MonsterTickFn()
return

; Équivalent du raccourci ~RButton (section 10) : démarre la séquence placement / ready.
MonsterStartPlacement:
    if (!scriptEnabled || groupFollow || groupEndFight || groupClickImage)
        return

    ; Une séquence placement/ready est déjà en cours.
    if (waitingReady)
        return

    waitingReady := true
    readySequenceStart := A_TickCount

    ; Si Switch est en train de changer de fenêtre, on attend sa fin via un timer.
    if (groupImage)
    {
        SetTimer, StartPlacementSequence, 20
        return
    }

    Gosub, StartPlacementSequence
return

MonPick:
    MonPickSlot(SubStr(A_GuiControl, 8))     ; "MonPick2" -> 2
return

MonZone:
    MonStartZone()
return

MonZoneDefault:
    monsterZoneSet := false
    GuiControl, Mon:, MonZoneTxt, % MonZoneText()
return

MonSave:
    MonApplyGui()
    MonSaveIni()
    ToolTip, Monstres : réglages enregistrés
    SetTimer, RemoveToolTip, -1500
return

MonTest:
    MonApplyGui()
    MonRunTest()
return

MonClearTips:
    Loop, 20
        ToolTip,,,, %A_Index%
return

MonCaptureCancel:
    if (monsterCaptureMode != "")
    {
        monsterCaptureMode := ""
        ToolTip
    }
return

MonGuiClose:
MonGuiEscape:
    monsterCaptureMode := ""
    monGuiOpen := false
    ToolTip
    Gui, Mon:Destroy
return

; F7 : capture (couleur sous la souris ou coin de zone) - uniquement quand une capture est en attente
#If (monsterCaptureMode != "")
F7::
    MonCaptureNow()
return
#If

MonToggle()
{
    global monstersEnabled, monsterSlots, monsterBlockUntil, monsterInterval
    global fightStartTick, monsterSeenFightTick, monsterInFight

    if (!monstersEnabled)
    {
        ok := false
        for i, s in monsterSlots
        {
            if (s.on && s.rgb >= 0)
                ok := true
        }

        if (!ok)
        {
            ToolTip, Monstres : prélève d'abord une couleur (bouton « Monstres… »)
            SetTimer, RemoveToolTip, -3000
            return
        }

        monsterBlockUntil := 0
        monsterInFight := false
        monsterSeenFightTick := fightStartTick
        monstersEnabled := true
        SetTimer, MonsterTick, %monsterInterval%
    }
    else
    {
        monstersEnabled := false
        SetTimer, MonsterTick, Off
    }

    RefreshGui()
}

; ---------------------------------------------------------------
; Boucle automatique : cherche une Gelée et clique dessus (hors combat)
; ---------------------------------------------------------------
MonsterTickFn()
{
    global scriptEnabled, monstersEnabled, mainWindow
    global groupFollow, groupImage, groupClickImage, groupEndFight, groupWheel, groupGrouper, groupPierres, groupPassTurn, groupMonster, waitingReady
    global fightStartTick, monsterSeenFightTick, monsterInFight, monsterFightStart, monsterFightMax
    global monsterBlockUntil, monsterCooldown, monsterLastX, monsterLastY, monsterLastTick, monsterBox
    global followX, followY

    if (!scriptEnabled || !monstersEnabled || groupMonster)
        return

    if (groupFollow || groupImage || groupClickImage || groupEndFight || groupWheel || groupGrouper || groupPierres || groupPassTurn || waitingReady)
        return

    ; Un combat vient de démarrer (join des mules lancé) : on attend sa fin.
    if (fightStartTick != monsterSeenFightTick)
    {
        monsterSeenFightTick := fightStartTick
        monsterInFight := true
        monsterFightStart := A_TickCount
        monsterLastTick := 0
    }

    if (monsterInFight)
    {
        if (A_TickCount - monsterFightStart < monsterFightMax * 1000)
            return
        monsterInFight := false      ; sécurité : fin de combat jamais vue
    }

    if (A_TickCount < monsterBlockUntil)
        return

    groupMonster := true

    clusters := MonsterScan()

    best := ""
    for i, c in clusters
    {
        ; on ne reclique pas au même endroit si le dernier clic n'a pas lancé de combat
        if (A_TickCount - monsterLastTick < 120000 && Abs(c.x - monsterLastX) < monsterBox && Abs(c.y - monsterLastY) < monsterBox)
            continue
        if (best = "" || c.n > best.n)
            best := c
    }

    if (best = "")
    {
        groupMonster := false
        return
    }

    ; La recherche a pris un peu de temps : on revérifie qu'aucune autre routine n'a démarré.
    if (groupFollow || groupImage || groupClickImage || groupEndFight || groupWheel || groupGrouper || groupPierres || groupPassTurn || waitingReady || fightStartTick != monsterSeenFightTick)
    {
        groupMonster := false
        return
    }

    WinGet, mtMain, ID, %mainWindow%

    if (!mtMain || !ActivateIfNeeded(mtMain))
    {
        groupMonster := false
        return
    }

    tx := best.x
    ty := best.y

    Sleep, 60
    MouseMove, %tx%, %ty%, 0
    Sleep, 60
    Click, Right

    ; Un clic envoyé par le script ne déclenche pas le raccourci ~RButton (clic droit réel) :
    ; on lance donc nous-mêmes la même séquence (placement, puis ready.png, puis join des mules).
    followX := tx
    followY := ty
    SetTimer, MonsterStartPlacement, -50

    monsterLastX := tx
    monsterLastY := ty
    monsterLastTick := A_TickCount
    monsterBlockUntil := A_TickCount + monsterCooldown

    JoinLog("Monstres : clic droit sur " best.name " en " tx "/" ty " (" best.n " px)")

    groupMonster := false
}

; ---------------------------------------------------------------
; Cherche les amas de couleur dans la zone. Renvoie une liste de {name, x, y, n}.
; PixelSearch (rapide, natif) trouve un candidat ; MonsterCluster compte les pixels autour.
; ---------------------------------------------------------------
MonsterScan()
{
    global monsterSlots, monsterTol, monsterMin, monsterBox

    out := []

    if (!PlcWindowRect(wx, wy, ww, wh))
        return out

    MonsterZone(wx, wy, ww, wh, zx1, zy1, zx2, zy2)

    for si, sl in monsterSlots
    {
        if (!sl.on || sl.rgb < 0)
            continue

        col := sl.rgb
        stack := [[zx1, zy1, zx2, zy2]]
        iter := 0
        found := 0

        while (stack.Length() > 0 && iter < 25 && found < 8)
        {
            r := stack.Pop()
            iter++

            rx1 := r[1]
            ry1 := r[2]
            rx2 := r[3]
            ry2 := r[4]

            PixelSearch, px, py, %rx1%, %ry1%, %rx2%, %ry2%, %col%, %monsterTol%, Fast RGB

            if (ErrorLevel != 0)
                continue

            n := 0
            mx := px
            my := py
            MonsterCluster(px, py, col, n, mx, my)

            if (n >= monsterMin)
            {
                dup := false
                for oi, oc in out
                {
                    if (oc.slot = si && Abs(oc.x - mx) < monsterBox && Abs(oc.y - my) < monsterBox)
                        dup := true
                }

                if (!dup)
                {
                    out.Push({slot: si, name: sl.name, x: mx, y: my, n: n})
                    found++
                }
            }

            ; Zones restant à fouiller (PixelSearch lit ligne par ligne : tout ce qui est
            ; au-dessus de py et à gauche de px sur cette ligne est déjà vide).
            ex1 := Max(rx1, px - monsterBox // 2)
            ex2 := Min(rx2, px + monsterBox // 2)
            ey2 := Min(ry2, py + monsterBox)

            if (ex1 > rx1)
                stack.Push([rx1, py, ex1 - 1, ey2])
            if (ex2 < rx2)
                stack.Push([ex2 + 1, py, rx2, ey2])
            if (ey2 < ry2)
                stack.Push([rx1, ey2 + 1, rx2, ry2])
        }
    }

    return out
}

; Compte les pixels proches de la couleur dans une zone autour de (px, py) (1 pixel sur 2,
; résultat ramené à une estimation en pixels) et renvoie leur centre. Deux passes : la 2e
; est centrée sur le résultat de la 1re pour mieux viser le milieu de la Gelée.
MonsterCluster(px, py, rgb, ByRef n, ByRef mx, ByRef my)
{
    global monsterTol, monsterBox, monsterMin

    box := monsterBox
    half := box // 2
    rr := (rgb >> 16) & 255
    gg := (rgb >> 8) & 255
    bb := rgb & 255
    tol := monsterTol
    gx := px - half
    gy := py - 2

    Loop, 2
    {
        pass := A_Index
        cnt := 0
        sx := 0
        sy := 0

        if (!MonsterGrab(gx, gy, box, box, buf))
            return

        yy := 0
        while (yy < box)
        {
            xx := 0
            while (xx < box)
            {
                c := NumGet(buf, (yy * box + xx) * 4, "UInt")

                if (Abs(((c >> 16) & 255) - rr) <= tol && Abs(((c >> 8) & 255) - gg) <= tol && Abs((c & 255) - bb) <= tol)
                {
                    cnt++
                    sx += xx
                    sy += yy
                }

                xx += 2
            }
            yy += 2
        }

        n := cnt * 4

        if (cnt < 1)
            return

        mx := gx + sx // cnt
        my := gy + sy // cnt

        if (n < monsterMin)
            return

        gx := mx - half
        gy := my - half
    }
}

; Copie une zone de l'écran dans un tampon (32 bits, ligne du haut en premier).
MonsterGrab(x, y, w, h, ByRef buf)
{
    hdcScr := DllCall("GetDC", "Ptr", 0, "Ptr")
    hdc := DllCall("CreateCompatibleDC", "Ptr", hdcScr, "Ptr")
    hbm := DllCall("CreateCompatibleBitmap", "Ptr", hdcScr, "Int", w, "Int", h, "Ptr")
    obm := DllCall("SelectObject", "Ptr", hdc, "Ptr", hbm, "Ptr")
    DllCall("BitBlt", "Ptr", hdc, "Int", 0, "Int", 0, "Int", w, "Int", h, "Ptr", hdcScr, "Int", x, "Int", y, "UInt", 0x00CC0020)

    VarSetCapacity(bi, 40, 0)
    NumPut(40, bi, 0, "UInt")
    NumPut(w, bi, 4, "Int")
    NumPut(-h, bi, 8, "Int")
    NumPut(1, bi, 12, "UShort")
    NumPut(32, bi, 14, "UShort")

    VarSetCapacity(buf, w * h * 4, 0)
    ok := DllCall("GetDIBits", "Ptr", hdc, "Ptr", hbm, "UInt", 0, "UInt", h, "Ptr", &buf, "Ptr", &bi, "UInt", 0)

    DllCall("SelectObject", "Ptr", hdc, "Ptr", obm)
    DllCall("DeleteObject", "Ptr", hbm)
    DllCall("DeleteDC", "Ptr", hdc)
    DllCall("ReleaseDC", "Ptr", 0, "Ptr", hdcScr)

    return ok
}

; Zone de recherche en coordonnées écran : personnalisée, sinon la carte sans la barre du bas.
MonsterZone(wx, wy, ww, wh, ByRef zx1, ByRef zy1, ByRef zx2, ByRef zy2)
{
    global monsterZoneSet, monsterZ

    if (monsterZoneSet)
    {
        zx1 := wx + monsterZ[1]
        zy1 := wy + monsterZ[2]
        zx2 := wx + monsterZ[3]
        zy2 := wy + monsterZ[4]
    }
    else
    {
        zx1 := wx + Round(ww * 0.02)
        zy1 := wy + Round(wh * 0.06)
        zx2 := wx + Round(ww * 0.98)
        zy2 := wy + Round(wh * 0.80)
    }
}

MonZoneText()
{
    global monsterZoneSet, monsterZ

    if (monsterZoneSet)
        return "Zone : x " monsterZ[1] " à " monsterZ[3] ", y " monsterZ[2] " à " monsterZ[4] "  (relative à la fenêtre)"

    return "Zone : par défaut (la carte, sans la barre du bas)"
}

; ---------------------------------------------------------------
; Fenêtre de réglages
; ---------------------------------------------------------------
MonOpen()
{
    global monsterSlots, monsterTol, monsterMin, monsterBox, monsterCooldown, monsterFightMax, monGuiOpen
    global MonOn1, MonOn2, MonOn3, MonTol, MonMin, MonBox, MonCool, MonFight, MonZoneTxt
    global MonSw1, MonSw2, MonSw3, MonHex1, MonHex2, MonHex3, MonPick1, MonPick2, MonPick3

    Gui, Mon:Destroy
    Gui, Mon:+AlwaysOnTop +ToolWindow
    Gui, Mon:Font, s9, Segoe UI

    Gui, Mon:Add, Text, xm w350, Pour chaque couleur : clique sur « Prélever », place la souris au milieu d'une Gelée dans le jeu, puis appuie sur F7.

    for si, sl in monsterSlots
    {
        chk := sl.on ? "Checked" : ""
        hexTxt := (sl.rgb >= 0) ? Format("0x{:06X}", sl.rgb) : "non définie"
        bgTxt := (sl.rgb >= 0) ? Format("{:06X}", sl.rgb) : "808080"

        Gui, Mon:Add, Checkbox, xm y+8 w70 h24 vMonOn%si% %chk%, % sl.name
        Gui, Mon:Add, Text, x+5 w44 h24 +0x200 +Border vMonSw%si% Background%bgTxt%
        Gui, Mon:Add, Text, x+5 w90 h24 +0x200 vMonHex%si%, %hexTxt%
        Gui, Mon:Add, Button, x+5 w100 h24 gMonPick vMonPick%si%, Prélever
    }

    Gui, Mon:Add, Text, xm y+16 w250 h22 +0x200, Tolérance de couleur (0-255)
    Gui, Mon:Add, Edit, x+5 w70 vMonTol, %monsterTol%
    Gui, Mon:Add, Text, xm w250 h22 +0x200, Pixels minimum par Gelée
    Gui, Mon:Add, Edit, x+5 w70 vMonMin, %monsterMin%
    Gui, Mon:Add, Text, xm w250 h22 +0x200, Taille d'analyse (px, taille d'une Gelée)
    Gui, Mon:Add, Edit, x+5 w70 vMonBox, %monsterBox%
    Gui, Mon:Add, Text, xm w250 h22 +0x200, Pause après un clic (ms)
    Gui, Mon:Add, Edit, x+5 w70 vMonCool, %monsterCooldown%
    Gui, Mon:Add, Text, xm w250 h22 +0x200, Reprise auto si fin de combat non vue (s)
    Gui, Mon:Add, Edit, x+5 w70 vMonFight, %monsterFightMax%

    zt := MonZoneText()
    Gui, Mon:Add, Text, xm y+14 w350 vMonZoneTxt, %zt%
    Gui, Mon:Add, Button, xm w170 gMonZone, Définir la zone (2 × F7)
    Gui, Mon:Add, Button, x+5 w170 gMonZoneDefault, Zone par défaut

    Gui, Mon:Add, Button, xm y+14 w170 h28 gMonTest, Tester (sans cliquer)
    Gui, Mon:Add, Button, x+5 w170 h28 gMonSave, Enregistrer

    Gui, Mon:Add, Text, xm y+10 w350, Le test affiche une infobulle sur chaque Gelée détectée pendant quelques secondes.

    monGuiOpen := true
    Gui, Mon:Show,, Monstres
}

; Reprend les valeurs de la fenêtre dans les variables du script
MonApplyGui()
{
    global monsterSlots, monsterTol, monsterMin, monsterBox, monsterCooldown, monsterFightMax, monGuiOpen
    global MonOn1, MonOn2, MonOn3, MonTol, MonMin, MonBox, MonCool, MonFight

    if (!monGuiOpen)
        return

    Gui, Mon:Submit, NoHide

    monsterSlots[1].on := MonOn1 ? true : false
    monsterSlots[2].on := MonOn2 ? true : false
    monsterSlots[3].on := MonOn3 ? true : false

    monsterTol      := Min(255, Max(0, MonTol + 0))
    monsterMin      := Max(1, MonMin + 0)
    monsterBox      := Min(200, Max(30, MonBox + 0))
    monsterCooldown := Max(1000, MonCool + 0)
    monsterFightMax := Max(10, MonFight + 0)
}

MonSaveIni()
{
    global monsterSlots, monsterTol, monsterMin, monsterBox, monsterCooldown, monsterFightMax
    global monsterZoneSet, monsterZ, IniFile

    for si, sl in monsterSlots
    {
        IniWrite, % (sl.on ? 1 : 0), %IniFile%, Monstres, On%si%
        colTxt := (sl.rgb >= 0) ? Format("0x{:06X}", sl.rgb) : "-1"
        IniWrite, %colTxt%, %IniFile%, Monstres, Color%si%
    }

    IniWrite, %monsterTol%, %IniFile%, Monstres, Tol
    IniWrite, %monsterMin%, %IniFile%, Monstres, Min
    IniWrite, %monsterBox%, %IniFile%, Monstres, Box
    IniWrite, %monsterCooldown%, %IniFile%, Monstres, Cooldown
    IniWrite, %monsterFightMax%, %IniFile%, Monstres, FightMax
    IniWrite, % (monsterZoneSet ? 1 : 0), %IniFile%, Monstres, ZoneSet
    IniWrite, % monsterZ[1], %IniFile%, Monstres, ZX1
    IniWrite, % monsterZ[2], %IniFile%, Monstres, ZY1
    IniWrite, % monsterZ[3], %IniFile%, Monstres, ZX2
    IniWrite, % monsterZ[4], %IniFile%, Monstres, ZY2
}

MonstersLoad()
{
    global monsterSlots, monsterTol, monsterMin, monsterBox, monsterCooldown, monsterFightMax
    global monsterZoneSet, monsterZ, IniFile

    for si, sl in monsterSlots
    {
        IniRead, v, %IniFile%, Monstres, On%si%, 1
        sl.on := (v = 1)
        IniRead, v, %IniFile%, Monstres, Color%si%, -1
        sl.rgb := v + 0
    }

    IniRead, v, %IniFile%, Monstres, Tol, %monsterTol%
    monsterTol := v + 0
    IniRead, v, %IniFile%, Monstres, Min, %monsterMin%
    monsterMin := v + 0
    IniRead, v, %IniFile%, Monstres, Box, %monsterBox%
    monsterBox := v + 0
    IniRead, v, %IniFile%, Monstres, Cooldown, %monsterCooldown%
    monsterCooldown := v + 0
    IniRead, v, %IniFile%, Monstres, FightMax, %monsterFightMax%
    monsterFightMax := v + 0

    IniRead, v, %IniFile%, Monstres, ZoneSet, 0
    monsterZoneSet := (v = 1)
    IniRead, v, %IniFile%, Monstres, ZX1, 0
    monsterZ[1] := v + 0
    IniRead, v, %IniFile%, Monstres, ZY1, 0
    monsterZ[2] := v + 0
    IniRead, v, %IniFile%, Monstres, ZX2, 0
    monsterZ[3] := v + 0
    IniRead, v, %IniFile%, Monstres, ZY2, 0
    monsterZ[4] := v + 0
}

; ---------------------------------------------------------------
; Captures (touche F7)
; ---------------------------------------------------------------
MonPickSlot(n)
{
    global monsterCaptureMode, monsterCaptureSlot, monsterSlots

    monsterCaptureMode := "color"
    monsterCaptureSlot := n
    nm := monsterSlots[n].name
    ToolTip, Gelée %nm% : place la souris au milieu de la Gelée dans le jeu puis appuie sur F7
    SetTimer, MonCaptureCancel, -30000
}

MonStartZone()
{
    global monsterCaptureMode

    monsterCaptureMode := "zone1"
    ToolTip, Zone : place la souris sur le coin HAUT-GAUCHE de la zone puis appuie sur F7
    SetTimer, MonCaptureCancel, -30000
}

MonCaptureNow()
{
    global monsterCaptureMode, monsterCaptureSlot, monsterSlots, monsterZ, monsterZoneSet, monsterZoneTmpX, monsterZoneTmpY
    global MonSw1, MonSw2, MonSw3, MonHex1, MonHex2, MonHex3, MonZoneTxt

    MouseGetPos, mkX, mkY

    if (monsterCaptureMode = "color")
    {
        ; moyenne d'un petit carré 7 x 7 autour de la souris (un seul pixel est trop bruité)
        if (!MonsterGrab(mkX - 3, mkY - 3, 7, 7, mkBuf))
            return

        sr := 0
        sg := 0
        sb := 0
        Loop, 49
        {
            c := NumGet(mkBuf, (A_Index - 1) * 4, "UInt")
            sr += (c >> 16) & 255
            sg += (c >> 8) & 255
            sb += c & 255
        }

        rgb := ((sr // 49) << 16) | ((sg // 49) << 8) | (sb // 49)
        n := monsterCaptureSlot
        monsterSlots[n].rgb := rgb

        hexTxt := Format("0x{:06X}", rgb)
        bgTxt := Format("{:06X}", rgb)
        GuiControl, Mon:, MonHex%n%, %hexTxt%
        GuiControl, Mon:+Background%bgTxt%, MonSw%n%
        GuiControl, Mon:, MonSw%n%

        monsterCaptureMode := ""
        ToolTip, Couleur prélevée : %hexTxt%  (pense à cliquer sur Enregistrer)
        SetTimer, RemoveToolTip, -2500
        return
    }

    if (!PlcWindowRect(wx, wy, ww, wh))
    {
        ToolTip, Zone : fenêtre Malyna introuvable ou réduite
        SetTimer, RemoveToolTip, -2500
        return
    }

    if (monsterCaptureMode = "zone1")
    {
        monsterZoneTmpX := mkX
        monsterZoneTmpY := mkY
        monsterCaptureMode := "zone2"
        ToolTip, Zone : maintenant le coin BAS-DROIT puis F7
        return
    }

    if (monsterCaptureMode = "zone2")
    {
        monsterZ[1] := Min(monsterZoneTmpX, mkX) - wx
        monsterZ[2] := Min(monsterZoneTmpY, mkY) - wy
        monsterZ[3] := Max(monsterZoneTmpX, mkX) - wx
        monsterZ[4] := Max(monsterZoneTmpY, mkY) - wy
        monsterZoneSet := true
        monsterCaptureMode := ""

        zt := MonZoneText()
        GuiControl, Mon:, MonZoneTxt, %zt%
        ToolTip, Zone enregistrée (pense à cliquer sur Enregistrer)
        SetTimer, RemoveToolTip, -2500
    }
}

; ---------------------------------------------------------------
; Test : cherche une fois et affiche une infobulle sur chaque Gelée trouvée (aucun clic)
; ---------------------------------------------------------------
MonRunTest()
{
    global monsterSlots

    if (!PlcWindowRect(wx, wy, ww, wh))
    {
        ToolTip, Test : fenêtre Malyna introuvable ou réduite
        SetTimer, RemoveToolTip, -2500
        return
    }

    ; Les infobulles positionnées doivent l'être en coordonnées ÉCRAN (par défaut : relatives à la fenêtre active)
    CoordMode, ToolTip, Screen

    Loop, 20
        ToolTip,,,, %A_Index%

    cl := MonsterScan()

    counts := {}
    for i, c in cl
    {
        counts[c.name] := (counts[c.name] ? counts[c.name] : 0) + 1

        if (i <= 18)
        {
            tipTxt := c.name " (" c.n " px)"
            tipN := i + 1
            ToolTip, %tipTxt%, % c.x, % c.y, %tipN%
        }
    }

    summary := "Test : "
    for si, sl in monsterSlots
    {
        if (!sl.on || sl.rgb < 0)
            continue
        v := counts[sl.name] ? counts[sl.name] : 0
        summary .= sl.name " " v "   "
    }

    sx := wx + 20
    sy := wy + 20
    ToolTip, %summary%, %sx%, %sy%, 1
    SetTimer, MonClearTips, -6000
}


; #############################################################
; #  SECTION 17 : MODULE - REPOSITIONNEMENT (clic gauche après la fin de combat)
; #############################################################
; Après l'Échap de fin de combat envoyé sur Malyna (et après les Pierres), le script fait un clic gauche
; à la position enregistrée dans "Placement..." (relative à la fenêtre Malyna). Un clic envoyé par le
; script ne déclenche pas le raccourci ~RButton : aucune séquence de placement n'est lancée.

ToggleReposition:
    if (!repositionEnabled && (repositionX < 0 || repositionY < 0))
    {
        ToolTip, Repositionnement : enregistre d'abord la position dans « Placement… »
        SetTimer, RemoveToolTip, -3000
        return
    }

    repositionEnabled := !repositionEnabled
    RefreshGui()
return

; Capture : place la souris sur la position puis appuie sur la touche de capture (même touche que Placement)
PlcRepoCapture:
    ToolTip, Repositionnement : place la souris sur la position du clic gauche`nPuis appuie sur %placementCaptureKey% (Échap = annuler)

    rcStart := A_TickCount
    rcOk := false

    Loop
    {
        if (GetKeyState("Escape", "P") || A_TickCount - rcStart > 30000)
            break

        if (GetKeyState(placementCaptureKey, "P"))
        {
            MouseGetPos, rcX, rcY
            rcOk := true
            break
        }

        Sleep, 15
    }

    ToolTip

    if (rcOk)
    {
        if (!PlcWindowRect(rcWX, rcWY, rcWW, rcWH))
        {
            rcOk := false
            ToolTip, Capture annulée : fenêtre Malyna introuvable
            SetTimer, RemoveToolTip, -2000
        }
        else
        {
            rcX := rcX - rcWX
            rcY := rcY - rcWY

            if (rcX < 0 || rcY < 0 || rcX >= rcWW || rcY >= rcWH)
            {
                rcOk := false
                ToolTip, Capture annulée : le point est hors de la fenêtre Malyna
                SetTimer, RemoveToolTip, -2000
            }
        }
    }

    if (rcOk)
    {
        GuiControl, Plc:, PlcRepoX, %rcX%
        GuiControl, Plc:, PlcRepoY, %rcY%
        KeyWait, %placementCaptureKey%
    }
return

; Test : enregistre puis fait le clic gauche tout de suite
PlcRepoTest:
    Gosub, PlcSave

    if (!RepositionClick())
    {
        ToolTip, Repositionnement : position non définie ou fenêtre Malyna introuvable
        SetTimer, RemoveToolTip, -2500
    }
return

; ---------------------------------------------------------------
; Appelé juste après l'Échap de fin de combat sur Malyna (et après les Pierres).
; ---------------------------------------------------------------
RepositionRun()
{
    global scriptEnabled, repositionEnabled, repositionX, repositionY, repositionAfterDelay, repositionWalkDelay
    global mainWindow, endFightImage, monsterBlockUntil

    if (!scriptEnabled || !repositionEnabled || repositionX < 0 || repositionY < 0)
        return

    ; On laisse le panneau de fin de combat se fermer.
    Sleep, %repositionAfterDelay%

    if (!PlcWindowRect(rpX, rpY, rpW, rpH))
        return

    ; Le panneau doit être fermé : sinon le clic tomberait dessus.
    rpX2 := rpX + rpW
    rpY2 := rpY + rpH
    ImageSearch, rpFX, rpFY, %rpX%, %rpY%, %rpX2%, %rpY2%, *20 %endFightImage%

    if (ErrorLevel = 0)
    {
        JoinLog("Repositionnement : panneau de fin de combat encore affiche, abandon")
        return
    }

    if (RepositionClick())
        monsterBlockUntil := Max(monsterBlockUntil, A_TickCount + repositionWalkDelay)   ; laisse le personnage marcher
}

; Clic gauche à la position enregistrée (relative à Malyna). Renvoie false si impossible.
RepositionClick()
{
    global repositionX, repositionY, mainWindow

    if (repositionX < 0 || repositionY < 0)
        return false

    if (!PlcWindowRect(rpX, rpY, rpW, rpH))
        return false

    WinGet, rpMain, ID, %mainWindow%

    if (!rpMain || !ActivateIfNeeded(rpMain))
    {
        JoinLog("Repositionnement : fenetre Malyna impossible a activer")
        return false
    }

    tx := rpX + repositionX
    ty := rpY + repositionY

    Sleep, 40
    MouseMove, %tx%, %ty%, 0
    Sleep, 60
    Click
    Sleep, 40
    MouseMove, 1150, 500, 0  ; replace le curseur apres le clic de repositionnement

    JoinLog("Repositionnement : clic gauche en " tx "/" ty " (relatif " repositionX "/" repositionY "), curseur deplace en 1150/500")
    return true
}
