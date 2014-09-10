import QtQuick 2.0
import Ubuntu.Components 0.1
import "components"
import "logic.js" as Logic

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.liu-xiao-guo.balloon"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    width: units.gu(67)
    height: units.gu(100)

    Page {
        id:main
        title: i18n.tr("Balloon")
        property int rotateVal: 0
        property int time: 2000

        Balloon {
            id: red
            x: main.width/2
            y: main.height - 60
            rotation: main.rotateVal
            color: "red"
            y1: main.height/3
            x1: 0
            speed: main.time/2
            created: true
            surprise: true
        }

        Balloon {
            id: blue
            x: main.width / 3 - 60
            y: main.height - 60
            color: "blue"
            rotation: main.rotateVal
            y1: main.height/3
            x1: main.width/2 + 20
            speed: main.time/2
            created: true
        }

        Balloon {
            id: green
            x: main.width*2/3
            y: main.height - 10
            rotation: main.rotateVal
            color: "green"
            y1: main.height/4
            x1: main.width/3 + 20
            speed: main.time/3
            created: true
            surprise: true
        }

        Button {
            z: 2
            id: restartButton

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.bottomMargin: 10
            anchors.rightMargin: 10

            width: 100
            height: 40
            text: "Add"
            onClicked: {
                var x = Math.random() * main.width
                var y = main.height - 60
                var colors = new Array("red","blue","green");

                var date = new Date()
                // Use miliseconds avoids the same random secuece
                // generation among calls
                var mils = date.getMilliseconds()
                var index = Math.floor((Math.random()*mils)%3)

                var obj = Logic.createBalloon( Math.floor(x), Math.floor(y),
                                              colors[index] )
            }
        }
    }
}

