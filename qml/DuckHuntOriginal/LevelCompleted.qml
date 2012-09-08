import QtQuick 1.0

Rectangle {
    id: mainMenuPanel

    x:parent.width/2-180
    y:parent.height/2-200
    z:100

    width: 360
    height: 400

    opacity: 0.9
    color: "#404040"
    radius: 10
    visible: false
    border.color: "black"

    Image{
        x: parent.width/2-width/2
        y: 10
        z: parent.z+1
        source: "MEDIA/GFX/menu/completedImage.png"
    }

    Text{
        x: 50
        y: 120
        font.pixelSize: 30
        color: "white"
        text: "Level "+gameStatistic.level+" completed"
    }

    Image{
        x: 50
        y: 200
        source: "MEDIA/GFX/menu/kill.png"
    }

    Text{
        x: 95
        y: 200
        color: "white"
        font.pixelSize: 30
        text: gameStatistic.kill
    }


    Image{
        x: 220
        y: 200
        source: "MEDIA/GFX/menu/miss.png"
    }

    Text{
        x: 265
        y: 200
        color: "white"
        font.pixelSize: 30
        text: gameStatistic.miss
    }

    Rectangle{
        id: nextLevelButton
        x: parent.width/2-width/2
        y: parent.height-20-55
        z: parent.z+1
        width: 330
        height: 55
        visible: parent.visible
        radius: 10

        Image{
            source: "MEDIA/GFX/menu/nextLevelButton.png"
            anchors.centerIn: parent
            z: parent.z+2
        }

        border.color: "black"
        gradient: gradientStandart

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

        MouseArea{
            anchors.fill:parent
            anchors.bottom: parent.bottom
            width:parent.width
            height: parent.height

            onPressed: nextLevelButton.gradient=gradientPressed
            onReleased: nextLevelButton.gradient=gradientStandart
            onClicked: {
                gameStatistic.level++
                gameStatistic.total=10+gameStatistic.level
                gameStatistic.kill=0
                gameStatistic.miss=0
                gameStatistic.bullet=Math.round(gameStatistic.total+(gameStatistic.total/100)*30)

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

                if (blackDuck.animationSpeed>20) {
                    blackDuck.animationSpeed=100-gameStatistic.level*10
                    blackDuck.speed=5+gameStatistic.level
                    blackDuck.epsilon=10+gameStatistic.level
                }

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

                if (brownDuck.animationSpeed>20) {
                    brownDuck.animationSpeed=100-gameStatistic.level*10
                    brownDuck.speed=5+gameStatistic.level
                    brownDuck.epsilon=10+gameStatistic.level
                }

                blackDuckNeeded=true
                brownDuckNeeded=true

                gameStatistic.visible=false
                grass.source="MEDIA/GFX/grass0.png"
                blackDuckTimer.stop()
                brownDuckTimer.stop()
                dogTimer.start()
                if(!mainPage.muted){chienMarche.play()}

                mainPage.paused=false
                newLevelMenu.visible=false
            }
        }
    }

}

