import QtQuick 1.0

Item{
    id:dogAnimation

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

    x:400
    y:360
    z:3
    clip:true

    height:dogAnimationImage.height/framesVerticalCount
    width:dogAnimationImage.width/framesHorizontCount


    Image{
        id:dogAnimationImage
        source:sourcePath

        x:-((dogAnimation.currentFrame*dogAnimation.width)-Math.floor(dogAnimation.currentFrame/dogAnimation.framesHorizontCount)*(dogAnimation.framesHorizontCount*dogAnimation.width))
        y:-(Math.floor(dogAnimation.currentFrame/dogAnimation.framesHorizontCount)*dogAnimation.height)
    }

    states:[
        State {
            name: "START_LEVEL"
            PropertyChanges { target: dogAnimation; startFrame: 0}
            PropertyChanges { target: dogAnimation; endFrame: 4}
            PropertyChanges { target: dogAnimation; animationFrameCount: 5}
        },
        State {
            name: "JUMP"
            PropertyChanges { target: dogAnimation; startFrame: 6}
            PropertyChanges { target: dogAnimation; endFrame: 8}
            PropertyChanges { target: dogAnimation; animationFrameCount: 3}
        },
        State {
            name: "CATCH"
            PropertyChanges { target: dogAnimation; startFrame: 5}
            PropertyChanges { target: dogAnimation; endFrame: 5}
            PropertyChanges { target: dogAnimation; animationFrameCount: 1}
        },
        State {
            name: "DOUBLE_CATCH"
            PropertyChanges { target: dogAnimation; startFrame: 11}
            PropertyChanges { target: dogAnimation; endFrame: 11}
            PropertyChanges { target: dogAnimation; animationFrameCount: 1}
        },
        State {
            name: "MISS"
            PropertyChanges { target: dogAnimation; startFrame: 9}
            PropertyChanges { target: dogAnimation; endFrame: 10}
            PropertyChanges { target: dogAnimation; animationFrameCount: 2}
        }
    ]
}
