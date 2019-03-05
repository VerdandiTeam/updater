#include "core.h"

Core::Core(QObject *parent) : QObject(parent)
{

}

int Core::version()
{
    return _version;
}

void Core::setVersion(int version)
{
    _version = version;
    emit versionChanged(_version);
}

void Core::makeUpdate()
{

}
