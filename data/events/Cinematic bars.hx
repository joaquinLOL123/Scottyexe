var topBar:FlxSprite;
var bottomBar:FlxSprite;

function create() {
    topBar = new FlxSprite().makeSolid(FlxG.width, 100, FlxColor.BLACK);
    topBar.y = 0 - topBar.height;
    insert(0, topBar);
    topBar.cameras = [camHUD];

    bottomBar = new FlxSprite().makeSolid(FlxG.width, 100, FlxColor.BLACK);
    bottomBar.y = FlxG.height;
    insert(0, bottomBar);
    bottomBar.cameras = [camHUD];
}

function onEvent(e) {
    var event = e.event;
    if (event.name == "Cinematic bars")  {
        var dur:Float = ExtraCoolUtil.stepsToMS(event.params[1]);
        if (event.params[0] == true) {
            FlxTween.tween(topBar, {y: 0}, dur, {ease: CoolUtil.flxeaseFromString(event.params[2], event.params[3])});
            FlxTween.tween(bottomBar, {y: FlxG.height - bottomBar.height}, dur, {ease: CoolUtil.flxeaseFromString(event.params[2], event.params[3])});
        } else {
            FlxTween.tween(topBar, {y: 0 - topBar.height}, dur, {ease: CoolUtil.flxeaseFromString(event.params[2], event.params[3])});
            FlxTween.tween(bottomBar, {y: FlxG.height}, dur, {ease: CoolUtil.flxeaseFromString(event.params[2], event.params[3])});
        }
    }
}