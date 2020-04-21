#ifndef PASSERELLE_H
#define PASSERELLE_H

#include <QObject>
#include "httprequestworker.h"

class passerelle:public QObject
{
Q_OBJECT
public:
    explicit passerelle(QObject *parent = 0);
signals:
    void timelineDatasReceived(QString timelineDatas);
public slots:
    QString getAppName();
    void getTimelineDatas();
    void handle_timeline_result(HttpRequestWorker *worker);
private:
    QString timelineDatas;
};

#endif // PASSERELLE_H
