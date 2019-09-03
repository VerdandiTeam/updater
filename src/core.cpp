#include "core.h"

Core::Core(QObject *parent) : QObject(parent)
{

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

}
