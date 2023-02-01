import ballerina/sql;
import ballerina/http;
import ballerinax/mssql.driver as _;
import ballerina/io;
import ballerinax/mssql;

configurable int servicePort = 9090;

configurable string user = ?;
configurable string host = ?;
configurable string database = ?;
configurable int dbPort = ?;
configurable string password = ?;

mssql:Options mssqlOptions = {
    secureSocket: {
        encrypt: true,
        trustServerCertificate: true
    }
};

public type Id record {|
    string id;
|};

type NationalIdRecord record {
    string NationalId;
    string FullName;
    string HomeAddress;
};

service /id on new http:Listener(servicePort) {

    function init() returns error? {
        mssql:Client|sql:Error dbClient = new(host, user, password, database, dbPort);//, options=mssqlOptions);
        if dbClient is error {
            io:println("ERROR connecting to Azure DB!!");
            return dbClient;
        }
    }
    
    resource function post verify(@http:Payload Id id) returns error? {
        mssql:Client|sql:Error dbClient = new(host, user, password, database, dbPort, options=mssqlOptions);
        if dbClient is error {
            io:println("ERROR connecting to Azure DB!!");
            return dbClient;
        }

        // test the connection
        sql:ParameterizedQuery query = `SELECT * from NATIONAL_ID`;
        stream<NationalIdRecord, sql:Error?> resultStream = dbClient->query(query);

        check from NationalIdRecord result in resultStream
        do {
            io:println(result);
        };
    }

    resource function get verify(string id) returns error? {
        mssql:Client|sql:Error dbClient = new(host=host, user=user, password=password, database=database, port=dbPort);
        if dbClient is error {
            io:println("ERROR connecting to Azure DB!!");
            return dbClient;
        }

        // test the connection
        sql:ParameterizedQuery query = `SELECT * from NATIONAL_ID`;
        stream<NationalIdRecord, sql:Error?> resultStream = dbClient->query(query);

        check from NationalIdRecord result in resultStream
        do {
            io:println(result);
        };
    }
}