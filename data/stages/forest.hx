//
import flixel.effects.particles.FlxEmitterMode;
import flixel.effects.particles.FlxTypedEmitter;
import flixel.tweens.FlxTweenType;

public var overlay:FunkinSprite;
public var camCentered:Bool = false;
var isOmonoia:Bool = false;

public var forestSprites:Array<FlxSprite>;
public var omonoiaSprites:Array<FlxSprite>;

public var chromAberration:CustomShader;
public var heatWave:CustomShader;
public var sparkParticles:FlxTypedEmitter<FlxSprite>;

var basket:ClickableFlxSprite;
var islandGroup:FlxSpriteGroup = new FlxSpriteGroup();

final FLIPACLIP_TEXT_DIST:Int = 100;

final FLIPACLIP_CHARACTER_X = 100;
final FLIPACLIP_CHARACTER_Y = 20;

function repositionBasket() {
    basket.x = (boyfriend.x + boyfriend.width) - basket.width;
    basket.y = (boyfriend.y + boyfriend.height) + (basket.height);
}

function postCreate() {
    forestSprites = [sky, backdropL, backdropR, ground];
    omonoiaSprites = [skyScary, buildScary1, buildScary2, fireOverlay, fireScary, islandScary, fountainMain, fountainL, fountainR];

    basket = new ClickableFlxSprite().loadGraphic(Paths.image("game/basket"));
    repositionBasket();
    basket.onClick = function() {
        gotBasket = true;
        boyfriend.playAnim("pre-attack", true, "LOCK");
        remove(basket);

        for (spr in quickTimeEvent.members)
            FlxTween.tween(spr, {alpha: 0}, 0.1);
    }
    basket.canSelect = false;
    basket.antialiasing = true;

    insert(members.indexOf(boyfriend) + 1, basket);
    insert(members.indexOf(islandScary), islandGroup);

    sparkParticles = new FlxTypedEmitter(islandScary.x, 1500);
    sparkParticles.setSize(islandScary.width, 0);
    sparkParticles.launchMode = FlxEmitterMode.SQUARE;
    sparkParticles.velocity.set(20, -200, -20, -1000);
    sparkParticles.loadParticles(Paths.image("stages/omonoia/spark"), 100);
    sparkParticles.lifespan.set(5);
    sparkParticles.scale.set(1, 1, null, null, 0.2, 0.4, 0, 0);
    sparkParticles.color.set(FlxColor.WHITE, FlxColor.BLACK);
    sparkParticles.blend = ExtraCoolUtil.getBlendModeFromString("ADD");
    
    add(sparkParticles);

    overlay = new FunkinSprite().makeSolid(1280, 720, CoolUtil.getColorFromDynamic("0x685F9B"));
    overlay.scrollFactor.set(0, 0);
    overlay.zoomFactor = 0;
    overlay.blend = ExtraCoolUtil.getBlendModeFromString("MULTIPLY");
    add(overlay);

    if (!Options.gameplayShaders) return;
    chromAberration = new CustomShader("chromaticAberration");
    heatWave = new CustomShader("heatwave");
}

var time:Float = 0.0;
function update(elapsed) {
    time += elapsed;
    
    if (isOmonoia) {
        for (sprite in [islandGroup, boyfriend, dad, comboGroup, basket])
            sprite.y += (Math.sin(time * 2) / 4);

        if (basket.hovering)
            basket.color = FlxColor.GRAY;
        else
            basket.color = FlxColor.WHITE;

        if (!Options.gameplayShaders) return;
        if (chromAberration != null)
            if (chromIntensity > 0.0012)
                setChromIntensity(CoolUtil.fpsLerp(chromIntensity, 0.00005, 0.05));
        heatWave.hset("iTime", time);
    }   
}

function beatHit(curBeat) {
    if (isOmonoia) {
        if (curBeat % 2 == 0)
            setChromIntensity(0.005);
    }
}

function measureHit(curMeasure) {
    if (curMeasure % 2==0)
        toggleFountain();
}

function destroy() {
    FlxG.drawFramerate = FlxG.updateFramerate = Options.framerate;
}

