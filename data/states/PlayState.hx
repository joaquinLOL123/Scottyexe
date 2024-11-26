//
public static var camVideo:FlxCamera;

function create() {
    camVideo = new FlxCamera();
    camVideo.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camVideo, false);
    FlxG.cameras.add(camHUD, false);
}