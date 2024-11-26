//
var jumpscare:FlxSprite;

function postCreate() {
    jumpscare = new FlxSprite().loadGraphic(Paths.image("dialogue/backgrounds/scary"));
    jumpscare.screenCenter();
    jumpscare.visible = false;

    add(jumpscare);
}

var line:Int = 0;
function postNext() {
    line++;

    if (line == 10) {
        dialogueBox.dialogueEnded = true;

        canProceed = false;
        dialogueBox.text.completeCallback = mrDieBitch;
    }
    trace("post next");
}

function mrDieBitch() {
    canProceed = true;
    next();
}

var canClose:Bool == false;
function close(event) {
    if (canClose) return;
    event.cancel();
    canProceed = false;

    jumpscare.visible = true;
    new FlxTimer().start(1, function() {
        FlxTween.tween(jumpscare, {alpha: 0}, 2);
    });

    for (sprite in [dialogueBox, dialogueBox.text]) {
        sprite.visible = false;
    }
    for (s=>char in charMap) {
        char.visible = false;
    }

    FlxG.sound.play(Paths.sound("dialogue/screamer"));   
    dialogueCamera.shake(0.02, 3);

    new FlxTimer().start(3, function() {
        canClose = true;
        canProceed = true;
        this.close();
    });

}

function update(elapsed) {
    dialogueCamera.updateShake(elapsed);
}
