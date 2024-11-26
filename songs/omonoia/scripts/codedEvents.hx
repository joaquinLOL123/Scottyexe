//
import flixel.util.FlxTimer;
import funkin.backend.utils.WindowUtils;
import openfl.geom.ColorTransform;


function create() {
    playCutscenes = true;
}

function stepHit(curStep) {
    switch (curStep) {
        case 512:
            black.visible = true;
        case 640:
            black.visible = false; 

        case 1408:
            black.visible = true;
        case 1472:
            black.visible = false;
            healthDrain = true;
        case 1744:
            cpu.visible = false;
            for (strum in player.members)
                strum.x -= FlxG.width / 4;
            WindowUtils.set_winTitle("OMONOIA.");
        case 2385:
            WindowUtils.set_winTitle("familiar");
        case 2896:
            WindowUtils.set_winTitle("OMONOIA.");
        case 3152:
            black.visible = true;
            WindowUtils.set_winTitle("THE FINALE");

            new FlxTimer().start(0.01, function() {
                scotScene.play();
                scotScene.visible = true;
            });

            for (sprite in [iconP2A, iconP1, healthBar, healthBarBG, scoreTxt, accuracyTxt, missesTxt])      
                sprite.visible = false;
        case 3473:
            black.visible = false;
            stage.stageScript.get("basket").canSelect = true;
            scotScene.visible = false;
            camZooming = false;

            quickTimeTimer.start(quickTimeVals.time, function() {
                if (gotBasket) {
                    boyfriend.playAnim("attack", false, "LOCK");
                } else {
                    gameOver();
                }
            });

            quickTimeEvent.visible = true;
        case 3504:
            white.scrollFactor.set(0, 0);
            white.zoomFactor = 0;

            dad.playAnim("singLEFT", true, "LOCK");

            for (char in [dad, boyfriend])
                if (char.animateAtlas != null)
                    char.animateAtlas.colorTransform.color = 0x000000;
                else 
                    char.colorTransform.color = 0x000000;
            insert(members.indexOf(dad), white);

            sparkParticles.kill();
            remove(sparkParticles);
            remove(overlay);

            FlxG.camera.removeShader(heatWave);
        case 3708:
            black.visible = true;
            black.alpha = 0;
            FlxTween.tween(black, {alpha: 1}, ExtraCoolUtil.beatsToMS(64)); 
    }
}
