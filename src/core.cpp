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
<<<<<<< HEAD
    emit versionChanged(version);
=======
    emit versionChanged(_version);
>>>>>>> 6f6ce028af3727798ef329d1d914d0c189aeb372
}

void Core::makeUpdate()
{

}
