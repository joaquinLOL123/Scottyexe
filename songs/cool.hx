function centerCamera() {
    curCameraTarget = -1;
    var dadCamPos = dad.getCameraPosition();
    var bfCamPos = boyfriend.getCameraPosition();

    var midPoint:FlxPoint = FlxPoint.get((bfCamPos.x + dadCamPos.x) / 2, (bfCamPos.y + dadCamPos.y) / 2);
    camFollow.x = midPoint.x;
    camFollow.y = midPoint.y;
}