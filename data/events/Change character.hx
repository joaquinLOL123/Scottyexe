//
public var cachedChars:Map<String, Character> = [];





function create() {
    var events = SONG.events;
    for (event in events)
        if (event.name == "Change character" && !cachedChars.exists(event.params[0])) {
            var charPosName:String;
            var curStrumData = SONG.strumLines[event.params[2]];
            charPosName = getCharStagePos(curStrumData);

            var curStrumline = strumLines.members[event.params[2]];

            var char:Character = new Character(0, 0, event.params[0], stage.isCharFlipped(charPosName, curStrumData.type == 1));
            
            cachedChars.set(event.params[0], char);
        }
}

function onEvent(e) {
    var event = e.event;
    if (event.name == "Change character") {
        var charPosName:String;
        var curStrumData = SONG.strumLines[event.params[2]];
        charPosName = getCharStagePos(curStrumData);

        var char = cachedChars.get(event.params[0]);
        var oldChar = strumLines.members[event.params[2]].characters[event.params[3]];

        strumLines.members[event.params[2]].characters[event.params[3]] = char; 
        insert(members.indexOf(oldChar), char);
        remove(oldChar);

        char.setPosition(oldChar.x, oldChar.y);
    }

}

function getCharStagePos(strumData) {
    return strumData.position == null ? (switch(strumData.type) {
        case 0: "dad";
        case 1: "boyfriend";
        case 2: "girlfriend";
    }) : strumData.position;
}