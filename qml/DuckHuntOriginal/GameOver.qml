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
        source: "MEDIA/GFX/menu/gameOver.png"
    }

    Text{
        x: 50
        y: 120
        font.pixelSize: 30
        color: "white"
        text: "You missed "+gameStatistic.miss+" duck"
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
            source: "MEDIA/GFX/menu/exitButton.png"
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
                gameOverTheme.stop()
                gameOverMenu.visible=false

                gameStatistic.level=1
                gameStatistic.total=10
                gameStatistic.kill=0
                gameStatistic.miss=0
                gameStatistic.bullet=13

                gameStatistic.visible=false
                grass.source="MEDIA/GFX/grass0.png"

                mainPage.paused=true
                startMenu.playButtonImage="MEDIA/GFX/menu/startNewGameButton.png"
                startMenu.visible=true
            }
        }
    }

}

