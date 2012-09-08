import QtQuick 1.0

Item{
    id:spriteAnimation

    property int epsilon:0

    property int framesHorizontCount:0
    property int framesVerticalCount:0
    property int framesCount:(framesHorizontCount*framesVerticalCount)
    property int currentFrame:0
    property string sourcePath:""

    property int prevAnimationSpeed:0
    property int animationSpeed:0

    property int targetX:0
    property int targetY:0

    property int prevX:0
    property int prevY:0

    property real prevSpeed:0
    property real speed:0

    property int startFrame:0
    property int endFrame:0
    property int animationFrameCount:0

    property int lifeTime:0

    property bool flyAway: false

    x:400
    y:360
    z:3
    clip:true

    height:spriteAnimationImage.height/framesVerticalCount
    width:spriteAnimationImage.width/framesHorizontCount


    Image{
        id:spriteAnimationImage
        source:sourcePath

        x:-((spriteAnimation.currentFrame*spriteAnimation.width)-Math.floor(spriteAnimation.currentFrame/spriteAnimation.framesHorizontCount)*(spriteAnimation.framesHorizontCount*spriteAnimation.width))
        y:-(Math.floor(spriteAnimation.currentFrame/spriteAnimation.framesHorizontCount)*spriteAnimation.height)
    }

    states:[
        State {
            name: "TOP_RIGHT"
            PropertyChanges { target: spriteAnimation; startFrame: 6}
            PropertyChanges { target: spriteAnimation; endFrame: 8}
            PropertyChanges { target: spriteAnimation; animationFrameCount: 3}
            PropertyChanges { target: spriteAnimation; currentFrame: 6}
        },
        State {
            name: "TOP_LEFT"
            PropertyChanges { target: spriteAnimation; startFrame: 9}
            PropertyChanges { target: spriteAnimation; endFrame: 11}
            PropertyChanges { target: spriteAnimation; animationFrameCount: 3}
            PropertyChanges { target: spriteAnimation; currentFrame: 9}
        },
        State {
            name: "TOP"
            PropertyChanges { target: spriteAnimation; startFrame: 12}
            PropertyChanges { target: spriteAnimation; endFrame: 14}
            PropertyChanges { target: spriteAnimation; animationFrameCount: 3}
            PropertyChanges { target: spriteAnimation; currentFrame: 12}
        },
        State {
            name: "DOWN"
            PropertyChanges { target: spriteAnimation; startFrame: 15}
            PropertyChanges { target: spriteAnimation; endFrame: 17}
            PropertyChanges { target: spriteAnimation; animationFrameCount: 3}
            PropertyChanges { target: spriteAnimation; currentFrame: 15}
        },
        State {
            name: "DEAD"
            PropertyChanges { target: spriteAnimation; startFrame: 19}
            PropertyChanges { target: spriteAnimation; endFrame: 22}
            PropertyChanges { target: spriteAnimation; animationFrameCount: 4}
            PropertyChanges { target: spriteAnimation; currentFrame: 19}
        }
    ]
}
