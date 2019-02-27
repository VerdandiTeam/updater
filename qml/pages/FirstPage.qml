import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.systemsettings 1.0


Page {
    id: page

    DeviceInfo { id: deviceInfo }
    AboutSettings { id: aboutSettings }

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent
        Image {
            id: banner
            source: "/usr/share/store-client/graphics/Sailfish-OS-update-promo.jpg"
            width: Screen.width
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

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Check for updates"
                //text: qsTr("Show Page 2")
                //onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
            MenuItem {
                text: "Update"
                enabled: false
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            anchors.top: banner.bottom
            anchors.topMargin: Theme.paddingLarge*1.25
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            id: column

            width: page.width
            spacing: Theme.paddingLarge

            Label {
                text: qsTr("Vendor: " + deviceInfo.manufacturer)
            }
            Label {
                text: qsTr("Model: " + deviceInfo.prettyName)
            }
            Label {
                text: qsTr("OBS availability: " + "¯\\_(ツ)_/¯")
            }
            Label {
                text: qsTr("Installed version: " + aboutSettings.softwareVersion)
            }
            Label {
                text: qsTr("Latest OBS version: " + "¯\\_(ツ)_/¯")
            }
            Label {
                text: qsTr("Created by Mister_Magister and Keijo\nbanner photo is courtesy of Jolla Oy")
                font.pixelSize: Theme.fontSizeTiny
            }
        }
    }
}
