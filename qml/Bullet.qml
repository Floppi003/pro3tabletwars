import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: bullet
    entityType: "bullet"

    width: 10
    height: 10

    Rectangle {
        anchors.fill: parent
        color: "#000000"
    }

    BoxCollider {
        id: boxCollider

        width: 10
        height: 10
        anchors.centerIn: parent

        density: 0
        friction: 0
        restitution: 0
        body.bullet: true
        body.fixedRotation: false // if set to true the physics engine will NOT apply rotation to it
    }
}
