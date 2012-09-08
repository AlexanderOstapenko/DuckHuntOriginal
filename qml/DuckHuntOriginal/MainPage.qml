import QtQuick 1.1
import Qt 4.7
import com.nokia.meego 1.0
import QtMultimediaKit 1.1

Page {
    id: mainPage
    property bool blackDuckNeeded: true
    property bool brownDuckNeeded: true
    property string initialDuck: "NULL"
    property int duckMaxLifeTime: 10000

    property bool initializationFlag: true
    property bool muted: false
    property bool previousMutedState: false
    property bool gameStarted: false
    property bool paused: true

    //orientationLock: PageOrientation.LockLandscape

    Rectangle {
        id:gameScreen
        x:0
        y:0
        width: parent.width
        height: parent.height
        //anchors.fill: parent
        z:0
        clip: true

        StartMenu{
            id:startMenu
            visible: false
        }

        SoundEffect  {
            id: shotSound
            source:"MEDIA/SND/shot.wav"
        }

        SoundEffect  {
            id: fireSound
            source:"MEDIA/SND/fire.wav"
        }

        SoundEffect  {
            id: duckFlightSound
            loops: 3
            source:"MEDIA/SND/flight.wav"
        }

        SoundEffect  {
            id: duckDeadSound
            source:"MEDIA/SND/dead.wav"
        }

        SoundEffect  {
            id: canardSol
            source:"MEDIA/SND/canardSol.wav"
        }

        SoundEffect  {
            id: chienRamasse
            source:"MEDIA/SND/chienRamasse.wav"
        }

        SoundEffect  {
            id: chienMarche
            source:"MEDIA/SND/chienMarche.wav"
        }

        SoundEffect  {
            id: chienSaute
            source:"MEDIA/SND/chienSaute.wav"
        }

        SoundEffect  {
            id: chienCry
            source:"MEDIA/SND/chienCry.wav"
        }

        SoundEffect  {
            id: gameOverTheme
            source:"MEDIA/SND/gameOver.wav"
        }

        /*SoundEffect  {
            id: mainTheme
            //autoLoad: true
            //volume: 0.7
            source:"MEDIA/SND/mainTheme.wav"
        }*/

        Image{
            id:backGround
            anchors.fill: parent
            z:1
            source:"MEDIA/GFX/background.png"
            clip: true
        }

        Image{
            id:tree
            x:50
            y:20
            z:8
            source:"MEDIA/GFX/tree.png"
            clip: true
        }

        Image{
            id:grass
            x:0
            y:380
            z:9
            source:"MEDIA/GFX/grass0.png"
            clip: true
        }

        Clouds{
            id:cloud1
            sourcePath:"MEDIA/GFX/clouds.png"

            epsilon:10

            animationSpeed:100
            speed:2

            x:0
            y:45
            prevX:5
            prevY:45
            targetX: -860
            targetY: 50
            z:2

            lifeTime: 0
        }

        Clouds{
            id:cloud2
            sourcePath:"MEDIA/GFX/clouds.png"

            epsilon:10

            animationSpeed:100
            speed:2

            x:854
            y:45
            prevX:855
            prevY:45
            targetX: -860
            targetY: 45
            z:2

            lifeTime: 0
        }

        AnimatedSprite{
            id:blackDuck

            epsilon:10

            framesHorizontCount:6
            framesVerticalCount:4
            framesCount:(framesHorizontCount*framesVerticalCount)
            currentFrame:-1
            sourcePath:"MEDIA/GFX/BlackDuck.png"
            animationSpeed:100
            speed:5

            x:200
            y:360
            prevX:398
            prevY:362
            targetX: 10+Math.random()*800
            targetY: 10+Math.random()*350
            z:3

            lifeTime: 0
            flyAway: false
        }

        AnimatedSprite{
            id:brownDuck

            epsilon:10

            framesHorizontCount:6
            framesVerticalCount:4
            framesCount:(framesHorizontCount*framesVerticalCount)
            currentFrame:-1
            sourcePath:"MEDIA/GFX/BrownDuck.png"
            animationSpeed:100
            speed:5

            x:600
            y:360
            prevX:398
            prevY:362
            targetX: 10+Math.random()*800
            targetY: 10+Math.random()*350
            z:5

            lifeTime: 0
            flyAway: false
        }

        DogAnimation{
            id:dog

            epsilon:0

            framesHorizontCount:6
            framesVerticalCount:2
            framesCount:(framesHorizontCount*framesVerticalCount)
            currentFrame:-1
            sourcePath:"MEDIA/GFX/dog.png"
            animationSpeed:150
            speed:4

            x:1
            y:380
            prevX:0
            prevY:362
            targetX: 200
            targetY: 380
            z:10

            state:"START_LEVEL"
        }

        FeathersSprite{
            id:feathers1

            epsilon:0

            framesHorizontCount:5
            framesVerticalCount:1
            framesCount:(framesHorizontCount*framesVerticalCount)
            currentFrame:-1
            sourcePath:"MEDIA/GFX/feathers.png"
            animationSpeed:75
            speed:3
            visible:false

            x:1000
            y:1000
            prevX:0
            prevY:0
            targetX: 0
            targetY: 0
            z:4

            opacity: 1

            state:"START"
        }

        FeathersSprite{
            id:feathers2

            epsilon:0

            framesHorizontCount:5
            framesVerticalCount:1
            framesCount:(framesHorizontCount*framesVerticalCount)
            currentFrame:-1
            sourcePath:"MEDIA/GFX/feathers.png"
            animationSpeed:75
            speed:3
            visible:false

            x:1000
            y:1000
            prevX:0
            prevY:0
            targetX: 0
            targetY: 0
            z:4

            opacity: 1

            state:"START"
        }

        AnimatedSprite{
            id:shot

            framesHorizontCount:16
            framesVerticalCount:1
            framesCount:(framesHorizontCount*framesVerticalCount)
            currentFrame:-1
            sourcePath: "MEDIA/GFX/shot.png"
            animationSpeed:10

            x:1000
            y:1000
            z:3
        }

        Timer{
            id:cloudTimer
            interval:cloud1.animationSpeed
            running:true
            repeat:true
            onTriggered:{
                cloud1.x+=Math.ceil(((cloud1.targetX-cloud1.x)/Math.abs(cloud1.targetX-cloud1.x))*cloud1.speed)
                cloud2.x+=Math.ceil(((cloud2.targetX-cloud2.x)/Math.abs(cloud2.targetX-cloud2.x))*cloud2.speed)

                if (cloud1.x<=-854) cloud1.x=854
                if (cloud2.x<=-854) cloud2.x=854
            }
        }

        Timer{
            id:featherTimer
            interval:feathers1.animationSpeed
            running:false
            repeat:true
            onTriggered:{
                feathers1.y+=Math.ceil(((feathers1.targetY-feathers1.y)/Math.abs(feathers1.targetY-feathers1.y))*feathers1.speed)

                if (feathers1.y>=500){
                    featherTimer.stop()
                    feathers1.visible=false
                }

                if (feathers1.opacity<=0){
                    featherTimer.stop()
                    feathers1.visible=false
                }

                if ((feathers1.state=="START")&&(feathers1.currentFrame==feathers1.endFrame)){
                    feathers1.state="CYCLE"
                }


                if (feathers1.currentFrame==feathers1.endFrame){
                    feathers1.currentFrame=feathers1.startFrame
                } else {
                    feathers1.currentFrame++
                    feathers1.opacity-=0.02
                }
            }
        }

        Timer{
            id:featherTimer2
            interval:feathers2.animationSpeed
            running:false
            repeat:true
            onTriggered:{
                feathers2.y+=Math.ceil(((feathers2.targetY-feathers2.y)/Math.abs(feathers2.targetY-feathers2.y))*feathers2.speed)

                if (feathers2.y>=500){
                    featherTimer2.stop()
                    feathers2.visible=false
                }

                if (feathers2.opacity<=0){
                    featherTimer2.stop()
                    feathers2.visible=false
                }

                if ((feathers2.state=="START")&&(feathers2.currentFrame==feathers2.endFrame)){
                    feathers2.state="CYCLE"
                }


                if (feathers2.currentFrame==feathers2.endFrame){
                    feathers2.currentFrame=feathers2.startFrame
                } else {
                    feathers2.currentFrame++
                    feathers2.opacity-=0.02
                }
            }
        }

        Timer{
            id:dogTimer
            interval:dog.animationSpeed
            running:false
            repeat:true
            onTriggered:{
                if (!mainPage.paused){
                    dog.prevX=dog.x
                    dog.prevY=dog.y

                    if (dog.state!="CATCH") dog.x+=Math.ceil(((dog.targetX-dog.x)/Math.abs(dog.targetX-dog.x))*dog.speed)
                    dog.y+=Math.ceil(((dog.targetY-dog.y)/Math.abs(dog.targetY-dog.y))*dog.speed)

                    if (dog.state=="CATCH") {
                        if (dog.y<=330){
                            dog.y+=dog.speed
                            dog.targetY=385
                        }
                        if (dog.y>=380){
                            dog.y=500
                            if (initialDuck=="BLACK_DUCK") blackDuckNeeded=true
                            if (initialDuck=="BROWN_DUCK") brownDuckNeeded=true
                            dogTimer.stop()
                        }
                    } else if (dog.state=="MISS") {
                        if (dog.y<=330){
                            dog.y+=dog.speed
                            dog.targetY=385
                        }
                        if (dog.y>=380){
                            dog.y=500
                            if (initialDuck=="BLACK_DUCK") blackDuckNeeded=true
                            if (initialDuck=="BROWN_DUCK") brownDuckNeeded=true
                            dogTimer.stop()
                        }
                    } else if (dog.state=="START_LEVEL"){
                        if (dog.x>=200){
                            dog.y=370
                            dog.targetX=240
                            dog.targetY=320
                            dog.animationSpeed=40
                            dog.state="JUMP"
                            dog.z=10
                            if (!mainPage.muted) chienSaute.play()
                        }
                    }else if (dog.state=="JUMP"){
                        if (dog.y<=320){
                            dog.y=500
                            dog.animationSpeed=20
                            dog.z=3

                            grass.source="MEDIA/GFX/grass.png"
                            gameStatistic.visible=true
                            blackDuckTimer.start()
                            brownDuckTimer.start()

                            dogTimer.stop()

                            blackDuck.visible=true
                            brownDuck.visible=true
                            if (!mainPage.muted) duckFlightSound.play()

                            gameStatistic.total--
                            gameStatistic.total--
                        }
                    }

                    if (dog.currentFrame==dog.endFrame){
                        if (dog.state!="JUMP") dog.currentFrame=dog.startFrame
                    } else {
                        dog.currentFrame++
                    }
                }
            }
        }

        Timer{
            id:blackDuckTimer
            interval:blackDuck.animationSpeed
            running:false
            repeat:true
            onTriggered:{
                if (!mainPage.paused){
                    blackDuck.prevX=blackDuck.x
                    blackDuck.prevY=blackDuck.y

                    blackDuck.x+=Math.ceil(((blackDuck.targetX-blackDuck.x)/Math.abs(blackDuck.targetX-blackDuck.x))*blackDuck.speed)
                    blackDuck.y+=Math.ceil(((blackDuck.targetY-blackDuck.y)/Math.abs(blackDuck.targetY-blackDuck.y))*blackDuck.speed)

                    if ((blackDuck.state!="DEAD")&&(blackDuck.flyAway==false)){
                        if ((Math.abs(blackDuck.x-blackDuck.targetX)<=blackDuck.epsilon)&&(blackDuck.y<=blackDuck.prevY)){
                            if (blackDuck.state!="TOP") {
                                blackDuck.state = "TOP"
                                blackDuck.currentFrame=blackDuck.startFrame
                            }
                        } else if ((Math.abs(blackDuck.x-blackDuck.targetX)<=blackDuck.epsilon)&&(blackDuck.y>=blackDuck.prevY)){
                            if (blackDuck.state!="DOWN") {
                                blackDuck.state = "DOWN"
                                blackDuck.currentFrame=blackDuck.startFrame
                            }
                        } else if (blackDuck.x>=blackDuck.prevX){
                            if (blackDuck.state!="TOP_RIGHT") {
                                blackDuck.state = "TOP_RIGHT"
                                blackDuck.currentFrame=blackDuck.startFrame
                            }
                        } else if (blackDuck.x<=blackDuck.prevX){
                            if (blackDuck.state!="TOP_LEFT") {
                                blackDuck.state = "TOP_LEFT"
                                blackDuck.currentFrame=blackDuck.startFrame
                            }
                        } else {
                            if (blackDuck.state!="TOP") {
                                blackDuck.state = "TOP"
                                blackDuck.currentFrame=blackDuck.startFrame
                            }
                        }

                        blackDuck.lifeTime++

                        if ((blackDuck.flyAway==false)&&((blackDuck.lifeTime>=Math.floor(duckMaxLifeTime/blackDuck.animationSpeed))||(gameStatistic.bullet==0))){
                            blackDuck.flyAway=true
                            blackDuck.state="TOP"
                            blackDuck.targetX=blackDuck.x
                            blackDuck.targetY=-100
                            blackDuck.prevSpeed=blackDuck.speed
                            blackDuck.prevAnimationSpeed=blackDuck.animationSpeed

                            blackDuckNeeded=false
                        }

                        if (Math.ceil((Math.floor(Math.abs(blackDuck.x-blackDuck.targetX)))<=blackDuck.epsilon)&&
                                (Math.ceil(Math.floor(Math.abs(blackDuck.y-blackDuck.targetY)))<=blackDuck.epsilon)){
                            blackDuck.targetX=10+Math.random()*800
                            blackDuck.targetY=10+Math.random()*350
                        }
                    }

                    if ((blackDuck.flyAway==true)&&(blackDuck.y<=-50)){
                        if ((!dogTimer.running)&&(!blackDuckNeeded)){
                            gameStatistic.miss++
                            blackDuck.visible=false
                            dog.state="MISS"
                            dog.animationSpeed=100
                            dog.currentFrame=dog.startFrame
                            dog.x=blackDuck.x
                            dog.y=380
                            dog.targetX=blackDuck.x
                            dog.targetY=330
                            if (!mainPage.muted) chienCry.play()
                            initialDuck="BLACK_DUCK"
                            dogTimer.start()
                        }
                        if ((blackDuckNeeded)&&(gameStatistic.total>0)){
                            gameStatistic.total--
                            blackDuck.visible=true
                            blackDuck.state="TOP"
                            blackDuck.x=10+Math.random()*(gameScreen.width-10)
                            blackDuck.y=360
                            blackDuck.prevX=398
                            blackDuck.prevY=362
                            blackDuck.targetX= 10+Math.random()*800
                            blackDuck.targetY= 10+Math.random()*350

                            blackDuck.speed=blackDuck.prevSpeed
                            blackDuck.animationSpeed=blackDuck.prevAnimationSpeed

                            blackDuck.z=3
                            blackDuck.lifeTime=0
                            blackDuck.flyAway=false
                            if (!mainPage.muted) duckFlightSound.play()
                        }
                    }

                    if ((blackDuck.state=="DEAD")&&(blackDuck.y>=378)){
                        if ((!dogTimer.running)&&(!blackDuckNeeded)){
                            if (!mainPage.muted) canardSol.play()
                            blackDuck.visible=false
                            dog.state="CATCH"
                            dog.animationSpeed=20
                            dog.currentFrame=dog.startFrame
                            dog.x=blackDuck.x-blackDuck.width/2
                            dog.y=380
                            dog.targetX=blackDuck.x-blackDuck.width/2
                            dog.targetY=330
                            if (!mainPage.muted) chienRamasse.play()
                            initialDuck="BLACK_DUCK"
                            dogTimer.start()
                        }
                        if ((blackDuckNeeded)&&(gameStatistic.total>0)){
                            gameStatistic.total--
                            blackDuck.visible=true
                            blackDuck.state="TOP"
                            blackDuck.x=10+Math.random()*(gameScreen.width-10)
                            blackDuck.y=360
                            blackDuck.prevX=398
                            blackDuck.prevY=362
                            blackDuck.targetX= 10+Math.random()*800
                            blackDuck.targetY= 10+Math.random()*350

                            blackDuck.speed=blackDuck.prevSpeed
                            blackDuck.animationSpeed=blackDuck.prevAnimationSpeed

                            blackDuck.z=3
                            blackDuck.lifeTime=0
                            blackDuck.flyAway=false
                            if (!mainPage.muted) duckFlightSound.play()
                        }
                    }

                    if (blackDuck.currentFrame==blackDuck.endFrame){
                        blackDuck.currentFrame=blackDuck.startFrame
                    } else {
                        blackDuck.currentFrame++
                    }

                    blackDuck.z=3
                }
            }
        }

        Timer{
            id:brownDuckTimer
            interval:brownDuck.animationSpeed
            running:false
            repeat:true
            onTriggered:{
                if (!mainPage.paused){
                    brownDuck.prevX=brownDuck.x
                    brownDuck.prevY=brownDuck.y

                    brownDuck.x+=Math.ceil(((brownDuck.targetX-brownDuck.x)/Math.abs(brownDuck.targetX-brownDuck.x))*brownDuck.speed)
                    brownDuck.y+=Math.ceil(((brownDuck.targetY-brownDuck.y)/Math.abs(brownDuck.targetY-brownDuck.y))*brownDuck.speed)

                    if ((brownDuck.state!="DEAD")&&(brownDuck.flyAway==false)){
                        if ((Math.abs(brownDuck.x-brownDuck.targetX)<=brownDuck.epsilon)&&(brownDuck.y<=brownDuck.prevY)){
                            if (brownDuck.state!="TOP") {
                                brownDuck.state = "TOP"
                                brownDuck.currentFrame=brownDuck.startFrame
                            }
                        } else if ((Math.abs(brownDuck.x-brownDuck.targetX)<=brownDuck.epsilon)&&(brownDuck.y>=brownDuck.prevY)){
                            if (brownDuck.state!="DOWN") {
                                brownDuck.state = "DOWN"
                                brownDuck.currentFrame=brownDuck.startFrame
                            }
                        } else if (brownDuck.x>=brownDuck.prevX){
                            if (brownDuck.state!="TOP_RIGHT") {
                                brownDuck.state = "TOP_RIGHT"
                                brownDuck.currentFrame=brownDuck.startFrame
                            }
                        } else if (brownDuck.x<=brownDuck.prevX){
                            if (brownDuck.state!="TOP_LEFT") {
                                brownDuck.state = "TOP_LEFT"
                                brownDuck.currentFrame=brownDuck.startFrame
                            }
                        } else {
                            if (brownDuck.state!="TOP") {
                                brownDuck.state = "TOP"
                                brownDuck.currentFrame=brownDuck.startFrame
                            }
                        }

                        brownDuck.lifeTime++

                        if ((brownDuck.flyAway==false)&&((brownDuck.lifeTime>=Math.floor(duckMaxLifeTime/brownDuck.animationSpeed))||(gameStatistic.bullet==0))){
                            brownDuck.flyAway=true
                            brownDuck.state="TOP"
                            brownDuck.targetX=brownDuck.x
                            brownDuck.targetY=-100
                            brownDuck.prevSpeed=brownDuck.speed
                            brownDuck.prevAnimationSpeed=brownDuck.animationSpeed

                            brownDuckNeeded=false
                        }

                        if (Math.ceil((Math.floor(Math.abs(brownDuck.x-brownDuck.targetX)))<=brownDuck.epsilon)&&
                                (Math.ceil(Math.floor(Math.abs(brownDuck.y-brownDuck.targetY)))<=brownDuck.epsilon)){
                            brownDuck.targetX=10+Math.random()*800
                            brownDuck.targetY=10+Math.random()*350
                        }

                    }

                    if ((brownDuck.flyAway==true)&&(brownDuck.y<=-50)){
                        if ((!dogTimer.running)&&(!brownDuckNeeded)){
                            gameStatistic.miss++
                            brownDuck.visible=false
                            dog.state="MISS"
                            dog.animationSpeed=60
                            dog.currentFrame=dog.startFrame
                            dog.x=brownDuck.x
                            dog.y=380
                            dog.targetX=brownDuck.x
                            dog.targetY=330
                            if (!mainPage.muted) chienCry.play()
                            initialDuck="BROWN_DUCK"
                            dogTimer.start()
                        }
                        if ((brownDuckNeeded)&&(gameStatistic.total>0)){
                            gameStatistic.total--
                            brownDuck.visible=true
                            brownDuck.state="TOP"
                            brownDuck.x=10+Math.random()*(gameScreen.width-10)
                            brownDuck.y=360
                            brownDuck.prevX=398
                            brownDuck.prevY=362
                            brownDuck.targetX= 10+Math.random()*800
                            brownDuck.targetY= 10+Math.random()*350

                            brownDuck.speed=brownDuck.prevSpeed
                            brownDuck.animationSpeed=brownDuck.prevAnimationSpeed

                            brownDuck.z=3
                            brownDuck.lifeTime=0
                            brownDuck.flyAway=false
                            if (!mainPage.muted) duckFlightSound.play()
                        }
                    }

                    if ((brownDuck.state=="DEAD")&&(brownDuck.y>=378)){
                        if ((!dogTimer.running)&&(!brownDuckNeeded)){
                            if (!mainPage.muted) canardSol.play()
                            brownDuck.visible=false
                            dog.state="CATCH"
                            dog.animationSpeed=20
                            dog.currentFrame=dog.startFrame
                            dog.x=brownDuck.x-brownDuck.width/2
                            dog.y=380
                            dog.targetX=brownDuck.x-brownDuck.width/2
                            dog.targetY=330
                            if (!mainPage.muted) chienRamasse.play()
                            initialDuck="BROWN_DUCK"
                            dogTimer.start()
                        }

                        if ((brownDuckNeeded)&&(gameStatistic.total>0)){
                            gameStatistic.total--
                            brownDuck.visible=true
                            brownDuck.state="TOP"
                            brownDuck.x=10+Math.random()*(gameScreen.width-10)
                            brownDuck.y=360
                            brownDuck.prevX=398
                            brownDuck.prevY=362
                            brownDuck.targetX= 10+Math.random()*800
                            brownDuck.targetY= 10+Math.random()*350

                            brownDuck.speed=brownDuck.prevSpeed
                            brownDuck.animationSpeed=brownDuck.prevAnimationSpeed

                            brownDuck.z=3
                            brownDuck.lifeTime=0
                            brownDuck.flyAway=false
                            if (!mainPage.muted) duckFlightSound.play()
                        }
                    }

                    if (brownDuck.currentFrame==brownDuck.endFrame){
                        brownDuck.currentFrame=brownDuck.startFrame
                    } else {
                        brownDuck.currentFrame++
                    }

                    brownDuck.z=3
                }
            }
        }

        Timer{
            id:shotAnimationTimer
            interval:shot.animationSpeed
            running:false
            repeat:true
            onTriggered:{
                if (!mainPage.paused){
                    shot.currentFrame++
                    if (shot.currentFrame==shot.framesCount){
                        shotAnimationTimer.stop()
                    }
                }
            }
        }




        MouseArea{
            anchors.fill: parent
            onPressed: {
                if ((!mainPage.paused)&&(dog.state!="START_LEVEL")&&(!initializationFlag)&&(!startMenu.visible)){
                    if (gameStatistic.bullet>0){
                        shot.x=mouseX-shot.width/2
                        shot.y=mouseY-shot.height/2
                        shot.currentFrame=0
                        shotAnimationTimer.start()
                        gameStatistic.bullet--
                        //rumbleEffect.start();
                        if (!mainPage.muted) shotSound.play()

                        if ((mouseX>blackDuck.x)&&(mouseX<(blackDuck.x+blackDuck.width))&&
                                (mouseY>blackDuck.y)&&(mouseY<(blackDuck.y+blackDuck.height))){
                            gameStatistic.kill++
                            blackDuck.state = "DEAD"
                            if (!mainPage.muted) duckDeadSound.play()
                            blackDuck.targetX=blackDuck.x
                            blackDuck.targetY=380
                            blackDuckNeeded=false

                            blackDuck.prevSpeed=blackDuck.speed
                            blackDuck.prevAnimationSpeed=blackDuck.animationSpeed
                            blackDuck.speed=5
                            blackDuck.animationSpeed=50

                            feathers1.x=blackDuck.x-70
                            feathers1.y=blackDuck.y-70

                            feathers1.targetX=blackDuck.x
                            feathers1.targetY=500
                            feathers1.state="START"
                            feathers1.currentFrame=-1
                            feathers1.opacity=1
                            feathers1.visible=true
                            featherTimer.start()
                        }

                        if ((mouseX>brownDuck.x)&&(mouseX<(brownDuck.x+brownDuck.width))&&
                                (mouseY>brownDuck.y)&&(mouseY<(brownDuck.y+brownDuck.height))){
                            gameStatistic.kill++
                            brownDuck.state = "DEAD"
                            if (!mainPage.muted) duckDeadSound.play()
                            brownDuck.targetX=brownDuck.x
                            brownDuck.targetY=380
                            brownDuckNeeded=false

                            brownDuck.prevSpeed=brownDuck.speed
                            brownDuck.prevAnimationSpeed=brownDuck.animationSpeed
                            brownDuck.speed=5
                            brownDuck.animationSpeed=50

                            feathers2.x=brownDuck.x-70
                            feathers2.y=brownDuck.y-70

                            feathers2.targetX=brownDuck.x
                            feathers2.targetY=500
                            feathers2.state="START"
                            feathers2.currentFrame=-1
                            feathers2.opacity=1
                            feathers2.visible=true
                            featherTimer2.start()
                        }
                    } else {
                        if (!mainPage.muted) fireSound.play()
                    }
                }
            }
        }

        Statistics{
            id: gameStatistic
            x: 0
            y: 420
            z: 100
            width: gameScreen.width-80
            height: 60
            visible: false
        }

        Rectangle{
            id: menuButton
            x: gameScreen.width-70
            y: gameScreen.height-70
            z: 100
            width: 60
            height: 60
            visible: ((!startMenu.visible)&&(!newLevelMenu.visible)&&(!gameOverMenu.visible))
            opacity: 0.85
            radius: 15

            Image{
                source: "MEDIA/GFX/menu/menuButton.png"
                anchors.centerIn: parent
                z: parent.z+2
            }

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

            border.color: "black"
            gradient: gradientStandart

            MouseArea{
                anchors.fill:parent
                anchors.bottom: parent.bottom
                width:parent.width
                height: parent.height

                onPressed: menuButton.gradient=gradientPressed
                onReleased: menuButton.gradient=gradientStandart
                onClicked: {
                    gameOverTheme.stop()
                    //mainTheme.stop()
                    startMenu.playButtonImage="MEDIA/GFX/menu/resumeButton.png"
                    startMenu.visible=true
                    mainPage.paused=true
                }
            }
        }

    }

    LevelCompleted{
        id: newLevelMenu
        visible: false
    }

    GameOver{
        id: gameOverMenu
        visible: false
    }

    Timer{
        id:mainGameCycle
        interval:100
        running:true
        repeat:true
        onTriggered:{
            if (initializationFlag)
            {
                //screen.setAllowedOrientations(Screen.Landscape)
                //if (!mainPage.muted) mainTheme.play()
                mainPage.paused=true
                startMenu.playButtonImage="MEDIA/GFX/menu/startNewGameButton.png"
                startMenu.visible=true

                gameStatistic.level=1
                gameStatistic.total=10
                gameStatistic.kill=0
                gameStatistic.miss=0
                gameStatistic.bullet=13

                blackDuck.animationSpeed=100
                blackDuck.speed=5
                blackDuck.epsilon=10
                brownDuck.animationSpeed=100
                brownDuck.speed=5
                brownDuck.epsilon=10

                blackDuck.visible=false
                brownDuck.visible=false

                initializationFlag=false
            }
            if (((gameStatistic.kill+gameStatistic.miss)>=10)&&(!mainPage.paused)&&(!blackDuck.visible)&&(!brownDuck.visible)){
                if (gameStatistic.miss<=3){
                    gameStatistic.total=0
                    mainPage.paused=true
                    newLevelMenu.visible=true

                    blackDuck.visible=false
                    brownDuck.visible=false
                } else {
                    gameStatistic.total=0
                    mainPage.paused=true
                    gameOverMenu.visible=true
                    gameStarted=false
                    if (!mainPage.muted){
                        //mainTheme.stop()
                        gameOverTheme.play()
                    }

                    blackDuck.visible=false
                    brownDuck.visible=false
                }
            }
            if ((!Qt.application.active)&&(gameStarted)){
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
                startMenu.playButtonImage="MEDIA/GFX/menu/resumeButton.png"
                startMenu.visible=true
                mainPage.paused=true
            }
        }
    }
}
