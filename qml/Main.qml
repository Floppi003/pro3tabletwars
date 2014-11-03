import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    // Comment from Biggi
    // Comment from Chris

    licenseKey: "ACE21390D11341ED2FBAD617F7C2F862FE5AACB2CFFC6D0D05F690F43F64C28AB8FB18C05D68FC3C73EEE9C188B5017D4DF874968083AB7CEEEFA7B6AEB21DADBA3F3E17942D6862D52ABD75C6E7066FBED0070639EDBB3DDB01CC7C3276BE01E676617D0D37467F90AE3A42173C63BD55FF3C935D3999CF751B47B7DE34A2CA4C22F553EAEB7EE210DE2F402BE33FB9C18CF77B199AFD1413C82A7AD75BCF6EA3FCBA53AA60918FB430C450FA8B229BC6C9930BCFDC8BB386D23B83935C81595EA15A6B116E9DC0C3D28B0A27A344BF511574720563ED8837ED177D4D5770A91C6A282654064B75D4A84422F2B33336FA5648E5FE8B549406604900C43EB33D19DAEB8F8FA0F5A14E821055D608DA87"

    // test test test
    activeScene: scene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPad
    height: 2048
    width: 1536

    Scene {
        id: scene

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        height: 1024
        width: 768


        // EntityManager to create entities at runtime dynamically
        EntityManager {
            id: entityManager
            entityContainer: scene
        }

        // background rectangle matching the logical scene size (= safe zone available on all devices)
        Rectangle {
            id: rectangle
            anchors.fill: parent
            color: "white"
        }


        Item {
        // Player-Body
            Rectangle {
                id: player

                x: 50
                y: 50
                width: 42
                height: 42

                color: "#00ff44"

                property double xVelocity
                property double yVelocity

                MovementAnimation {
                    target: parent
                    property: "pos"
                    velocity: Qt.point(player.xVelocity, player.yVelocity)
                    running: true
                }
            }

            // Cannon
            Rectangle {
                id: cannon

                x: player.x + player.width / 2
                y: player.y + player.height / 2 - 2
                width: 26
                height: 4
                transformOrigin: Item.Left
                //transformOriginPoint: Qt.point(13, 2)

                color: "#ff0000"
            }
        }


        // Projectiles
        Component {
            id: projectile

            EntityBase {
                entityType: "projectile"
                id: singlePro


                Rectangle {
                    color: "#ff0000"
                    width: 10
                    height: 10
                }

                property point destination
                property int moveDuration

                PropertyAnimation on x {
                    from: player.x + player.width / 2
                    to: destination.x
                    duration: moveDuration
                }

                PropertyAnimation on y {
                    from: player.y + player.height / 2 - 4
                    to: destination.y
                    duration: moveDuration

                    onStopped: {
                        console.log("did Destroy")
                       singlePro.destroy()
                    }
                }
            }
        }




        // Player-Movement Control-Area
        Rectangle {
            // Object properties
            id: playerMovementControlArea

            opacity: 0.2
            color: "#777777"

            width: 180
            height: 180
            x: 50
            y: scene.height - 230


            MultiPointTouchArea {
                anchors.fill: parent

                // Javascript functions
                function calcAngle(touchX, touchY) {
                    var angle = Math.atan(touchY / touchX)

                    // find out in which quadrant this happened.
                    if (touchX < 0 && touchY >= 0) {
                        // upper left quadrant
                        angle = Math.PI - (Math.abs(angle))

                    } else if (touchX < 0 && touchY < 0) {
                        // lower left quadrant
                        angle = Math.PI + (Math.abs(angle))

                    } else if (touchX >= 0 && touchY < 0) {
                        // lower right quadrant
                        angle = (Math.PI * 2) - (Math.abs(angle))
                    }

                    angle = (angle * 180 / Math.PI)
                    angle = 360 - angle
                    console.log("angle: " + angle + ", (x: " + touchX + ", y: " + touchY + ")")
                    player.rotation = angle
                }


                function calcSpeed(touchX, touchY) {
                    player.xVelocity = touchX
                    player.yVelocity = (touchY * -1)
                }


                onReleased: {
                    console.log("PlayerCA: onReleased")
                }

                onPressed: {
                    console.log("PlayerCA: onPressed")
                }

                onTouchUpdated: {
                    console.log("PlayerCA: onPositionChanged")

                    var x = Math.min(playerMovementControlArea.width, touchPoints[0].x)
                    var y = Math.min(playerMovementControlArea.height, touchPoints[0].y)
                    x = Math.max(0, x)
                    y = Math.max(0, y)
                    x = x - (playerMovementControlArea.width / 2)
                    y = (y - (playerMovementControlArea.height / 2)) * (-1)
                    calcAngle(x, y)
                    calcSpeed(x, y)
                }
            }
        }



        // Cannon Control-Area
        Rectangle {
            // Object properties
            id: cannonControlArea

            opacity: 0.2
            color: "#777777"

            width: 180
            height: 180
            x: scene.width - 230
            y: scene.height - 230

            property double lastTouchTime


            MultiPointTouchArea {
                anchors.fill: parent

                // Javascript functions
                function calcAngle(touchX, touchY) {
                    var angle = Math.atan(touchY / touchX)

                    // find out in which quadrant this happened.
                    if (touchX < 0 && touchY >= 0) {
                        // upper left quadrant
                        angle = Math.PI - (Math.abs(angle))

                    } else if (touchX < 0 && touchY < 0) {
                        // lower left quadrant
                        angle = Math.PI + (Math.abs(angle))

                    } else if (touchX >= 0 && touchY < 0) {
                        // lower right quadrant
                        angle = (Math.PI * 2) - (Math.abs(angle))
                    }

                    angle = (angle * 180 / Math.PI)
                    angle = 360 - angle
                    console.log("angle: " + angle + ", (x: " + touchX + ", y: " + touchY + ")")
                    return angle
                }


                onReleased: {
                    console.log("CannonCA: onReleased")

                    var nowDateValue = new Date().valueOf()
                    var timeDiff = nowDateValue - cannonControlArea.lastTouchTime

                    console.log("timeDiff: " + timeDiff);

                    if (timeDiff < 120) {
                        // it was a short touch, fire a weapon!

                        console.log("angle: " + cannon.rotation)

                        var xDirection = Math.cos(cannon.rotation * Math.PI / 180.0)
                        var yDirection = Math.sin(cannon.rotation * Math.PI / 180.0)
                        console.log("----------------------------------------------------------------------")
                        console.log("----------------------------------------------------------------------")
                        console.log("xDir: " + xDirection + ", yDir: " + yDirection)

                        while ((player.x + xDirection > -5 && player.x + xDirection < scene.width + 5) &&
                               (player.y + yDirection > -5 && player.y + yDirection < scene.height + 5)) {
                            xDirection = xDirection * 2
                            yDirection = yDirection * 2

                            console.log("xDir: " + xDirection + ", yDir: " + yDirection)
                        }

                        xDirection = player.x + xDirection + player.width / 2
                        yDirection = player.y + yDirection + player.height / 2 - 4
                        var distance = Math.sqrt(xDirection * xDirection + yDirection * yDirection)
                        var time = distance / 480 // pixel per second
                        time = time * 1000 // milliseconds

                        console.log("distance: " + distance)
                        console.log("time: " + time)
                        console.log("xDirection: " + xDirection + ", yDirection: " + yDirection)
                        console.log("player.x: " + player.x + ", player.y: " + player.y)

                        var destination = Qt.point(xDirection, yDirection)

                        console.log("point.x: " + destination.x + ", point.y: " + destination.y)

                        entityManager.createEntityFromComponentWithProperties(projectile, {"destination" : destination, "moveDuration" : time})
                    }
                }

                onPressed: {
                    console.log("CannonCA: onPressed")
                    cannonControlArea.lastTouchTime = new Date().valueOf()
                }

                onTouchUpdated: {
                    console.log("CannonCA: onPositionChanged")

                    var x = Math.min(playerMovementControlArea.width, touchPoints[0].x)
                    var y = Math.min(playerMovementControlArea.height, touchPoints[0].y)
                    x = Math.max(0, x)
                    y = Math.max(0, y)
                    x = x - (playerMovementControlArea.width / 2)
                    y = (y - (playerMovementControlArea.height / 2)) * (-1)
                    var angle = calcAngle(x, y)
                    cannon.rotation = angle
                }
            }
        }
    }
}

