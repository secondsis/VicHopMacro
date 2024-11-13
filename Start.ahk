#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn VarUnset, Off
SetWorkingDir A_ScriptDir

KeyDelay := 40

SetKeyDelay KeyDelay

GetRobloxClientPos()
pToken := Gdip_Startup()
bitmaps := Map()
bitmaps.CaseSense := 0

CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"
SendMode "Event"

WKey := "sc011" ; w
AKey := "sc01e" ; a
SKey := "sc01f" ; s
Dkey := "sc020" ; d
RotLeft := "vkBC" ; ,
RotRight := "vkBE" ; .
RotUp := "sc149" ; PgUp
RotDown := "sc151" ; PgDn
ZoomIn := "sc017" ; i
ZoomOut := "sc018" ; o
Ekey := "sc012" ; e
Rkey := "sc013" ; r
Lkey := "sc026" ; l
EscKey := "sc001" ; Esc
EnterKey := "sc01c" ; Enter
SpaceKey := "sc039" ; Space
SlashKey := "sc035" ; /

#include %A_ScriptDir%\lib\

#Include FormData.ahk
#Include Gdip_All.ahk
#include Gdip_ImageSearch.ahk
#include json.ahk
#Include roblox.ahk

#include %A_ScriptDir%\scripts\

#Include functions.ahk
#Include gui.ahk
#include joinserver.ahk
#Include webhook.ahk

#Include ../messaging/client.ahk

#Include %A_ScriptDir%\images\bitmaps.ahk

global ServerAttempts := 1 ; used for joinserver function to Clear ServerIds()
global NightSearchAttempts := 0 ; just for the webhook timer nothing else prob could be merged into 1 var but ya

; Total Report Varaibles maybe used for the future idk
; global ServerJoinCounter := 0
; global NightServersCounter := 0
; global ViciousDeaftedCounter := 0
; global MacroTime := A_TickCount

MainLoop() {
    while (JoinServer() == 2) {
        HyperSleep(350)
    }
    if (NightDetection() == 1) {
        ; global NightServersCounter += 1
        ; global ServerJoinCounter += 1
        global ServerAttempts := 1
        global NightSearchAttempts := 0
        PlayerStatus("Night Detected!!", "0x000000", , false)
        ; send msg to main macro, send the server ID
        global RandomServer

        PlayerStatus(RandomServer, "0x11be22", , false, , false)
        sendServerCode(RandomServer)
        
        ;return to join more servers
    } else {
        global ServerAttempts += 1
        global NightSearchAttempts += 1

        PlayerStatus("Alt Searching For Night Servers. " NightSearchAttempts "x", "0x1ABC9C", , false, , false)
        return
    }
}

JoinServer() {
    loadroblox()
    global ServerAttempts
    if (Mod(ServerAttempts, 20) == 0) {
        global ServerAttempts := 1
        CloseRoblox()
        GetServerIds()
        HyperSleep(2000)
    } else {
        SetKeyDelay 250
        if GetRobloxClientPos()
            send "{esc}{l}{Enter}"
        global KeyDelay
        SetKeyDelay KeyDelay
        HyperSleep(2000)
    }
    if (GameLoaded()) {
        HyperSleep(850)
        return 1
    } else {
        return 2
    }
}

loadroblox() {
    joinrandomserver()
    loop 15 {
        if GetRobloxHWND() {
            ActivateRoblox()
            return
        }
        ; PlayerStatus("Detected Roblox Open", "0x00a838", ,false, ,false)    }
        if (A_Index = 15) {
            PlayerStatus("No Roblox Found", "0xc500ec", , false, , false)
            GetServerIds()
            return
        }
        Sleep 1000
    }
}