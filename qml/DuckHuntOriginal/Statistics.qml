import QtQuick 1.0

Item {
    id: stat
    x: 0
    y: 420
    width: gameScreen.width-80
    height: 60
    z: 100

    property int level: 0
    property int total: 10
    property int kill: 0
    property int miss: 0
    property int bullet: 0

    Image{
        x: 10
        y: 10
        source: "MEDIA/GFX/menu/level.png"
    }

    Text{
        x: 55
        y: 15
        font.pixelSize: 30
        color: "white"
        text: stat.level
    }


    Image{
        x: 210
        y: 10
        source: "MEDIA/GFX/menu/total.png"
    }

    Text{
        x: 255
        y: 15
        color: "white"
        font.pixelSize: 30
        text: stat.total
    }


    Image{
        x: 340
        y: 10
        source: "MEDIA/GFX/menu/kill.png"
    }

    Text{
        x: 385
        y: 15
        color: "white"
        font.pixelSize: 30
        text: stat.kill
    }


    Image{
        x: 490
        y: 10
        source: "MEDIA/GFX/menu/miss.png"
    }

    Text{
        x: 535
        y: 15
        color: "white"
        font.pixelSize: 30
        text: stat.miss
    }


    Image{
        x: 640
        y: 10
        source: "MEDIA/GFX/menu/bullet.png"
    }

    Text{
        x: 685
        y: 15
        color: "white"
        font.pixelSize: 30
        text: stat.bullet
    }
}
