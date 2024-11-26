//
import ExtraCoolUtil;
import hxvlc.util.Handle;
import hxvlc.flixel.FlxVideo;
import funkin.backend.utils.WindowUtils;
import funkin.menus.TitleState;
import funkin.menus.MainMenuState;
import lime.app.Application;
import openfl.system.Capabilities;

public static var ExtraCoolUtil:ExtraCoolUtil = new ExtraCoolUtil(); //custom classes are a pain in the ass

var splashed:Bool = false;
var redirectStates:Map<FlxState, String> = [
    TitleState => "splashState",
	FreeplayState => "ScotMainMenu",
	MainMenuState => "ScotMainMenu"
]; // :^)

function new() {
	trace("start");

	Handle.initAsync([], function(isDone) {
		trace("finished hxvlc InitAsync: " + isDone);
	});

	WindowUtils.set_winTitle("SCOTTY.EXE");
	changeWinSize(960, 720);

	//init options
	if (FlxG.save.data.showSplash == null)
		FlxG.save.data.showSplash = true;
	if (FlxG.save.data.showCreds == null)
		FlxG.save.data.showCreds = false;
	if (FlxG.save.data.afterDeath == null)
		FlxG.save.data.afterDeath = false;
	if (FlxG.save.data.showReplay == null)
		FlxG.save.data.showReplay = true;

	if (!FlxG.save.data.showSplash) 
		redirectStates.set(TitleState, "ScotMainMenu");
}

public static function changeWinSize(width:Int, height:Int) {
	FlxG.width = width;
	FlxG.initialWidth = width;
	
	FlxG.initialHeight = FlxG.height = height;
	FlxG.initialHeight = height;

	window.resize(width, height);
	window.move(Capabilities.screenResolutionX / 2 - window.width / 2, Capabilities.screenResolutionY / 2 - window.height / 2);
}

function update(elapsed:Float)
	if (FlxG.keys.justPressed.F5) FlxG.resetState();

function preStateSwitch() {
    for (redirectState in redirectStates.keys())
        if (Std.isOfType(FlxG.game._requestedState, redirectState))
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

function destroy() {
	changeWinSize(1280, 720);
}