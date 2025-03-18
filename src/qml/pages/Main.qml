import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.systemsettings 1.0
import Nemo.KeepAlive 1.2
import Nemo.DBus 2.0

Page {
    id: page

    KeepAlive {
        enabled: true
    }

    DisplayBlanking {
        preventBlanking: true
    }

    DBusAdaptor {
        id: shareDBusInterface
        service: "com.verdanditeam.updater"
        path: "/"
        iface: "com.verdanditeam.updater"
        xml: '<interface name="com.verdanditeam.updter">
                  <method name="update"> <arg type="s" name="version" direction="in"/> </method>
              </interface>'

        function update(version) {
            core.version = version
            core.makeUpdate()
        }
    }

    backNavigation: updateFailed
    allowedOrientations: Orientation.All

    property bool updateFailed: false

    Connections {
        id: coreConnections
        target: core

        onSsuFailed: {
            page.updateFailed = true
        }

        onZypperCleanFailed: {
            page.updateFailed = true
        }

        onZypperRefreshFailed: {
            page.updateFailed = true
        }

        onUpgradeFailed: {
            page.updateFailed = true
        }

        onProgressOutputChanged: {
            progressOutput.focus = true
        }
    }

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
            onStatusChanged: {
                 if (status == Image.Error) {
                    source = "/usr/share/os-update-service/graphics/Sailfish-OS-update-promo.jpg"
                 }
           }
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
                id: currentStepLabel
                text: page.updateFailed ? qsTr("Update failed.") : core.currentStep
                font.pointSize: Theme.fontSizeExtraLarge
                font.bold: true
                color: page.updateFailed ? "red" : Theme.primaryColor
            }

            ProgressBar {
                id: progress
                width: parent.width
                value: core.progress
                minimumValue: 0
                maximumValue: 100
                valueText: value + " %"
            }

            TextArea {
                id: progressOutput
                height: page.height - banner.height - currentStepLabel.height - progress.height - Theme.paddingLarge*4
                width: page.width - Theme.horizontalPageMargin*2
                text: core.progressOutput
                color: Theme.primaryColor
                cursorPosition: length-1
                readOnly: true
                focus: true
                onFocusChanged: forceActiveFocus()
            }
        }
    }
}
