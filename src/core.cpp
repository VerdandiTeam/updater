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
    emit versionChaned(version);
}

void Core::makeUpdate()
{

}
