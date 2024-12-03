import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.systemsettings 1.0

Page {
    id: page

    backNavigation: false
    allowedOrientations: Orientation.All

    Connections {
        id: coreConnections
        target: core

        onSsuFailed: {
             page.backgroundColor = "cyan"
        }

        onZypperCleanFailed: {
            page.backgroundColor = "cyan"
        }

        onZypperRefreshFailed: {
             page.backgroundColor = "cyan"
        }

        onUpgradeFailed: {
             page.backgroundColor = "cyan"
        }

        onUpgradeFinished: {
             page.backgroundColor = "cyan"
        }
    }

    Component.onCompleted: core.makeUpdate()

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Image {
            id: banner
            source: "/usr/share/store-client/graphics/Sailfish-OS-update-promo.jpg"
            anchors.left: parent.left
            anchors.right: parent.right
            height: 0.2*Screen.height
            fillMode: Image.PreserveAspectCrop
        }

        Rectangle {
            id: logoBG
            color: Qt.rgba(0, 0, 0, 1)
            anchors.left: banner.left
            anchors.bottom: banner.bottom
            width: banner.width
            height: banner.height/3
        }

        OpacityRampEffect {
            sourceItem: logoBG
            direction: OpacityRamp.BottomToTop
            offset: 0
            slope: 1.0
        }

        Image {
            id: logo
            source: "qrc:///images/g3775.png"
            width: banner.width/2
            anchors.left: logoBG.left
            anchors.bottom: logoBG.bottom
            fillMode: Image.PreserveAspectFit
            horizontalAlignment: Image.AlignLeft
            verticalAlignment: Image.AlignBottom
            anchors.leftMargin: Theme.paddingSmall
            anchors.bottomMargin: Theme.paddingSmall
        }

        Column {
            anchors.top: banner.bottom
            anchors.topMargin: Theme.paddingLarge*1.25
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            id: column

            width: page.width
            spacing: Theme.paddingLarge

            Label {
                text: qsTr("Current step: %1").arg(core.currentStep)
            }

            TextArea {
                height: page.height/2
                text: core.progressOutput
            }
        }
    }
}
