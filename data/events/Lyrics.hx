//
import flixel.text.FlxTextAlign;

var lyricsGroup:FlxSpriteGroup;

var prevText:FlxText;

function create() {
    lyricsGroup = new FlxSpriteGroup();
    lyricsGroup.cameras = [camHUD];

    add(lyricsGroup);

    for (event in SONG.events) {
        if (event.name == "Lyrics") {
            switch (event.params[2]) {
                case "New":
                    var txt = new FunkinText(0, 0, camHUD.width, event.params[0], 40);
                    txt.antialiasing = true;
                    txt.y = (FlxG.height - 75) + event.params[1];
                    txt.font = Paths.font("times new roman.ttf");
                    txt.alignment = FlxTextAlign.CENTER;
                    txt.visible = false;
                    lyricsGroup.add(txt);
                
            } 
        }
    }
}

var curTextNum = 0;
function onEvent(e) {
    var event = e.event;
    if (event.name == "Lyrics") {
        var curText = lyricsGroup.members[curTextNum];

        switch (event.params[2]){
            case "Add":
                prevText.text += event.params[0];
            case "Clear" | "New":
                if (prevText != null)
                    lyricsGroup.remove(prevText);
                

                if(event.params[2] == "New") {
                    curTextNum++;
                    curText.visible = true;
                    prevText = curText;
                }
        }
    }
}