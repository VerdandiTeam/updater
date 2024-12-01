#include "core.h"
#include <QDebug>

Core::Core(QObject *parent) : QObject(parent)
{
    _updateWorker.moveToThread(&_workerThread);

    connect(&_workerThread, &QThread::started, &_updateWorker, &UpdateWorker::update);
    connect(&_updateWorker, &UpdateWorker::finished, &_workerThread, &QThread::quit);

    connect(&_ssuReleaseProcess, static_cast<void (QProcess::*)(int)>(&QProcess::finished), this, &Core::onSsuChange);
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
        qDebug() << "Okurwa japierdoleeeee";
    }
}
