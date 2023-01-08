import ballerina/sql;
import ballerina/http;
import ballerinax/mssql.driver as _;
import ballerinax/mssql;

configurable int servicePort = ?;

configurable string user = ?;
configurable string host = "grama-app-server.database.windows.net";
configurable string database = ?;
configurable int dbPort = ?;
configurable string password = ?;

type Id record {|
    string id;
|};

service /id on new http:Listener(servicePort) {
    
    resource function post verify(@http:Payload Id id) {
        mssql:Client|sql:Error dbClient = new();
    }
}