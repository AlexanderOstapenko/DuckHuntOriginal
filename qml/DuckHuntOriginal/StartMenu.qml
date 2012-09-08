import QtQuick 1.0

Rectangle {
    id: mainMenuPanel

    property string playButtonImage: "MEDIA/GFX/menu/startNewGameButton.png"

    x:parent.width/2-180
    y:parent.height/2-100
    z:100

    width: 360
    height: 200

    opacity: 0.9
    color: "#404040"
    radius: 10
    visible: true
    border.color: "black"

    Gradient {
        id: gradientStandart
        GradientStop { position: 0.0; color: "#707070" }
        GradientStop { position: 0.2; color: "#606060" }
        GradientStop { position: 0.9;color: "#303030" }
        GradientStop { position: 1.0; color: "#202020" }
    }

    Gradient {
        id: gradientPressed
        GradientStop { position: 0.0; color: "#202020" }
        GradientStop { position: 0.2;color: "#303030" }
        GradientStop { position: 0.9; color: "#606060" }
        GradientStop { position: 1.0; color: "#707070" }
    }

    Rectangle{
        id: playButton
        x: parent.width/2-width/2
        y: 10
        z: parent.z+1
        width: 330
        height: 55
        visible: parent.visible
        radius: 10

        Image{
            source: playButtonImage
            anchors.centerIn: parent
            z: parent.z+2
        }

        border.color: "black"
        gradient: gradientStandart

        MouseArea{
            anchors.fill:parent
            anchors.bottom: parent.bottom
            width:parent.width
            height: parent.height

            onPressed: playButton.gradient=gradientPressed
            onReleased: playButton.gradient=gradientStandart
            onClicked: {
                if (startMenu.playButtonImage=="MEDIA/GFX/menu/startNewGameButton.png") {
                    dog.currentFrame=-1
                    dog.animationSpeed=150
                    dog.speed=4
                    dog.x=1
                    dog.y=380
                    dog.prevX=0
                    dog.prevY=362
                    dog.targetX= 200
                    dog.targetY= 380
                    dog.z=10
                    dog.state="START_LEVEL"

                    blackDuck.animationSpeed=100
                    blackDuck.speed=5
                    blackDuck.epsilon=10
                    brownDuck.animationSpeed=100
                    brownDuck.speed=5
                    brownDuck.epsilon=10

                    blackDuck.x=10+Math.random()*(gameScreen.width-10)
                    blackDuck.y=360
                    blackDuck.prevX=398
                    blackDuck.prevY=362
                    blackDuck.targetX=10+Math.random()*800
                    blackDuck.targetY=10+Math.random()*350
                    blackDuck.z=3
                    blackDuck.lifeTime=0
                    blackDuck.flyAway=false
                    blackDuck.state="TOP"

                    brownDuck.x=10+Math.random()*(gameScreen.width-10)
                    brownDuck.y=360
                    brownDuck.prevX=398
                    brownDuck.prevY=362
                    brownDuck.targetX=10+Math.random()*800
                    brownDuck.targetY=10+Math.random()*350
                    brownDuck.z=5
                    brownDuck.lifeTime=0
                    brownDuck.flyAway=false
                    brownDuck.state="TOP"

                    blackDuckNeeded=true
                    brownDuckNeeded=true

                    gameStarted=true
                    if (!mainPage.muted) chienMarche.play()
                }

                startMenu.visible=false
                mainPage.paused=false
                dogTimer.start()
            }
        }
    }

    Rectangle{
        id: soundOnOffButton
        x: parent.width/2-width/2
        y: 75
        z: parent.z+1
        width: 330
        height: 55
        visible: parent.visible
        radius: 10

        Image{
            source: "MEDIA/GFX/menu/soundOnOffButton.png"
            anchors.centerIn: parent
            z: parent.z+2
        }

        border.color: "black"
        gradient: gradientStandart

        MouseArea{
            anchors.fill:parent
            anchors.bottom: parent.bottom
            width:parent.width
            height: parent.height

            onPressed: soundOnOffButton.gradient=gradientPressed
            onReleased: soundOnOffButton.gradient=gradientStandart
            onClicked: {
                rumbleEffect.start();
                mainPage.muted=!mainPage.muted
                if (muted){
                    shotSound.stop()
                    fireSound.stop()
                    duckFlightSound.stop()
                    duckDeadSound.stop()
                    canardSol.stop()
                    chienRamasse.stop()
                    chienMarche.stop()
                    chienSaute.stop()
                    chienCry.stop()
                    gameOverTheme.stop()
                    //mainTheme.stop()
                } else {
                    chienSaute.play()
                }
            }
        }
    }

    /* Rectangle{
        id: aboutButton
        x: parent.width/2-width/2
        y: 260
        z: parent.z+1
        width: 330
        height: 55
        visible: parent.visible
        radius: 10

        Image{
            source: "MEDIA/GFX/menu/aboutButton.png"
            anchors.centerIn: parent
            z: parent.z+2
        }

        border.color: "black"
        gradient: gradientStandart

        MouseArea{
            anchors.fill:parent
            anchors.bottom: parent.bottom
            width:parent.width
            height: parent.height

            onPressed: aboutButton.gradient=gradientPressed
            onReleased: aboutButton.gradient=gradientStandart
            onClicked: {            }
        }
    }*/

    Rectangle{
        id: exitButton
        x: parent.width/2-width/2
        y: 135
        z: parent.z+1
        width: 330
        height: 55
        visible: parent.visible
        radius: 10

        Image{
            source: "MEDIA/GFX/menu/exitButton.png"
            anchors.centerIn: parent
            z: parent.z+2
        }

        border.color: "black"
        gradient: gradientStandart

        MouseArea{
            anchors.fill:parent
            anchors.bottom: parent.bottom
            width:parent.width
            height: parent.height

            onPressed: exitButton.gradient=gradientPressed
            onReleased: exitButton.gradient=gradientStandart
            onClicked: {
                Qt.quit()
            }
        }
    }

}
