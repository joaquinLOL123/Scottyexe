//
function playAnim(event) {
    if (cutscene.curLine.changeDefAnim == "black") {
        event.animName = "normal";
        color = 0xff272727;
    } else {
        color = FlxColor.WHITE;
    }
}