//
import funkin.options.OptionsScreen;
import funkin.options.OptionsTree;
import funkin.options.type.PortraitOption;
import funkin.options.type.OptionType;
import funkin.options.type.TextOption;
import funkin.options.TreeMenu;
import funkin.editors.ui.UIState;

function create() {

    items.insert(0, new TextOption("Scotty credits >", "SCOTTY.EXE CREDITS.", function() {
        optionsTree.add(new OptionsScreen("Scotty credits", "SCOTTY.EXE CREDITS.",
            if (!FlxG.save.data.showCreds) {
                [new PortraitOption("ScottyFan", "everything.", function() CoolUtil.openURL("https://x.com/scottyfan117221"), FlxG.bitmap.add(Paths.image("credits/scottyfan")))];
            } else {
                [
                    new PortraitOption("Jikkenthe10th", "Coder, Artist, Musician, Animator", function() CoolUtil.openURL("https://x.com/jikkenthe10th"), FlxG.bitmap.add(Paths.image("credits/jikken")), 110, false),
                    new PortraitOption("GalaxyChan", "Idea suggestions, Owner of MR, Extra singing", function() CoolUtil.openURL("https://x.com/GoofballGals"), FlxG.bitmap.add(Paths.image("credits/galaxy")), 95, false)
                ];
            }
        ));
    }));

    main = new OptionsScreen('Credits', 'The people who made this possible!', items);
}