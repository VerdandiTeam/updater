#ifndef UPDATEWORKER_H
#define UPDATEWORKER_H

#include <QObject>

class UpdateWorker : public QObject
{
    Q_OBJECT
public:
    explicit UpdateWorker(QObject *parent = nullptr);

public slots:
    void update();

signals:
    void finished();
};

#endif // UPDATEWORKER_H
