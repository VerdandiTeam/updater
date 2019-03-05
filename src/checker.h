#ifndef CHECKER_H
#define CHECKER_H

#include <QObject>
#include <string>

using std::string;

class checker : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(string currentVersion WRITE setCurrentVersion)
    Q_PROPERTY(string newVersion READ getNewVersion NOTIFY newVersionChanged)
    Q_PROPERTY(bool updateAvailable READ getUpdateAvailable NOTIFY updateAvailableChanged)
public:
    explicit checker(QObject *parent = nullptr);

    Q_INVOKABLE void setCurrentVersion(string version);
    void setNewVersion(string version);
    void setUpdateAvailable(bool update);
    string getNewVersion();
    bool getUpdateAvailable();

signals:
    void newVersionChanged(string version);
    void updateAvailableChanged(bool update);

public slots:

private:
    string currentVersion = "";
    string newVersion = "";
    bool updateAvailable = false;
};

#endif // CHECKER_H
