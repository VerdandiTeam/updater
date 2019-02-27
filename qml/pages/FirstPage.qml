import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Vault 1.0
import Sailfish.Policy 1.0
import org.nemomobile.configuration 1.0
import org.nemomobile.systemsettings 1.0
import com.jolla.settings.sailfishos 1.0
import com.jolla.settings.system 1.0 as MdmBanner
import Nemo.Ssu 1.1

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        /*PullDownMenu {
            MenuItem {
                text: qsTr("Show Page 2")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }*/

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Hello there cunt m8")
            }
            /*Label {
                x: Theme.horizontalPageMargin
                text: qsTr("Hello Sailors")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }*/
            Image {
                source: storeIf.osCover
            }
        }
    }
}
