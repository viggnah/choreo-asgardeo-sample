CREATE TABLE NATIONAL_ID (
    NationalId INT NOT NULL,
    PRIMARY KEY(NationalId),
    FullName VARCHAR(255),
    HomeAddress VARCHAR(1000)
);
INSERT INTO NATIONAL_ID(NationalId, FullName, HomeAddress) VALUES(1, 'John Roe', 'No 1, Park Road, Colombo');
INSERT INTO NATIONAL_ID(NationalId, FullName, HomeAddress) VALUES(2, 'May Johnson', 'No 125, Shoe Road, Colombo');


CREATE TABLE CRIMINAL_RECORDS (
    NationalId INT NOT NULL,
	CriminalCaseId INT NOT NULL,
    EntryDate DATE,
    PRIMARY KEY(NationalId, CriminalCaseId),
    FOREIGN KEY(NationalId) REFERENCES NATIONAL_ID(NationalId)
);
INSERT INTO CRIMINAL_RECORDS(NationalId, CriminalCaseId, EntryDate) VALUES(1, 101, '20180514');
INSERT INTO CRIMINAL_RECORDS(NationalId, CriminalCaseId, EntryDate) VALUES(1, 102, '20190108');


CREATE TABLE CERTIFICATE_REQUEST (
    NationalId INT NOT NULL,
	RequestId INT NOT NULL IDENTITY,
    RequestStatus VARCHAR(100),
    PRIMARY KEY(NationalId, RequestId),
    FOREIGN KEY(NationalId) REFERENCES NATIONAL_ID(NationalId)
);


CREATE TABLE SUPPORT_CASES (
    NationalId INT NOT NULL,
	SupportCaseId INT NOT NULL IDENTITY,
    CaseDescription VARCHAR(2000),
    CaseStatus VARCHAR(100),
    PRIMARY KEY(NationalId, SupportCaseId),
    FOREIGN KEY(NationalId) REFERENCES NATIONAL_ID(NationalId)
);
