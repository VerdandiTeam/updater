#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <string>

using std::string;

class Core : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int version READ version WRITE setVersion NOTIFY versionChanged)
public:
    explicit Core(QObject *parent = nullptr);

    string version();
    void setVersion(int version);

    Q_INVOKABLE void makeUpdate();


signals:
    void versionChanged(int version);

public slots:

private:
    string _version = "-1";
};

#endif // CORE_H
