#include "core.h"
#include <QDebug>

Core::Core(QObject *parent) : QObject(parent)
{
    _updateWorker.moveToThread(&_workerThread);

    connect(&_workerThread, &QThread::started, &_updateWorker, &UpdateWorker::update);
    connect(&_updateWorker, &UpdateWorker::finished, &_workerThread, &QThread::quit);

    connect(&_ssuReleaseProcess, static_cast<void (QProcess::*)(int)>(&QProcess::finished), this, &Core::onSsuChange);
    connect(&_zypperClean, static_cast<void (QProcess::*)(int)>(&QProcess::finished), this, &Core::onZypperCleaned);
    connect(&_zypperRefresh, static_cast<void (QProcess::*)(int)>(&QProcess::finished), this, &Core::onZypperRefreshed);
    connect(&_versionUpgrade, static_cast<void (QProcess::*)(int)>(&QProcess::finished), this, &Core::onUpgradeFinished);
}

QString Core::version()
{
    return _version;
}

void Core::setVersion(QString version)
{
    _version = version;

    emit versionChanged(_version);
}

void Core::makeUpdate()
{
    QStringList params;
    params << "re";
    params << _version;
    _ssuReleaseProcess.start("/usr/bin/ssu", params, QIODevice::OpenModeFlag::ReadWrite);
}

void Core::onSsuChange(int exitCode)
{
    if (exitCode != 0) {
        qDebug() << "Okurwa japierdoleeeee ssu";
        emit ssuFailed();
        return;
    }

    QStringList params;
    params << "clean";
    params << "-a";
    _zypperClean.start("/usr/bin/zypper", params, QIODevice::OpenModeFlag::ReadWrite);
}

void Core::onZypperCleaned(int exitCode)
{
    if (exitCode != 0) {
        qDebug() << "Okurwa japierdoleeeee zypper cleaned";
        emit zypperCleanFailed();
        return;
    }

    QStringList params;
    params << "refresh";
    params << "-f";
    _zypperRefresh.start("/usr/bin/zypper", params, QIODevice::OpenModeFlag::ReadWrite);
}

void Core::onZypperRefreshed(int exitCode)
{
    if (exitCode != 0) {
        qDebug() << "Okurwa japierdoleeeee zypper refresh";
        emit zypperRefreshFailed();
        return;
    }

    QStringList params;
    params << "dup";
    _zypperRefresh.start("/usr/bin/version", params, QIODevice::OpenModeFlag::ReadWrite);
}

void Core::onUpgradeFinished(int exitCode)
{
    if (exitCode != 0) {
        qDebug() << "Okurwa japierdoleeeee version dup";
        emit upgradeFailed();
        return;
    }

    emit upgradeFinished();
}
