import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.systemsettings 1.0


Page {
    id: page

    DeviceInfo { id: deviceInfo }
    AboutSettings { id: aboutSettings }

    property bool otaAvaliable: false

    Component.onCompleted: {
        //core.version = aboutSettings.softwareVersionId

        var data = JSON.parse('{"sfos_version":"4.6.0.13","has_ota":true,"has_logo":false}')

        core.version = data.sfos_version

        getVersion()
    }

    function getVersion() {
        var doc = new XMLHttpRequest();

        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status === 200) {
                    console.log("ok")
                    var data = JSON.parse(doc.responseText)

                    core.version = data.sfos_version
                    page.otaAvaliable = data.has_ota
                } else {
                    console.log("not ok")
                    core.version = qsTr("Not available")

                    page.otaAvaliable = false
                }
            }
        }

        doc.open("GET", "http://verdanditeam.com/api/device/" + deviceInfo.model)
        doc.send()
    }

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent
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

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Check for updates"
                onClicked: getVersion()
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
                text: qsTr("Vendor: %1").arg(deviceInfo.manufacturer)
            }
            Label {
                text: qsTr("Model: %1").arg(deviceInfo.prettyName)
            }
            Label {
                text: qsTr("OBS availability: %1").arg(page.otaAvaliable ? qsTr("Available") : qsTr("Not available"))
            }
            Label {
                text: qsTr("Installed version: %1").arg(aboutSettings.softwareVersionId)
            }
            Label {
                text: qsTr("Latest OBS version: %1").arg(page.otaAvaliable ? core.version : qsTr("Not available"))
            }
            Label {
                text: qsTr("Created by Mister_Magister and Keijo\nbanner photo is courtesy of Jolla Oy")
                font.pixelSize: Theme.fontSizeTiny
            }
        }
    }
}
