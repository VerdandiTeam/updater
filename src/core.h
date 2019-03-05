#ifndef CORE_H
#define CORE_H

#include <QObject>

class Core : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int version READ version WRITE setVersion NOTIFY versionChanged)
public:
    explicit Core(QObject *parent = nullptr);

    int version();
    void setVersion(int version);

    Q_INVOKABLE void makeUpdate();


signals:
    void versionChaned(int version);

public slots:

private:
    int _version = -1;
};

#endif // CORE_H
