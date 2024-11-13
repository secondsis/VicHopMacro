#Requires AutoHotkey v2.0

#Include ../scripts/joinserver.ahk

; updates altNightServerIds global var
pullAltServers() {
    filePath := "C:\Users\Public\Documents\night_servers.txt"
    DirCreate StrReplace(filePath, "\night_servers.txt")
    msg := FileRead(filePath)
    servers := StrSplit(msg, "`n")
    if(servers[servers.Length] == "") {
        servers.RemoveAt(servers.Length)
    }

    global altNightServerIds := servers
}

; delete the first server in the txt file
deleteFirstAltServer() {
    filePath := "C:\Users\Public\Documents\night_servers.txt"
    file := FileOpen(filePath, "r")
    content := file.Read()
    file.Close()

    lines := StrSplit(content, "`n")
    lines.RemoveAt(lines.Length)

    if (lines.Length > 1) {
        newContent := StrReplace(content, lines[1] "`n")
    } else {
        newContent := ""
    }

    fileEdit := FileOpen(filePath, "w")
    fileEdit.Write(newContent)
    fileEdit.Close()
}