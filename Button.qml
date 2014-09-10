import QtQuick 2.0

BorderImage {
    id: button
    property string normalImage: "balloons/button_unpressed.png"
    property string pressedImage: "balloons/button_pressed.png"
    property alias text : buttonText.text

    source: mouseArea.pressed ? pressedImage : normalImage

    signal clicked();

    Text {
        // anchors.fill: parent
        anchors.centerIn: parent
        // anchors.horizontalCenter: parent.horizontalCenter
        id: buttonText
        text: "text"
        font.pixelSize: 20
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: button.clicked();        
    }
}
