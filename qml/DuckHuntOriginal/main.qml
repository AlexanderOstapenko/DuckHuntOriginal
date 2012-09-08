import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.feedback 1.1

PageStackWindow {
    id: appWindow

    showStatusBar: false
    initialPage: mainPage

    MainPage {
        id: mainPage
    }

    HapticsEffect {
        id: rumbleEffect
        attackIntensity: 0.0
        attackTime: 0
        intensity: 1.0
        duration: 250
        fadeTime: 0
        fadeIntensity: 0.0
    }
}
