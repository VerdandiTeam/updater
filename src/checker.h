#ifndef CHECKER_H
#define CHECKER_H

#include <QObject>
#include <QString>
#include <iomanip>

class checker : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(QString currentVersion WRITE setCurrentVersion)
    Q_PROPERTY(QString newVersion READ getNewVersion NOTIFY newVersionChanged)
    Q_PROPERTY(bool updateAvailable READ getUpdateAvailable NOTIFY updateAvailableChanged)
public:
    explicit checker(QObject *parent = nullptr);

    Q_INVOKABLE void setCurrentVersion(QString version);
    void setNewVersion(QString version);
    void setUpdateAvailable(bool update);
    QString getNewVersion();
    bool getUpdateAvailable();

signals:
    void newVersionChanged(QString version);
    void updateAvailableChanged(bool update);

public slots:

private:
    QString currentVersion = "";
    QString newVersion = "";
    bool updateAvailable = false;
};

#endif // CHECKER_H
