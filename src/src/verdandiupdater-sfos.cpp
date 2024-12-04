#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include "core.h"
#include <unistd.h>
#include <sys/types.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setSetuidAllowed(true);
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QSharedPointer<QQuickView> view(SailfishApp::createView());

    setuid(0);

    Core core;

    view->rootContext()->setContextProperty("core", &core);

    view->setSource(SailfishApp::pathTo("qml/verdandiupdater-sfos.qml"));
    view->show();

    return app->exec();
}
