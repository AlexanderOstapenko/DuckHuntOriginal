import QtQuick 1.0

Item{
    id:featherAnimation

    property int epsilon:0

    property int framesHorizontCount:0
    property int framesVerticalCount:0
    property int framesCount:(framesHorizontCount*framesVerticalCount)
    property int currentFrame:0
    property string sourcePath:""
    property int animationSpeed:0

    property int targetX:0
    property int targetY:0

    property int prevX:0
    property int prevY:0

    property real speed:0

    property int startFrame:0
    property int endFrame:0
    property int animationFrameCount:0

    x:1000
    y:1000
    z:4
    clip:true
    visible: false

    height:featherAnimationImage.height/framesVerticalCount
    width:featherAnimationImage.width/framesHorizontCount


    Image{
        id:featherAnimationImage
        source:sourcePath

        x:-((featherAnimation.currentFrame*featherAnimation.width)-Math.floor(featherAnimation.currentFrame/featherAnimation.framesHorizontCount)*(featherAnimation.framesHorizontCount*featherAnimation.width))
        y:-(Math.floor(featherAnimation.currentFrame/featherAnimation.framesHorizontCount)*featherAnimation.height)
    }

    states:[
        State {
            name: "START"
            PropertyChanges { target: featherAnimation; startFrame: 0}
            PropertyChanges { target: featherAnimation; endFrame: 1}
            PropertyChanges { target: featherAnimation; animationFrameCount: 2}
        },
        State {
            name: "CYCLE"
            PropertyChanges { target: featherAnimation; startFrame: 2}
            PropertyChanges { target: featherAnimation; endFrame: 4}
            PropertyChanges { target: featherAnimation; animationFrameCount: 3}
        }
    ]
}
