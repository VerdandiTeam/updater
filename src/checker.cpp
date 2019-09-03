#include "checker.h"

checker::checker(QObject *parent) : QObject(parent)
{

}

void checker::setCurrentVersion(QString version)
{
    currentVersion = version;
}

void checker::setNewVersion(QString version)
{
    newVersion = version;
    emit newVersionChanged(version);
}

void checker::setUpdateAvailable(bool update)
{
    updateAvailable = update;
    emit updateAvailableChanged(update);
}

QString checker::getNewVersion()
{
    return newVersion;
}

bool checker::getUpdateAvailable()
{
    return updateAvailable;
}
