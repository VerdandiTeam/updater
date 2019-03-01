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
    void serVersion(int version);


signals:
    void versionChaned(int version);

public slots:

private:
    int _version = null;
};

#endif // CORE_H
