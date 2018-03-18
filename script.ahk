#Persistent
#include udf.ahk


!1::
floodCommandInRadius("/pt" , 2000, 30) ; command, delay, radius
Return

!2::
sendCommandToNearPlayer("/pt", 8) ; command, radius  
Return



floodCommandInRadius(command, delay, radius) {
    local myPos :=  getCoordinates()
    for i, o in getStreamedInPlayersInfo() {
        local distanceToPlayer := getDist(myPos, o.POS)
        if (distanceToPlayer > radius)
            continue
        sendChat(command " " i)
        Sleep, %delay%
    }
}

getNearestPlayerID() {
    local myPos :=  getCoordinates()
    local minDistance := 2000000
    local nearestPlayerID := -1
    for i, o in getStreamedInPlayersInfo() {
        local distanceToPlayer := getDist(myPos, o.POS)
        if (distanceToPlayer < minDistance) {
            nearestPlayerID := i
            minDistance := distanceToPlayer            
        }

    }
    return nearestPlayerID
}

sendCommandToNearPlayer(command, radius) {
    local nearestPlayerID := getNearestPlayerID()
    if (nearestPlayerID == -1) {
        addChatMessage("Рядом не обнаружено игроков")
        return
    }

    local nearestPlayerPos := getPlayerPosById(nearestPlayerID)
    local distanceToPlayer := getDist(getCoordinates(), nearestPlayerPos)
    if (distanceToPlayer > radius)
        return
    sendChat(command " " nearestPlayerID)
}