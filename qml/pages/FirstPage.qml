import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

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
            Image {
                source: "qrc:///images/g3775.png"
                width: parent.width/2
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                fillMode: Image.PreserveAspectFit
                horizontalAlignment: Image.AlignLeft
                anchors.leftMargin: Theme.paddingSmall
                anchors.bottomMargin: Theme.paddingSmall
            }
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
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            anchors.top: banner.bottom
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            /*PageHeader {
                title: qsTr("Hello there cunt m8")
            }*/
            Label {
                //x: Theme.horizontalPageMargin
                text: qsTr("Hello Sailors")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
        }
    }
}
