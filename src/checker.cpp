#include "checker.h"

checker::checker(QObject *parent) : QObject(parent)
{

}

void checker::setCurrentVersion(string version)
{
    currentVersion = version;
}

void checker::setNewVersion(string version)
{
    newVersion = version;
    emit newVersionChanged(version);
}

void checker::setUpdateAvailable(bool update)
{
    updateAvailable = update;
    emit updateAvailableChanged(update);
}

string checker::getNewVersion()
{
    return newVersion;
}

bool checker::getUpdateAvailable()
{
    return updateAvailable;
}
