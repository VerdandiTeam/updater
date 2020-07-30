#ifndef APIHELPER_H
#define APIHELPER_H

#include <QObject>
#include <QString>
#include <curlpp/cURLpp.hpp>
#include <curlpp/Easy.hpp>
#include <curlpp/Options.hpp>
#include <json/json.h>

class APIHelper
{
public:
    explicit APIHelper();
    void setUrl(QString url);
    void perform();
    void reset();
    std::string url_encode(const std::string &value);
    std::string getResults();
    Json::Value getResultsAsJson();

signals:

public slots:

private:
    // Our request to be sent.
    curlpp::Easy request;

    // Result
    std::stringstream result;

    // Parser
    Json::Reader reader;

    // Parsed
    Json::Value parsed_root;
};

#endif // APIHELPER_H
