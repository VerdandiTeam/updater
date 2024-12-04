#include "core.h"
#include <QDebug>
#include <QRegularExpression>

Core::Core(QObject *parent) : QObject(parent), _outputLog("/var/log/update.log")
{
    _outputLog.open(QIODevice::ReadWrite | QIODevice::Truncate);

    connect(&_ssuReleaseProcess, static_cast<void (QProcess::*)(int)>(&QProcess::finished), this, &Core::onSsuChange);
    connect(&_ssuReleaseProcess, &QProcess::readyReadStandardOutput, this, &Core::onSsuOutput);
    connect(&_ssuReleaseProcess, &QProcess::readyReadStandardError, this, &Core::onSsuErrorOutput);
    connect(&_zypperClean, static_cast<void (QProcess::*)(int)>(&QProcess::finished), this, &Core::onZypperCleaned);
    connect(&_zypperClean, &QProcess::readyReadStandardOutput, this, &Core::onZypperCleanOutput);
    connect(&_zypperClean, &QProcess::readyReadStandardError, this, &Core::onZypperCleanErrorOutput);
    connect(&_zypperRefresh, static_cast<void (QProcess::*)(int)>(&QProcess::finished), this, &Core::onZypperRefreshed);
    connect(&_zypperRefresh, &QProcess::readyReadStandardOutput, this, &Core::onZypperRefreshOutput);
    connect(&_zypperRefresh, &QProcess::readyReadStandardError, this, &Core::onZypperRefreshErrorOutput);
    connect(&_versionUpgrade, static_cast<void (QProcess::*)(int)>(&QProcess::finished), this, &Core::onUpgradeFinished);
    connect(&_versionUpgrade, &QProcess::readyReadStandardOutput, this, &Core::onVersionOutput);
    connect(&_versionUpgrade, &QProcess::readyReadStandardError, this, &Core::onVersionErrorOutput);
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

    setCurrentStep(SSU);
}

QString Core::getCurrentStep() const
{
    switch (_currentStep) {
    case START:
        return tr("Beginning update");
        break;
    case SSU:
        return tr("Setting ssu release");
        break;
    case CLEAN:
        return tr("Cleaning zypper repos");
        break;
    case REFRESH:
        return tr("Refreshing zypper repos");
        break;
    case DUP:
        return tr("Upgrading");
        break;
    case FINISHED:
        return tr("Finished, reboot now!");
        break;
    default:
        return "";
    }
}

void Core::setCurrentStep(int step)
{
    _currentStep = step;

    emit currentStepChanged(getCurrentStep());
    emit progressChanged();
}

QString Core::getProgressOutput() const
{
    return _progressOutput;
}

int Core::getProgress() const
{
    switch (_currentStep) {
    case SSU:
        return 12;
        break;
    case CLEAN:
        return 25;
        break;
    case REFRESH:
        return 37;
        break;
    case DUP:
        return 50 + (_dupProgress > 0 ? _dupProgress/2 : 0);
        break;
    case FINISHED:
        return 100;
        break;
    case START:
    default:
        return 0;
    }
}

void Core::onSsuChange(int exitCode)
{
    if (exitCode != 0) {
        emit ssuFailed();
        return;
    }

    QStringList params;
    params << "clean";
    params << "-a";
    _zypperClean.start("/usr/bin/zypper", params, QIODevice::OpenModeFlag::ReadWrite);

    setCurrentStep(CLEAN);
}

void Core::onZypperCleaned(int exitCode)
{
    if (exitCode != 0) {
        emit zypperCleanFailed();
        return;
    }

    QStringList params;
    params << "refresh";
    params << "-f";
    _zypperRefresh.start("/usr/bin/zypper", params, QIODevice::OpenModeFlag::ReadWrite);

    setCurrentStep(REFRESH);
}

void Core::onZypperRefreshed(int exitCode)
{
    if (exitCode != 0) {
        emit zypperRefreshFailed();
        return;
    }

    QStringList params;
    params << "--dup";
    _versionUpgrade.start("/usr/bin/version", params, QIODevice::OpenModeFlag::ReadWrite);

    setCurrentStep(DUP);
}

void Core::onUpgradeFinished(int exitCode)
{
    if (exitCode != 0) {
        emit upgradeFailed();
        return;
    }

    _outputLog.flush();

    setCurrentStep(FINISHED);
}

void Core::onSsuOutput()
{
    readStandardOutput(&_ssuReleaseProcess);
}

void Core::onZypperCleanOutput()
{
    readStandardOutput(&_zypperClean);
}

void Core::onZypperRefreshOutput()
{
    readStandardOutput(&_zypperRefresh);
}

void Core::onVersionOutput()
{
    readStandardOutput(&_versionUpgrade);
}

void Core::onSsuErrorOutput()
{
    readStandardError(&_ssuReleaseProcess);
}

void Core::onZypperCleanErrorOutput()
{
    readStandardError(&_zypperClean);
}

void Core::onZypperRefreshErrorOutput()
{
    readStandardError(&_zypperRefresh);
}

void Core::onVersionErrorOutput()
{
    readStandardError(&_versionUpgrade);
}

void Core::readStandardOutput(QProcess *process)
{
    QString output = process->readAllStandardOutput();

    _progressOutput.append(output);
    _progressOutput = _progressOutput.right(10000);

    _outputLog.write(output.toUtf8());

    emit progressOutputChanged(_progressOutput);
}

void Core::readStandardError(QProcess *process)
{
    QString output = process->readAllStandardError();

    _progressOutput.append(output);
    _progressOutput = _progressOutput.right(10000);

    extractProgress();

    _outputLog.write(output.toUtf8());

    emit progressOutputChanged(_progressOutput);
}

void Core::extractProgress()
{
    QRegularExpression re("\\[(\\d+)\\s?%\\] \\[Download\\]");
    re.setPatternOptions(QRegularExpression::MultilineOption);
    QRegularExpressionMatchIterator i = re.globalMatch(_progressOutput);
    while (i.hasNext()) {
        QRegularExpressionMatch match = i.next();
        _dupProgress = match.captured(1).toInt() / 2;
    }

    QRegularExpression re2("\\[(\\d+)\\s?%\\] \\[Install\\]");
    re2.setPatternOptions(QRegularExpression::MultilineOption);
    i = re2.globalMatch(_progressOutput);
    while (i.hasNext()) {
        QRegularExpressionMatch match = i.next();
        _dupProgress = 50 + (match.captured(1).toInt() / 2);
    }

    emit progressChanged();
}
