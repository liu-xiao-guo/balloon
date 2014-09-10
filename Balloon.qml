import QtQuick 2.0
import QtQuick.Particles 2.0
import QtMultimedia 5.0
import "logic.js" as Logic

Image {
    id: balloon
    width: 100
    height: 200
    property bool created: false
    property bool surprise: false

    property string color: "red"
    property int x1
    property int y1
    property int speed

    Behavior on rotation { RotationAnimation { direction: RotationAnimation.Shortest;
            duration: 500; easing.type: Easing.OutBounce } }

    source: "images/" + color + ".svg"

    MediaPlayer {
        id: player
        source: "sounds/blast.wav"
    }

    NumberAnimation on y {
        easing.type: Easing.InOutQuad; to: y1; duration: speed
        running: created
    }

    NumberAnimation on x {
        easing.type: Easing.InOutQuad; to: x1; duration: speed
        running: created
    }

    MouseArea {
        // anchors.fill: parent
        x: 0; y: 0
        width: parent.width
        height: parent.height/2

        onClicked: {
            print("mouseY: " + mouseY);
            print("height: " + balloon.height );

//            if ( mouseY <= balloon.height/2) {
                balloon.state = "exploded";
                player.play();
//                Logic.playsound(surprise);
//            }
        }
    }

    MouseArea {
        x: 0; y: parent.height/2
        width: parent.width
        height: parent.height/2

        onClicked: {
            print("Good")
        }
        drag.target: parent
        drag.axis: "XandYAxis"
    }

    ParticleSystem {
        id: particle
        anchors.fill: parent
        running: false

        Emitter {
            group: "stars"
            emitRate: 800
            lifeSpan: 2400
            size: 24
            sizeVariation: 8
            anchors.fill: parent
        }

        ImageParticle {
            anchors.fill: parent
            source: "qrc:///particleresources/star.png"
            alpha: 0
            alphaVariation: 0.2
            colorVariation: 1.0
        }

        Emitter {
            anchors.centerIn: parent
            emitRate: 400
            lifeSpan: 2400
            size: 20 // 48
            sizeVariation: 8
            velocity: AngleDirection {angleVariation: 180; magnitude: 60}
        }

        Turbulence {
            anchors.fill: parent
            strength: 2
        }
    }

    states: [
        State {
            name: "exploded"

            StateChangeScript {
                script: {
                    particle.running = true;
                }
            }

            PropertyChanges {
                target: balloon
                visible: false
                source: "images/" + color + "_exploded.png"
            }

            PropertyChanges {
                target: balloon
                opacity: 0
            }

            PropertyChanges {
                target: balloon
                scale: 0
            }

            // StateChangeScript { script: balloon.destroy(1000); }
        }
    ]

    transitions: [
        Transition {
            to: "exploded"
            SequentialAnimation {

                // Disappear
                NumberAnimation { target: balloon; property: "opacity"
                    to: 0; duration: 500 }
                NumberAnimation { target: balloon; property: "scale"
                    to: 0; duration: 500 }

                PropertyAction { target: balloon; property: "source"
                                 value:  {
                                     if ( !surprise )
                                        "images/" + color + "_exploded.png"
                                     else
                                         "images/flower.png";
                                 }
                }

                NumberAnimation { target: balloon; property: "opacity"
                    to: 1; duration: 300 }
                NumberAnimation { target: balloon; property: "scale"
                    to: 1; duration: 300 }

                PauseAnimation {
                    duration: {
                        if (surprise)
                            2000
                        else
                            800
                    }
                }

                PropertyAction { target: balloon; property: "visible"
                                 value: "false"}
            }
        }
    ]
}
