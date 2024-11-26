//
import flixel.text.FlxTextAlign;
import Xml;

var backgrounds:Map<String, FlxSprite> = [];
var backgroundMap:Map<Int, FlxSprite> = [];
var line:Int = 0;

function postCreate() {
    getBackgrounds();

    text.alignment = FlxTextAlign.CENTER;
    text.screenCenter(FlxAxes.X);
}

function playBubbleAnim() {
    line++;

    for (str=>bg in backgrounds) {
        if (bg == backgroundMap.get(line)) {
            bg.visible = true;
        } else {
            bg.visible = false;
        }
    }
}

function getBackgrounds() {
    var xml:Xml = Xml.parse(Assets.getText(cutscene.dialoguePath)).firstElement();
    var line:Int = 0;
    
    for(node in xml.elements()) {
        if (node.nodeName == "line") {
            line++;
            if (node.exists("background")) {
                var bg = node.get("background");
                var background:FlxSprite;

                if (backgrounds.exists(bg)) {
                    background = backgrounds.get(bg);
                } else {
                    background = new FlxSprite().loadGraphic(Paths.image("dialogue/backgrounds/" + bg));
                    background.screenCenter();
                    cutscene.insert(0, background);
                    backgrounds.set(bg, background);
                }
                backgroundMap.set(line, background);
            }
        }
    }
}