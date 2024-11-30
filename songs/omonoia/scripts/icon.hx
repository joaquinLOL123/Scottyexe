//
public var scotIcon:FunkinSprite;
final ICON_OFFSET:FlxPoint = FlxPoint.get(0, -10);

function postCreate() {
    scotIcon = new FunkinSprite();
    scotIcon.cameras = [camHUD];
    scotIcon.frames = Paths.getSparrowAtlas("icons/scotty-animated");

    scotIcon.animation.addByPrefix("idle", "neutral", 24, false);
    scotIcon.animation.addByPrefix("losing", "losing", 24, false);
    scotIcon.addOffset("losing", -20, 20);

    scotIcon.playAnim("idle");

    scotIcon.y = healthBar.y - (scotIcon.height / 2) - ICON_OFFSET.y;
    scotIcon.antialiasing = true;
    insert(members.indexOf(iconP2), scotIcon);
    iconP2.visible = false;
}

function postUpdate() {
    var center:Float = healthBar.x + healthBar.width * FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0);
    scotIcon.x = center - (scotIcon.width - ICON_OFFSET.x);

    scotIcon.scale.set(lerp(scotIcon.scale.x, 1, 0.33), lerp(scotIcon.scale.y, 1, 0.33));
    scotIcon.updateHitbox();

    if (scotIcon.health <= 20 && scotIcon.health != null) {
        scotIcon.playAnim("losing");
    } else {
        scotIcon.playAnim("idle");
    }
    scotIcon.health = 100 - healthBar.percent;
}

function beatHit() {
    scotIcon.scale.set(1.2, 1.2);
    scotIcon.updateHitbox();
}