import QtQuick 2.0
import VPlay 2.0
import "../common" as Common
import ".."

Common.LevelBase {
    levelName: "Level1"
    id: scene
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    height: 1024
    width: 768

    // physics world for collision detection
    PhysicsWorld {
        id: world
        updatesPerSecondForPhysics: 60
    }

    Level {
        id: level
    }

    focus: true



    // ---------------------------------------------------
    // Joystick Controller tankRed
    // ---------------------------------------------------
    JoystickControllerHUD {
        width: 180
        height: 180
        x: 50
        y: 50

        Rectangle {
            anchors.fill: parent
            color: "#aaaaaa"
            opacity: 0.3
        }

        // delete the default images
        source: "../assets/img/null"
        thumbSource: "../assets/img/null"


        // Touch Methods
        property variant playerTwoAxisController: level.tankRed.getComponent("TwoAxisController")

        onControllerXPositionChanged: {
            playerTwoAxisController.xAxis = controllerXPosition
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            level.tankRed.tankBody.rotation = angle
            level.tankRed.boxCollider.rotation = angle
        }

        onControllerYPositionChanged: {
            playerTwoAxisController.yAxis = controllerYPosition
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            level.tankRed.tankBody.rotation = angle
            level.tankRed.boxCollider.rotation = angle
        }




        // Custom Javascript Functions
        function calcAngle(touchX, touchY) {

            console.log("touchX: " + touchX + ", touchY: " + touchY)

            // Avoid division by zero!
            if (touchX == 0) {
                return level.tankRed.boxCollider.rotation
            }

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
    }





    // ---------------------------------------------------
    // Joystick Controller red tankCannon
    // ---------------------------------------------------
    JoystickControllerHUD {
        width: 180
        height: 180
        x: scene.width - 230
        y: 50

        Rectangle {
            anchors.fill: parent
            color: "#aaaaaa"
            opacity: 0.3
        }

        // delete the default images
        source: "../assets/img/null"
        thumbSource: "../assets/img/null"

        property variant playerTwoAxisController: level.tankRed.getComponent("TwoAxisController")
        onControllerXPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            level.tankRed.tankCannon.rotation = angle
        }

        onControllerYPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            level.tankRed.tankCannon.rotation = angle
        }

        function calcAngle(touchX, touchY) {

            console.log("touchX: " + touchX + ", touchY: " + touchY)

            // Avoid division by zero!
            if (touchX == 0) {
                return level.tankRed.tankCannon.rotation
            }

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
    }







    // ---------------------------------------------------
    // Joystick Controller tankBlue
    // ---------------------------------------------------
    JoystickControllerHUD {
        width: 180
        height: 180
        x: scene.width - 230
        y: scene.height - 230

        Rectangle {
            anchors.fill: parent
            color: "#aaaaaa"
            opacity: 0.3
        }

        // delete the default images
        source: "../assets/img/null"
        thumbSource: "../assets/img/null"

        property variant playerTwoAxisController: level.tankBlue.getComponent("TwoAxisController")

        onControllerXPositionChanged: {
            playerTwoAxisController.xAxis = controllerXPosition
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            level.tankBlue.tankBody.rotation = angle
            level.tankBlue.boxCollider.rotation = angle
        }

        onControllerYPositionChanged: {
            playerTwoAxisController.yAxis = controllerYPosition
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            level.tankBlue.tankBody.rotation = angle
            level.tankBlue.boxCollider.rotation = angle
        }


        function calcAngle(touchX, touchY) {

            console.log("touchX: " + touchX + ", touchY: " + touchY)

            // Avoid division by zero!
            if (touchX == 0) {
                return level.tankBlue.boxCollider.rotation
            }

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
    }



    // ---------------------------------------------------
    // Joystick Controller blue tankCannon
    // ---------------------------------------------------
    JoystickControllerHUD {
        width: 180
        height: 180
        x: 50
        y: scene.height - 230

        Rectangle {
            anchors.fill: parent
            color: "#aaaaaa"
            opacity: 0.3
        }

        // delete the default images
        source: "../assets/img/null"
        thumbSource: "../assets/img/null"

        property variant playerTwoAxisController: level.tankBlue.getComponent("TwoAxisController")

        onControllerXPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            level.tankBlue.tankCannon.rotation = angle
        }

        onControllerYPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            level.tankBlue.tankCannon.rotation = angle
        }


        function calcAngle(touchX, touchY) {

            console.log("touchX: " + touchX + ", touchY: " + touchY)

            // Avoid division by zero!
            if (touchX == 0) {
                return level.tankBlue.tankCannon.rotation
            }

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
    }
}
