#ifndef CORE_H
#define CORE_H

#include "updateworker.h"

#include <QObject>
#include <QProcess>
#include <QThread>

class Core : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString version READ version WRITE setVersion NOTIFY versionChanged)
public:
    explicit Core(QObject *parent = nullptr);

    QString version();
    void setVersion(QString version);

    Q_INVOKABLE void makeUpdate();


signals:
    void versionChanged(QString version);

public slots:
    void onSsuChange(int exitCode);

private:
    QString _version = "-1";
    QThread _workerThread;
    UpdateWorker _updateWorker;
    QProcess _ssuReleaseProcess;
    QProcess _zypperClean;
    QProcess _zypperRefresh;
    QProcess _versionUpgrade;
};

#endif // CORE_H
