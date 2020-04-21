#include "passerelle.h"
#include<QDebug>

passerelle::passerelle(QObject *parent) : QObject(parent)
{

}

QString passerelle::getAppName()
{
    return "YBTimeline";
}

void passerelle::getTimelineDatas()
{
    QString url_str = "http://api.yoannbraie.fr/timeline";
    HttpRequestInput input(url_str, "GET");
    HttpRequestWorker *worker = new HttpRequestWorker(this);
    connect(worker, SIGNAL(on_execution_finished(HttpRequestWorker*)), this, SLOT(handle_timeline_result(HttpRequestWorker*)));
    worker->execute(&input);
}

void passerelle::handle_timeline_result(HttpRequestWorker *worker) {
    QString msg;

    if (worker->error_type == QNetworkReply::NoError) {
        msg = worker->response;
    }
    else {
        msg = worker->error_str;
    }

    emit timelineDatasReceived(msg);
}
