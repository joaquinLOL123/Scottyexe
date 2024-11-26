//
var previousTween:FlxTween;
function onEvent(e) {
    var event = e.event;

    var camZoom = defaultCamZoom;

    if (event.name == "Camera ease zoom") {

        if (previousTween != null) previousTween.cancel(); //SO I DONT HAVE TO DEAL WITH THE CAMERA FREAKING OUT ON PLAYTESTING

        if (event.params[1])
            camZoom += event.params[0];
        else
            camZoom = event.params[0];

        previousTween = FlxTween.num(defaultCamZoom, camZoom, ExtraCoolUtil.stepsToMS(event.params[2]), {ease: CoolUtil.flxeaseFromString(event.params[3], event.params[4])}, function(v:Float) FlxG.camera.zoom = defaultCamZoom = v);
    }
}