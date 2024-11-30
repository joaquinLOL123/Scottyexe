//
import openfl.display.BlendMode;
import Sys;

class ExtraCoolUtil extends flixel.FlxBasic {
    public function new() {
    } //does absolutely nothing, trust me.

    public static function getBlendModeFromString(blend:String):Null<BlendMode> {
        return Reflect.field(BlendMode, blend);
    }

    public static function stepsToMS(steps:Int):Float {
        return (Conductor.stepCrochet / 1000) * steps;
    }

    public static function beatsToMS(beats:Int):Float {
        return ((Conductor.stepCrochet / 1000) * beats) / 4;
    }

    public static function getUser():Null<String> {
        var env = Sys.environment();

        if (env.exists("USERNAME")) {
            return env["USERNAME"];
        } else if (env.exists("USER")) {
            return envs["USER"];
        }    
        
        return null;
    }
}