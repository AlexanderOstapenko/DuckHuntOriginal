import QtQuick 1.0

Item{
    id:cloud

    property int epsilon:0

    property string sourcePath:""

    property int prevAnimationSpeed:0
    property int animationSpeed:0

    property int targetX:0
    property int targetY:0

    property int prevX:0
    property int prevY:0

    property real prevSpeed:0
    property real speed:0

    property int lifeTime:0

    x:0
    y:0
    z:2
    clip:true

    height: cloudImage.height
    width: cloudImage.width

    Image{
        id:cloudImage
        source:sourcePath
    }
}

