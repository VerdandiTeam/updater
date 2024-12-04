#ifndef CORE_H
#define CORE_H

#include <QFile>
#include <QObject>
#include <QProcess>
#include <QThread>

class Core : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString version READ version WRITE setVersion NOTIFY versionChanged)
    Q_PROPERTY(QString currentStep READ getCurrentStep NOTIFY currentStepChanged)
    Q_PROPERTY(QString progressOutput READ getProgressOutput NOTIFY progressOutputChanged)
    Q_PROPERTY(int progress READ getProgress NOTIFY progressChanged)
public:
    enum UpdateSteps {
        START,
        SSU,
        CLEAN,
        REFRESH,
        DUP,
        FINISHED
    };

    explicit Core(QObject *parent = nullptr);

    QString version();
    void setVersion(QString version);

    Q_INVOKABLE void makeUpdate();
    QString getCurrentStep() const;
    void setCurrentStep(int step);
    QString getProgressOutput() const;
    int getProgress() const;

signals:
    void versionChanged(QString version);
    void ssuFailed();
    void zypperCleanFailed();
    void zypperRefreshFailed();
    void upgradeFailed();
    void currentStepChanged(QString currentStep);
    void progressOutputChanged(QString progressOutput);
    void progressChanged();

public slots:
    void onSsuChange(int exitCode);
    void onZypperCleaned(int exitCode);
    void onZypperRefreshed(int exitCode);
    void onUpgradeFinished(int exitCode);
    void onSsuOutput();
    void onZypperCleanOutput();
    void onZypperRefreshOutput();
    void onVersionOutput();
    void onSsuErrorOutput();
    void onZypperCleanErrorOutput();
    void onZypperRefreshErrorOutput();
    void onVersionErrorOutput();

private:
    void readStandardOutput(QProcess *process);
    void readStandardError(QProcess *process);
    void extractProgress();

private:
    QFile _outputLog;
    QString _version = "-1";
    int _currentStep = START;
    QThread _workerThread;
    QProcess _ssuReleaseProcess;
    QProcess _zypperClean;
    QProcess _zypperRefresh;
    QProcess _versionUpgrade;
    QString _progressOutput;
    int _dupProgress = 0;
};

#endif // CORE_H
