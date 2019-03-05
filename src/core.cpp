#include "core.h"

Core::Core(QObject *parent) : QObject(parent)
{

}

string Core::version()
{
    return _version;
}

void Core::setVersion(int version)
{
    _version = version;
    emit versionChanged(version);
}

void Core::makeUpdate()
{

}
