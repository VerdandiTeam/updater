import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.systemsettings 1.0
import Nemo.DBus 2.0

Page {
    id: page

    DeviceInfo { id: deviceInfo }
    AboutSettings { id: aboutSettings }

    property bool otaAvaliable: false
    property bool updateAvailable: false
    property string updateVersion: ""

    Component.onCompleted: {
        getVersion()
    }

    DBusInterface {
        id: dbusInterface

        service: 'com.verdanditeam.updater'
        path: '/'
        iface: 'com.verdanditeam.updater'
    }

    function getVersion() {
        var doc = new XMLHttpRequest();

        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status === 200) {
                    var data = JSON.parse(doc.responseText)

                    page.updateVersion = data.sfos_version
                    page.otaAvaliable = data.has_ota
                    if(page.otaAvaliable) {
                        page.updateAvailable = compareVersions()
                    }
                } else {
                    page.updateVersion = qsTrId("verdandiupdater-not-available")

                    page.otaAvaliable = false
                }
            }
        }

        doc.open("GET", "https://verdanditeam.com/api/device/" + deviceInfo.model)
        doc.send()
    }

    function compareVersions() {
        var current = aboutSettings.softwareVersionId.split('.')
        var future = page.updateVersion.split('.')

        for(var i = 0; i < current.length; i++) {
            if(future[i] > current[i]) {
                return true
            }
        }

        return false
    }

    allowedOrientations: Orientation.All

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
            source: "/usr/share/verdandiupdater-sfos/qml/resources/images/g3775.png"
            width: banner.width/2
            anchors.left: logoBG.left
            anchors.bottom: logoBG.bottom
            fillMode: Image.PreserveAspectFit
            horizontalAlignment: Image.AlignLeft
            verticalAlignment: Image.AlignBottom
            anchors.leftMargin: Theme.paddingSmall
            anchors.bottomMargin: Theme.paddingSmall
        }

        PullDownMenu {
            MenuItem {
                text: qsTrId("verdandiupdater-check-for-updates")
                onClicked: getVersion()
            }
            MenuItem {
                text: qsTrId("verdandiupdater-update")
                enabled: page.updateAvailable
                onClicked: dbusInterface.call('update', [page.updateVersion])
            }
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
                text: qsTrId("verdandiupdater-vendor").arg(deviceInfo.manufacturer)
            }

            Label {
                text: qsTrId("verdandiupdater-model").arg(deviceInfo.prettyName)
            }

            Label {
                text: qsTrId("verdandiupdater-ota-availability").arg(page.otaAvaliable ? qsTrId("verdandiupdater-available") : qsTrId("verdandiupdater-not-available"))
            }

            Label {
                text: qsTrId("verdandiupdater-installed-version").arg(aboutSettings.softwareVersionId)
            }

            Label {
                text: qsTrId("verdandiupdater-latest-version").arg(page.otaAvaliable ? page.updateVersion : qsTrId("verdandiupdater-not-available"))
            }

            Label {
                text: qsTrId("verdandiupdater-credits")
                font.pixelSize: Theme.fontSizeTiny
            }
        }
    }
}
