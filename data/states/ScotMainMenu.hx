//

import funkin.editors.EditorPicker;
import funkin.menus.credits.CreditsMain;
import funkin.menus.ModSwitchMenu;
import funkin.options.OptionsMenu;
import openfl.Assets;
import StringTools;

var omonoia:MenuFrame;
var options:MenuFrame;
var credits:MenuFrame;

var title:FunkinText = new FunkinText(0, 30, 0, "Vs Scotty.", 60, true);

final MENU_SEPARATION:Int = 50;

function create() {
    if (FlxG.save.data.afterDeath == true) {
        replayMessage();
        FlxG.save.data.afterDeath = false;
    }

    CoolUtil.playMenuSong();

    FlxG.mouse.visible = true;

    add(title);
    title.font = Paths.font("times new roman.ttf");
    title.screenCenter(FlxAxes.X);

    omonoia = new MenuFrame(0, 0, null, function() {
        PlayState.loadSong("omonoia", "hard", false, false);
        FlxG.switchState(new PlayState());
    }).loadGraphic(Paths.image("menus/mainmenu/scotty/omonoia"));
    add(omonoia);
    omonoia.x = (FlxG.width / 2) - omonoia.width - MENU_SEPARATION;
    omonoia.antialiasing = true;

    options = new MenuFrame(0, 0, null, function() { 
        FlxG.switchState(new OptionsMenu());
    }).loadGraphic(Paths.image("menus/mainmenu/scotty/options"));
    add(options);
    options.x = FlxG.width / 2 + MENU_SEPARATION;
    options.antialiasing = true;

    for(item in [omonoia, options]) {
        item.y = (title.y + title.height) + 30;
    }

    credits = new MenuFrame(0, 0, null, function() { 
        FlxG.switchState(new CreditsMain());
    }).loadGraphic(Paths.image("menus/mainmenu/scotty/credits"));
    add(credits);
    credits.screenCenter(FlxAxes.X);
    credits.y = (options.y + options.height) + 30;
    credits.antialiasing = true;
}

function update() {
    if(controls.SWITCHMOD) {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }

    if (FlxG.keys.justPressed.SEVEN) {
        persistentUpdate = false;
		persistentDraw = true;
        openSubState(new EditorPicker());
    }
}

function replayMessage() {
    if (!FlxG.save.data.showReplay) return;
    var txtList = Assets.getText(Paths.txt("config/menuQuotes"));
    var textArray:Array<String>;
    textArray = txtList.split("\n");

    for (i in 0...textArray.length) {
        var text = textArray[i];
        text = StringTools.replace(text, "[USERNAME]", ExtraCoolUtil.getUser());
        textArray[i] = text;
    }

    var selection = textArray[FlxG.random.int(0, textArray.length-1)];

    if (StringTools.startsWith(selection, "URL=")) {
        selection = StringTools.replace(selection, "URL=", "");
        CoolUtil.openURL(selection);
    } else {
        window.alert(selection, "From Scotty.exe");
    } 
}

class MenuFrame extends flixel.FlxSprite {

    public var onClick:Void->Void;
    public var selected:Bool = false;

    public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:Null<FlxGraphicAsset>, ?onClick:Void->Void) {
        this.onClick = onClick;
    }

    public function update(elapsed:Float) {
        super.update(elapsed);
        if(FlxG.mouse.overlaps(this)) {

            if (FlxG.mouse.justPressed)
                onClick();
            
            scale.set(CoolUtil.fpsLerp(scale.x, 1.05, 0.5), CoolUtil.fpsLerp(scale.y, 1.05, 0.3));
            color = FlxColor.WHITE;

            if (!selected)
                FlxG.sound.play(Paths.sound("menu/scroll"));
            selected = true;

        } else {

            scale.set(CoolUtil.fpsLerp(scale.x, 1, 0.1), CoolUtil.fpsLerp(scale.y, 1, 0.1));
            color = FlxColor.GRAY;
            selected = false;

        }
    }

}