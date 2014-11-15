import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: tank
    entityType: "tank"

    // make the twoAxisController acessible from outside
    property alias controller: twoAxisController
    property alias tankBody: tankBody
    property alias tankCannon: tankCannon
    property alias boxCollider: boxCollider

    // this is used as input for the BoxCollider force & torque properties
    TwoAxisController {
        id: twoAxisController
    }

    Rectangle {
        id: tankBody
        width: 40
        height: 40
        anchors.centerIn: parent
    }

    Rectangle {
        id: tankCannon

        x: tankBody.x + tankBody.width / 2
        y: tankBody.y + tankBody.height / 2 - 2
        width: 26
        height: 4
        transformOrigin: Item.Left
        rotation: -45
        //transformOriginPoint: Qt.point(13, 2)

        color: "#000000"
    }

    BoxCollider {
        id: boxCollider

        // the image and the physics will use this size
        width: 40
        height: 40

        anchors.centerIn: parent

        density: 0
        friction: 0
        restitution: 0.0
        body.bullet: true
        body.linearDamping: 0
        body.angularDamping: 0

        // this is applied every physics update tick
        linearVelocity: Qt.point(twoAxisController.xAxis * 100, twoAxisController.yAxis * (-100))
        //force: Qt.point(twoAxisController.xAxis * 1000, twoAxisController.yAxis * 1000)
        //torque: 1000
    }
}
