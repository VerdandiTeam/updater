#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include "core.h"
#include "checker.h"

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QSharedPointer<QQuickView> view(SailfishApp::createView());

    Core core;
    checker checker;

    view->rootContext()->setContextProperty("core", &core);
    view->rootContext()->setContextProperty("checker", &checker);
//    view->rootContext()->setContextProperty("apiHelper", &apiHelper);

    view->setSource(SailfishApp::pathTo("qml/verdandiupdater-sfos.qml"));
    view->show();

    return app->exec();
}
