#include "core.h"

Core::Core(QObject *parent) : QObject(parent)
{
    _updateWorker.moveToThread(&_workerThread);

    connect(&_workerThread, &QThread::started, &_updateWorker, &UpdateWorker::update);
    connect(&_updateWorker, &UpdateWorker::finished, &_workerThread, &QThread::quit);
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
    _workerThread.start();
}
