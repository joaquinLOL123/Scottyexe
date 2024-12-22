import funkin.backend.utils.WindowUtils;
import hxvlc.flixel.FlxVideoSprite;
import flixel.ui.FlxBar;
import Sys;

public var black:FunkinSprite = new FunkinSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);

public var scotScene:FlxVideoSprite = new FlxVideoSprite(0, 0);
public var healthDrain:Bool = false;
public var gotBasket:Bool = false;

public var quickTimeEvent:FlxGroup = new FlxGroup();
public var quickTimeTimer:FlxTimer = new FlxTimer();

public var quickTimeBar:FlxBar; //mfw refactored flxpiedial isnt in codename's version of flixel :(
var quickTimeBarBG:FlxSprite;
public var quickTimeText:FunkinText;

public var quickTimeVals = { time: 2.2, timeLeft: 0 };

function create() {
    WindowUtils.set_winTitle("the forest..?");
    loadVideo();

    maxCamZoom = 2.5;
}

function postCreate() {
    add(black);
    black.visible = false;
    black.zoomFactor = 0;
    black.scrollFactor.set(0, 0);

    quickTimeBar = new FlxBar(0, 0, 0, 250, 12, quickTimeVals, "timeLeft", 0, quickTimeVals.time).createFilledBar(FlxColor.RED, FlxColor.LIME);
    quickTimeBar.cameras = [camHUD];
    quickTimeBar.screenCenter(FlxAxes.X);

    quickTimeText = new FunkinText(0, 200, 0, "Click on MR's basket!!", 50);
    quickTimeText.font = Paths.font("times new roman.ttf");
    quickTimeText.cameras = [camHUD];
    quickTimeText.screenCenter(FlxAxes.X);
    quickTimeText.antialiasing = true;
    quickTimeBar.y = (quickTimeText.y + quickTimeText.height);

    quickTimeBarBG = new FlxSprite().loadGraphic(Paths.image("game/healthBar"));
    quickTimeBarBG.setGraphicSize(258, 19);
    quickTimeBarBG.screenCenter(FlxAxes.X);
    quickTimeBarBG.y = quickTimeBar.y - 4;
    quickTimeBarBG.antialiasing = true;
    quickTimeBarBG.cameras = [camHUD];
    
    quickTimeEvent.add(quickTimeBarBG);
    quickTimeEvent.add(quickTimeBar);
    quickTimeEvent.add(quickTimeText);

    quickTimeEvent.visible = false;
    add(quickTimeEvent);
}

function update() {
    quickTimeVals.timeLeft = quickTimeTimer.timeLeft;
}

function onDadHit(event) {
    var note = event.note;

    if (healthDrain)
        if (health > 0.04)
            if (!note.isSustainNote)
                health -= 0.025;
            else
                health -= 0.015;
}

function onGamePause() {
    scotScene.pause(); 
}

function onSubstateClose() {
    if (paused)
        scotScene.resume(); 
}

function onFocus() {
    if (!paused)
        scotScene.resume();
}

function onSongEnd() {
    if (!FlxG.save.data.showCreds)
        FlxG.save.data.showCreds = true;
}

function onGameOver() {
    FlxG.save.data.afterDeath = true;
    window.close();
}

function destroy() {
    WindowUtils.set_winTitle("SCOTTY.EXE");
    FlxG.camera.bgColor = FlxColor.BLACK;
}

function loadVideo() {
    scotScene.antialiasing = true;

    scotScene.bitmap.onFormatSetup.add(function():Void {
        if (scotScene.bitmap != null && scotScene.bitmap.bitmapData != null) {
            final scale:Float = Math.min(FlxG.width / scotScene.bitmap.bitmapData.width, FlxG.height / scotScene.bitmap.bitmapData.height);

            scotScene.setGraphicSize(scotScene.bitmap.bitmapData.width * scale, scotScene.bitmap.bitmapData.height * scale);
            scotScene.updateHitbox();
            scotScene.screenCenter();
        }
    });

    scotScene.bitmap.onEndReached.add(function() {
        scotScene.bitmap.dispose();
        remove(scotScene);
    });

    scotScene.load(Assets.getPath(Paths.video("songs/scotty cutscene")));
    scotScene.cameras = [camHUD];
    insert(0, scotScene);
    
    if (FlxG.signals.focusGained.has(scotScene.resume))
        FlxG.signals.focusGained.remove(scotScene.resume);
    
}