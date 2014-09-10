import QtQuick 2.0

Row {
    id: scimagecontainer
    width: scimage.width * 2
    height: main.height

    Image{
        id:scimage
        width: main.width; height: main.height
        source: "images/sky.jpg";
        fillMode: Image.TileHorizontally
    }

    Image{
        width:main.width; height: main.height
        source: "images/sky.jpg";
        anchors.left: first.right
        fillMode: Image.TileHorizontally
    }

    NumberAnimation on x {
        from: 0; to: -scimage.width;
        loops: Animation.Infinite; duration: 20000
    }
}