function omonoiaOhioMode() {
    for (sprite in forestSprites)
        sprite.destroy();
    for (sprite in omonoiaSprites)
        sprite.visible = true;
    overlay.color = CoolUtil.getColorFromDynamic("0x472819");
    overlay.blend = ExtraCoolUtil.getBlendModeFromString("ADD");

    fireOverlay.blend = ExtraCoolUtil.getBlendModeFromString("ADD");

    boyfriend.setPosition(1020, 10);
    basket.x = (boyfriend.x + boyfriend.width) - basket.width;
    basket.y = (boyfriend.y + boyfriend.height) + (basket.height);

    comboGroup.x += 200;

    isOmonoia = true;

    for (sprite in [islandScary, fountainMain, fountainL, fountainR]) {
        remove(sprite);
        islandGroup.add(sprite);
    }

    initFountains();

    sparkParticles.start(false, 0.035, 0);

    if (!Options.gameplayShaders) return;

    setChromIntensity(0.0012);
    camGame.addShader(heatWave);
    camGame.addShader(chromAberration);
}

function flipClip() {
    dad.x += FLIPACLIP_CHARACTER_X;
    dad.y += FLIPACLIP_CHARACTER_Y;

    boyfriend.x -= FLIPACLIP_CHARACTER_X * 3;
    boyfriend.y = dad.y + 50;

    FlxG.drawFramerate = FlxG.updateFramerate = 30;

    flipaclipBG.visible = true;
    basket.visible = false;
    
    sparkParticles.kill();
    overlay.visible = false;
    isOmonoia = false;

    for (text in [accuracyTxt, missesTxt, scoreTxt]) {
        text.font = Paths.font("comic neue bold.ttf");
        text.borderColor = FlxColor.TRANSPARENT;
        text.color = FlxColor.BLACK;
        text.size += 10;
    }
    accuracyTxt.x -= FLIPACLIP_TEXT_DIST;
    scoreTxt.x += FLIPACLIP_TEXT_DIST;

    if (!Options.gameplayShaders) return;
    camGame.removeShader(heatWave);
    camGame.removeShader(chromAberration);
}

function backToOmonoia() {
    dad.x -= FLIPACLIP_CHARACTER_X;
    dad.y -= FLIPACLIP_CHARACTER_Y;

    boyfriend.x += FLIPACLIP_CHARACTER_X * 3;
    boyfriend.y = 10;

    FlxG.drawFramerate = FlxG.updateFramerate = Options.framerate;

    flipaclipBG.visible = false;
    basket.visible = true;

    sparkParticles.start(false, 0.035, 0);
    overlay.visible = true;
    isOmonoia = true;

    for (text in [accuracyTxt, missesTxt, scoreTxt]) {
        text.font = Paths.font("vcr.ttf");
        text.borderColor = FlxColor.BLACK;
        text.color = FlxColor.WHITE;
        text.size -= 10;
    }
    accuracyTxt.x += FLIPACLIP_TEXT_DIST;
    scoreTxt.x -= FLIPACLIP_TEXT_DIST;

    if (!Options.gameplayShaders) return;
    camGame.addShader(heatWave);
    camGame.addShader(chromAberration);
}

var chromIntensity:Float = 0;
function setChromIntensity(val:Float) {
    if (chromAberration != null) {
        chromAberration.redOff = [val, 0.0];
        chromAberration.blueOff = [-val, 0.0];
    }

    chromIntensity = val;
}

function toggleFountain() {
    for (fountain in [fountainMain, fountainL, fountainR]) {
        if (fountain.animation.curAnim.name == "idle")
            fountain.playAnim("close");
        else
            fountain.playAnim("open");
    }
}

function initFountains() {
    fountainMain.playAnim("idle");
    fountainL.playAnim("close");
    fountainR.playAnim("close");

    for (fountain in [fountainMain, fountainL, fountainR]) {
        fountain.animation.finishCallback = function(anim:String) {
            if (anim == "open")
                fountain.playAnim("idle");
        };
    }
}

class ClickableFlxSprite extends flixel.FlxSprite {
    public var hovering:Bool;
    public var onClick:Void->Void = function() {};
    public var canSelect:Bool = true;

    public function new(X:Float, Y:Float, ?SimpleGraphic:Null<FlxGraphicAsset>) {
        super(X, Y, SimpleGraphic);
    }

    override public function update(elapsed:Float) {
        super(elapsed);
        if (canSelect)
            if(FlxG.mouse.overlaps(this)) {
                hovering = true;
                if (FlxG.mouse.justPressed)
                    onClick();
            } else {
                hovering = false;
            }
        else
            hovering = false;
    }
}