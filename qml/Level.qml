import QtQuick 2.0
import VPlay 2.0

Item {
    id: level
    width: parent.width
    height: parent.height

    // make tanks accessible from outside
    property alias tankRed: tankRed
    property alias tankBlue: tankBlue

    Rectangle {
        id: backgroundRectangle
        anchors.fill: parent
        color: "#eeeeee"
    }

    Tank {
        id: tankRed
        width: 40
        height: 40
        x: scene.width / 2
        y: 100

        // rotation in degrees clockwise
        rotation: 0
        tankBody.source: "../gfx/charRed.png"
    }

    Tank {
        id: tankBlue
        x: scene.width / 2
        y: scene.height - 120

        rotation: 0
        tankBody.source: "../gfx/charBlue.png"
    }

    Wall {
        id: wallBottom
        height: 20
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

    Wall {
        id: wallTop
        height: 20
        anchors {
            left: parent.left
            right: parent.right
            top:parent.top
        }
    }

    Wall {
        id: wallLeft
        width: 20
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
    }

    Wall {
        id: wallRight
        width: 20
        anchors {
            left: parent.right
            bottom: parent.bottom
            top: parent.top
        }
    }
}
