//
function onEvent(e) {
    var event = e.event;
    if (event.name == "Change default zoom") {
        if (previousZoomTween != null) previousZoomTween.cancel(); //bitch
        
        if (event.params[1])
            defaultCamZoom += event.params[0];
        else
            defaultCamZoom = event.params[0];
    }
}