#include "apihelper.h"

/*APIHelper::APIHelper(QObject *parent) : QObject(parent)
{

}*/

APIHelper::APIHelper() {
    request.setOpt(cURLpp::Options::WriteStream(&result));
    request.setOpt<curlpp::options::SslVerifyPeer>(false);
}

void APIHelper::setUrl(QString url) {
    request.setOpt<curlpp::options::Url>(QString::toStdString(url));
}

void APIHelper::perform() {
    // Send request and get a result.
    // By default the result goes to standard output.
    int limit = 10; // Limit of requests
    for(int i = 0; i < limit; i++) {
        try {
            request.perform();
            break;
        } catch(curlpp::RuntimeError & e) {
            std::cout << e.what() << std::endl;
        } catch(curlpp::LogicError & e) {
            std::cout << e.what() << std::endl;
        }
    }
}

std::string APIHelper::getResults() {
    return result.str();
}

Json::Value APIHelper::getResultsAsJson() {
    if(!parsed_root.empty())
        return parsed_root;

    std::string resultstr = result.str();
    bool parsingSuccessful = reader.parse( result.str().c_str(), parsed_root );     //parse process
    if ( !parsingSuccessful ) {
        printf("Failed to parse %s\n",reader.getFormattedErrorMessages().c_str());
        parsed_root = Json::Value(Json::objectValue);
        return parsed_root;
    }
    return parsed_root;
}


void APIHelper::reset() {
    request.reset();
    result.str("");
    request.setOpt(cURLpp::Options::WriteStream(&result));
}

std::string APIHelper::url_encode(const std::string &value) {
    std::ostringstream escaped;
    escaped.fill('0');
    escaped << std::hex;

    for (std::string::const_iterator i = value.begin(), n = value.end(); i != n; ++i) {
        std::string::value_type c = (*i);

        // Keep alphanumeric and other accepted characters intact
        if (isalnum(c) || c == '-' || c == '_' || c == '.' || c == '~') {
            escaped << c;
            continue;
        }

        // Any other characters are percent-encoded
        escaped << std::uppercase;
        escaped << '%' << std::setw(2) << int((unsigned char) c);
        escaped << std::nouppercase;
    }

    return escaped.str();
}
