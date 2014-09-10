var component;

function addBinding (from, toObj, toProp)
{
    var bindObj = Qt.createQmlObject("import QtQuick 2.0; Binding {value:"+from+"}", main)
    if (bindObj) {
        bindObj.target = toObj
        bindObj.property = toProp
    }
    else {
        console.log("error creating binding object")
        console.log(bindObj.errorString())
        return false
    }
    return true
}


function createBalloon(x, y, color) {
    // console.log( "Color:" + color)
    if (component == null)
        component = Qt.createComponent("Balloon.qml");

    // Note that if Block.qml was not a local file, component.status would be
    // Loading and we should wait for the component's statusChanged() signal to
    // know when the file is downloaded and ready before calling createObject().
    if (component.status === Component.Ready) {
        var dynamicObject = component.createObject(main);
        if (dynamicObject === null) {
            console.log("error creating block");
            console.log(component.errorString());
            return false;
        }

        var xx = main.width*Math.random();
        var xx1 = Math.floor(Math.min(xx, main.width-dynamicObject.width));

        dynamicObject.x = x;
        dynamicObject.y = y;
        dynamicObject.x1 = xx1;
        dynamicObject.y1 = 100 * Math.random();
        dynamicObject.speed = 2000
        dynamicObject.color = color;

        with(Math) {
            var tmp = floor(random() * 10 + 1)
            dynamicObject.surprise = (tmp===10);

//            print( "tmp=" + tmp + " " + dynamicObject.surprise);
        }
        // dynamicObject.rotation = main.rotateVal

//        console.log( "x: " + x + " y: " + y + " x1: " + dynamicObject.x1
//                    + " y1: " + dynamicObject.y1 );

        var bindObj = Qt.createQmlObject("import QtQuick 2.0; Binding {value: main.rotateVal}", main);

        if (bindObj) {
            bindObj.target = dynamicObject
            bindObj.property = "rotation"
        }
        else {
            console.log("error creating binding component") ;
            console.log(bindObj.errorString());
            return false;
        }

        // This should be set last
        dynamicObject.created = true;

        // addBinding( "scaleVal", dynamicObject, scale );

    } else {
        console.log("error loading block component");
        console.log(component.errorString());
        dynamicObject = null;
        return null;
    }

    return dynamicObject;
}

function playsound(surprise) {
    if ( surprise ) {
        clapPlayer.play();
    }
    else {
        player.play();
    }
}
