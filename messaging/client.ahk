#Requires AutoHotkey v2.0

/**
 * DEV NOTE: Implement networking and sockets instead of files in the future?
 */

; Sends server's code to a list in main
sendServerCode(code) {
    filePath := A_AppDataCommon "\vic_messaging\night_servers.txt"
    DirCreate StrReplace(filePath, "\night_servers.txt")
    FileAppend(code "`n", filePath)
}

; Example usage:
;sendServerCode("969h6o40g")
;sendServerCode("4956949cr5")