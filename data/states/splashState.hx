//
import funkin.backend.utils.DiscordUtil;
import funkin.menus.MainMenuState;
import hxvlc.flixel.FlxVideoSprite;
import funkin.backend.MusicBeatState;


final SCREEN_PADDING = 10;

var splashVideos = Paths.getFolderContent("videos/splash", false, false);
var video:FlxVideo = new FlxVideoSprite();
var waow:FunkinText;

function create() {
    MusicBeatState.skipTransIn = true;

    video.antialiasing = true;
    video.bitmap.onFormatSetup.add(function():Void {
        if (video.bitmap != null && video.bitmap.bitmapData != null) {
            final scale:Float = Math.min(FlxG.width / video.bitmap.bitmapData.width, FlxG.height / video.bitmap.bitmapData.height);

            video.setGraphicSize(video.bitmap.bitmapData.width * scale, video.bitmap.bitmapData.height * scale);
            video.updateHitbox();
            video.screenCenter();
        }
    });
    video.bitmap.onEndReached.add(function() {
        video.destroy();
        remove(video);
        FlxG.switchState(new ModState("scotMainMenu"));
        
    });

    var selectedVideo = splashVideos[FlxG.random.int(0, splashVideos.length - 1)];

    if (video.load(Assets.getPath(Paths.getPath('videos/splash/' + selectedVideo)))) {
        new FlxTimer().start(0.01, function() video.play());
    }

    add(video);

    waow = new FunkinText(0, 0, 0, "Click ACCEPT to skip.", 30);
    waow.x = (FlxG.width - waow.fieldWidth) - SCREEN_PADDING;
    waow.y = (FlxG.height - waow.fieldHeight) - SCREEN_PADDING;
    waow.borderSize = 2;
    add(waow);

    if (!FlxG.save.data.showSplash) {
        FlxG.switchState(new ModState("ScotMainMenu"));
    }
}

function update() {
    if(controls.ACCEPT) {
        video.bitmap.onEndReached.dispatch();
    }
}