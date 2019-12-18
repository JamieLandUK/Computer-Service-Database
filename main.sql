
-- Clear previous Database
DROP DATABASE IF EXISTS LAN18668469;


-- Creating the Database

CREATE DATABASE IF NOT EXISTS LAN18668469;
DELIMITER ;
USE LAN18668469;


-- Creating the Tables

CREATE TABLE tblCustomer (
	CustomerID 	int(11) 	NOT NULL AUTO_INCREMENT,
    Email 		varchar(60) NOT NULL UNIQUE,
    PhoneNum    varchar(12) DEFAULT NULL UNIQUE,
    FirstName 	varchar(30) NOT NULL,
    LastName 	varchar(30) NOT NULL,
    Address1 	varchar(50) NOT NULL,
    Address2 	varchar(50) NOT NULL,
    Address3 	varchar(50) DEFAULT NULL,
    PostCode 	varchar(10) NOT NULL,
    PRIMARY KEY (CustomerID),
    KEY (CustomerID),
    KEY (Email)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE tblStaff (
    StaffID 	int(11) 	NOT NULL AUTO_INCREMENT,
    Email 		varchar(60) NOT NULL UNIQUE,
    PhoneNum    varchar(12) DEFAULT NULL UNIQUE,
    Title       varchar(5)  NOT NULL,
    FirstName 	varchar(30) NOT NULL,
    LastName 	varchar(30) NOT NULL,
    Position 	varchar(50) DEFAULT 'Engineer',
    Address1    varchar(50) NOT NULL,
    Address2    varchar(50) NOT NULL,
    Address3    varchar(50) DEFAULT NULL,
    PostCode    varchar(10) NOT NULL,
    PRIMARY KEY (StaffID),
    KEY (StaffID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE tblService (
    ServiceID 	int(11) 	  	NOT NULL AUTO_INCREMENT,
	Name 		varchar(100)   	NOT NULL UNIQUE,
    Price		decimal(15, 2) 	NOT NULL,
    PRIMARY KEY (ServiceID),
    KEY (ServiceID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE tblOrder (
	OrderID 		int(11) 	NOT NULL AUTO_INCREMENT,
    StartDate 		DATETIME 	NOT NULL,
    FinishDate      DATETIME    DEFAULT NULL,
    TimeLength      TIME        DEFAULT NULL,
    Finished        BOOLEAN     DEFAULT FALSE,
    Offsite         BOOLEAN     DEFAULT FALSE,
    Discount        int(2)      DEFAULT 0,
    -- Foreign key to be input --
    -- CustomerID
    PRIMARY KEY (OrderID),
    KEY (OrderID),
    KEY (StartDate)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE tblOrder
    DROP COLUMN TimeLength,
	ADD CustomerID int(11) NOT NULL AFTER OrderID,
    ADD CONSTRAINT FOREIGN KEY (CustomerID)
    	REFERENCES tblCustomer (CustomerID)
        ON DELETE CASCADE ON UPDATE CASCADE;
        
CREATE TABLE tblOrderService (
	OrderID 	int(11) NOT NULL,
    ServiceID 	int(11) NOT NULL,
    Quantity 	int(10) NOT NULL,
    FOREIGN KEY (OrderID)
    	REFERENCES tblOrder (OrderID)
    	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ServiceID)
    	REFERENCES tblService (ServiceID)
    	ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE tblStaffOnOrder (
    OrderID int(11) NOT NULL,
    StaffID int(11) NOT NULL,
    FOREIGN KEY (OrderID)
        REFERENCES tblOrder (OrderID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (StaffID)
        REFERENCES tblStaff (StaffID)
        ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- Data Insertion
-- The data insertion has been put inside of a procedure to meet one of the security risks behinds being able to access the data through injection.
DELIMITER  //
CREATE PROCEDURE proc_insert_data ()
BEGIN
INSERT INTO tblCustomer (Email, PhoneNum, FirstName, LastName, Address1, Address2, Address3, PostCode)
	VALUES ('JoshuaSavage@gmail.com',   '01522 104430', 'Joshua', 'Savage',  '72 Coast Rd', 'Kirkton', 'Glenbuchat', 'AB36 2XQ'),
           ('GabrielGrant@gmail.com',   '01522 292370', 'Gabriel', 'Grant',  '3 St Andrews Ln', 'Cwmbach', '', 'SA34 9PL'),
           ('SiennaNash@gmail.com',     '01522 983134', 'Sienna', 'Nash',    '14 Manor Way', 'Great Kingshill', '', 'HP15 3EQ'),
           ('LiamReynolds@gmail.com',   '01522 184652', 'Liam', 'Reynolds',  '79 Annfield Rd', 'Bearsden', '', 'G61 6FT'),
           ('EllaGodfrey@gmail.com',    '01522 973134', 'Ella', 'Godfrey',   '54 Hart Rd', 'Northam', '', 'SO14 4BR'),
           ('NoahMorton@gmail.com',     '07408 395828', 'Noah', 'Morton',    '33 Front St', 'Hemington', 'Somerset', 'PE8 7HY'),
           ('JohnMann@gmail.com',       '07511 994273', 'John', 'Mann',      '34 Berkeley Rd', 'Stretton', 'Derbyshire', 'WA4 3NX'),
           ('KaiDavey@gmail.com',       '01522 451451', 'Kai', 'Davey',      '12 Simone Weil Avenue', 'Welford-On-Avon', '', 'CV37 3ZD'),
           ('JamesWilson@gmail.com',    '01522 736902', 'James', 'Wilson',   '3 Prince Consort Rd', 'Kelso', '', 'TD5 1RX'),
           ('MiaHope@gmail.com',        '01522 050576', 'Mia', 'Hope',       '33 Lamphey Rd', 'The Lhen', '', 'IM7 6QQ'),
           ('JoshElliot@gmail.com',     '01522 323017', 'Josh', 'Elliot',    '50 South St', 'Monsale', 'Riverdale', 'CM0 0LT'),
           ('TegenSlater@gmail.com',    '07810 574691', 'Tegen', 'Slater',   '8 Davids Ln', 'Sulham', 'Sulhamstead', 'RG7 7FR'),
           ('LouisDaly@gmail.com',      '01522 813446', 'Louis', 'Daly',     '61 Worthy Ln', 'Mealasta', 'London', 'HS2 9SB'),
           ('IsabelJordan@gmail.com',   '01522 238818', 'Isabel', 'Jordan',  '11 Roker Terrace', 'Langley Heath', '', 'ME17 9QG'),
           ('PeterGibbs@gmail.com',     '07981 403872', 'Peter', 'Gibbs',    '35 Caerfai Bay Rd', 'Ternhill', 'Cardiff', 'TF9 1SJ'),
           ('CaitlinAkhtar@gmail.com',  '07406 930372', 'Caitlin', 'Akhtar', '25 Cloch St', 'St Hilary', 'Jerishire', 'CF71 8WD'),
           ('CaitlinHawkins@gmail.com', '01522 764182', 'Caitlin', 'Hawkin', '15 Old Chapel Rd', 'Gawthrop', '', 'LA10 4AB'),
           ('MadisonBell@gmail.com',    '01522 000127', 'Madison', 'Bell',   '30 Bridge St', 'Goirtean A''chladaich', 'Aberystwyth', 'PH33 2XA'),
           ('WilliamWade@gmail.com',    '01522 118314', 'William', 'Wade',   '40 Hertingfordbury Rd', 'Newport', 'Portsmouth', 'TF10 7FR'),
           ('MorganHeady@gmail.com',    '07561 378632', 'Morgan', 'Heady',   '8 Whitby Rd', 'Derrythorpe', '', 'DN17 1PB'),
           ('BenAkhtar@gmail.com',      '01522 722074', 'Ben', 'Akhtar',     '31 Scotsburn Rd', 'Tadlow', '', 'SG8 5RZ');

INSERT INTO tblStaff (Email, PhoneNum, Title, FirstName, LastName, Address1, Address2, Address3, PostCode, Position)
    VALUES ('HPerry@lcs.co.uk',      '07852 285365', 'Mr', 'Hayden', 'Perry',      '84 Princes St', 'Roadside', '',                   'KW17 5RX', 'Technician'),
           ('KRice@lcs.co.uk',       '07753 884140', 'Mx', 'Kai', 'Rice',          '8 Traill St', 'Ropsley', 'Lincoln',               'NG33 4JU', 'Chief Executive'),
           ('LFoster@lcs.co.uk',     '07466 373971', 'Mr', 'Louis', 'Foster',      '12 Grey Rd', 'Kilbride', 'Pashton',               'PA20 6HJ', 'Technician'),
           ('TCartwright@lcs.co.uk', '07482 412524', 'Dr', 'Tom', 'Cartwright',    '87 Pendwyallt Rd', 'Burrowbridge', 'Tarry',       'TA7 0ED',  'Engineer'),
           ('IHunter@lcs.co.uk',     '07669 906717', 'Ms', 'Isobel', 'Hunter',     '1 Haslemere Rd', 'Eastwood', '',                  'NG16 6AP', 'System Analyst'),
           ('CBlackburn@lcs.co.uk',  '07624 010829', 'Mr', 'Charles', 'Blackburn', '22 Southlands Avenue', 'Polwarth', 'Teridham',    'TD10 3XE', 'Business Analyst'),
           ('LMarsden@lcs.co.uk',    '07894 146143', 'Mr', 'Logan', 'Marsden',     '29 Bullwood Rd', 'St Combs', 'Aberystwyth',       'AB43 2PE', 'Technician'),               
           ('ALewis@lcs.co.uk',      '07964 299466', 'Mrs', 'Amelie', 'Lewis',     '29 Guildford Rd', 'East Horrington', 'Bath',      'BA5 2TQ',  'Technical Support'),
           ('DReynolds@lcs.co.uk',   '07467 612834', 'Mr', 'Declan', 'Reynolds',   '68 Bootham Terrace', 'Raughton Head', 'Carrimon', 'CA5 8JU',  'Engineer'),
           ('MAshton@lcs.co.uk',     '07974 555792', 'Ms', 'Morrigan', 'Ashton',   '84 Iffley Rd', 'Broadmeadows', 'Teridham',        'TD7 2XD',  'Business Analyst'),
           ('CGlover@lcs.co.uk',     '07498 140982', 'Ms', 'Charley', 'Glover',    '78 Walwyn St', 'Chard', 'Tarry',                  'TA20 1TA', 'Technician'),
           ('FPeacock@lcs.co.uk',    '07582 067604', 'Mr', 'Finlay', 'Peacock',    '89 Roman Pass', 'Leckhamstead', 'Rogershire',     'RG20 2HG', 'Engineer'),
           ('ENorris@lcs.co.uk',     '07481 376532', 'Mr', 'Elliot', 'Norris',     '82 Redcliffe Way', 'Woodsford', '',               'DT3 3YY',  'Technician'),
           ('KOsborne@lcs.co.uk',    '07490 047939', 'Mx', 'Kieran', 'Osborne',    '12 North Promenade', 'Dottery', 'Dottishire',     'DT6 1YB',  'System Analyst'),
           ('OAllen@lcs.co.uk',      '07488 970438', 'Mr', 'Oscar', 'Allen',       '1 Farburn Terrace', 'Little Langford', 'Spaff',   'SP34 3TA', 'Technical Support'),
           ('BParsons@lcs.co.uk',    '07660 777057', 'Mr', 'Benjamin', 'Parsons',  '6 Circle Way', 'Caenby', 'London',                'LN2 5ZH',  'Technician'),
           ('JMorgan@lcs.co.uk',     '07833 186007', 'Mr', 'James', 'Morgan',      '18 Bishopgate St', 'Seaton', 'Prolingham',        'PL11 2WD', 'Engineer'),
           ('KSmart@lcs.co.uk',      '07566 331197', 'Mrs', 'Kiera', 'Smart',      '27 Wade Ln', 'Saltash', 'Prolingham',             'PL12 5UF', 'Engineer'),
           ('AGreen@lcs.co.uk',      '07922 619742', 'Mr', 'Aiden', 'Green',       '9 Old Chapel Rd', 'Gearach', '',                  'PA48 6LG', 'Technical Support'),
           ('CButler@lcs.co.uk',     '07537 454134', 'Mr', 'Connor', 'Butler',     '2 Bishopgate Rd', 'Seaton Delaval', '',           'NE25 8FF', 'Engineer');

INSERT INTO tblService (Name, Price)
    VALUES ('Hardware fault repairs', 69.99),
           ('Software installation', 30.00),
           ('Network setup', 45.30),
           ('Network repair', 40.99),
           ('Internet router maintenance', 35.50),
           ('Computer training (per person)', 40.00),
           ('Photo editing training (per person)', 29.99),
           ('Word processor training (per person)', 15.00),
           ('Spreadsheet training (per person)', 20.50),
           ('Database and deployment training (per person)', 49.99),
           ('Server backup (single device)', 30.00),
           ('Antivirus installation', 30.45),
           ('Server maintenance (single device)', 99.99),
           ('Workstation maintenance (single device)', 15.50),
           ('Hardware upgrade (Server)', 499.99),
           ('Hardware upgrade (Router)', 55.50),
           ('Hardware upgrade (Switch)', 40.00),
           ('Hardware upgrade (Complete Network)', 250.00),
           ('Hardware upgrade (Hard Drive)', 52.54),
           ('Hardware upgrade (Solid State Drive)', 120.50),
           ('Hardware upgrade (CPU)', 319.99),
           ('Hardware upgrade (GPU), Lower', 255.50),
           ('Hardware upgrade (GPU), Midrange', 399.99),
           ('Hardware upgrade (GPU), Toprange', 750.51),
           ('Hardware upgrade (RAM)', 129.50);

-- Insertion of one order
INSERT INTO tblOrder (CustomerID, StartDate, FinishDate, Finished, Offsite, Discount)
    VALUES (1, '2019-04-24 09:30:00', '2019-04-30 17:00:00', TRUE, TRUE, 0);
INSERT INTO tblOrderService (OrderID, ServiceID, Quantity)
    VALUES (1, 8, 3), (1, 14, 2), (1, 12, 2);
INSERT INTO tblStaffOnOrder (OrderID, StaffID)
    VALUES (1, 9), (1, 8);

-- Main order insertion
INSERT INTO tblOrder (CustomerID, StartDate, FinishDate, Finished, Offsite, Discount)
    VALUES (1,  '2019-07-11 09:30:00', '2019-07-18 14:31:11', TRUE, TRUE,  10),
           (2,  '2019-07-12 11:00:00', '2019-07-14 10:09:03', TRUE, FALSE,  5),
           (3,  '2019-07-24 12:15:30', '2019-07-24 14:00:00', TRUE, FALSE,  0),
           (4,  '2019-07-30 08:45:10', '2019-08-06 18:30:01', TRUE, TRUE,   5),
           (5,  '2019-08-04 10:10:10', '2019-08-11 10:10:10', TRUE, FALSE,  0),
           (6,  '2019-08-10 09:00:00', '2019-08-17 16:55:21', TRUE, TRUE,  50),
           (7,  '2019-08-24 08:30:00', '2019-08-31 08:30:00', TRUE, FALSE,  0),
           (8,  '2019-09-02 16:23:48', '2019-09-04 09:00:00', TRUE, FALSE,  0),
           (2,  '2019-09-16 10:01:10', '2019-09-21 13:00:50', TRUE, FALSE, 15),
           (9,  '2019-09-20 09:15:15', '2019-09-27 12:12:12', TRUE, TRUE,  10),
           (4,  '2019-09-25 07:00:00', '2019-10-02 07:00:00', TRUE, FALSE,  0),
           (11, '2019-10-01 10:20:30', '2019-10-08 16:30:20', TRUE, TRUE,  25),
           (12, '2019-10-07 09:00:00', '2019-10-10 10:10:10', TRUE, FALSE,  0),
           (13, '2019-10-16 08:08:08', '2019-10-23 13:23:23', TRUE, TRUE,  10),
           (14, '2019-10-25 12:25:25', '2019-11-01 11:11:00', TRUE, TRUE,  20),
           (8,  '2019-11-01 09:30:00', '2019-11-08 18:00:00', TRUE, FALSE,  0),
           (15, '2019-11-06 09:30:00', '2019-11-11 11:11:11', TRUE, TRUE,  11),
           (16, '2019-11-09 10:24:45', '2019-11-19 16:20:21', TRUE, FALSE,  0),
           (17, '2019-11-23 09:09:09', '2019-11-30 17:30:30', TRUE, TRUE,   0),
           (18, '2019-11-25 08:00:00', '2019-12-02 08:00:00', TRUE, FALSE,  5),
           (19, '2019-11-29 09:30:00', '2019-12-06 16:43:12', TRUE, FALSE, 15),
           (20, '2019-12-07 09:30:00', NULL,                 FALSE, FALSE,  0),
           (21, '2019-12-10 12:12:12', NULL,                 FALSE, TRUE,  10);
INSERT INTO tblOrderService (OrderID, ServiceID, Quantity)
    VALUES (2, 3, 1), (2, 16, 4), (2, 17, 1), (2, 15, 1),
           (3, 12, 1), (3, 8, 4),
           (4, 3, 3), (4, 9, 1), (4, 10, 4),
           (5, 10, 5),
           (6, 21, 2), (6, 7, 4),
           (7, 5, 3), (7, 1, 3),
           (8, 18, 3),
           (9, 8, 2),
           (10, 14, 4), (10, 10, 3),
           (11, 23, 2),
           (12, 16, 1),
           (13, 23, 4),
           (14, 17, 4), (14, 9, 1), (14, 7, 1), (14, 16, 3), (14, 10, 4),
           (15, 7, 4), (15, 17, 3), (15, 11, 3),
           (16, 15, 4),
           (17, 13, 3), (17, 4, 2),
           (18, 23, 3), (18, 25, 2),
           (19, 15, 1),
           (20, 12, 1),
           (21, 8, 3),
           (22, 5, 1), (22, 20, 5), (22, 4, 4), (22, 2, 1),
           (23, 8, 1), (23, 24, 3),
           (24, 24, 1);
INSERT INTO tblStaffOnOrder (OrderID, StaffID)
    VALUES (2, 17), (2, 16),
           (3, 8),
           (4, 2), (4, 18), (4, 5), (4, 6),
           (5, 13), (5, 5),
           (6, 11), (6, 17), (6, 10),
           (7, 19),
           (8, 3),
           (9, 6),
           (10, 20), (10, 1),
           (11, 12),
           (12, 9),
           (13, 16),
           (14, 15), (14, 4), (14, 7),
           (15, 14), (15, 8),
           (16, 18), (16, 13),
           (17, 2),
           (18, 3), (18, 16), (18, 20), (18, 10),
           (19, 5),
           (20, 2), (20, 11),
           (21, 18), (21, 10), (21, 6),
           (22, 17), (22, 15), (22, 1),
           (23, 8),
           (24, 13);
END //
DELIMITER ;

-- Finish one order when it compiles.
UPDATE tblOrder
    SET Finished = TRUE, FinishDate = NOW()
    WHERE OrderID = 23;

-- Testing the deletion of records
DELETE FROM tblCustomer
    WHERE CustomerID = 12;
DELETE FROM tblService
    WHERE ServiceID = 18;
-- Should cascade any orders by this customer.

-- Query 1: Receive the details of customers who have placed orders.
DELIMITER //
CREATE PROCEDURE proc_customer_orders ()
BEGIN
CREATE VIEW vwCustomerOrders AS
SELECT DISTINCT FirstName, LastName, Address1, Address2, Address3, PostCode, Email, PhoneNum FROM tblCustomer
INNER JOIN tblOrder ON tblCustomer.CustomerID=tblOrder.CustomerID
ORDER BY tblCustomer.LastName ASC;
END //
DELIMITER ;

-- Query 2: Details of all staff members who have been allocated orders.
DELIMITER //
CREATE PROCEDURE proc_staff_orders ()
BEGIN
CREATE VIEW vwStaffOrders AS
SELECT s.Title AS `Staff Title`, s.FirstName AS `Staff First Name`, s.LastName AS `Staff Last Name`, s.Position AS `Position of Staff`, o.StartDate AS `Order Start Date`, c.Email AS `Customer Email`
	FROM tblStaff s
    LEFT JOIN tblStaffOnOrder soo ON s.StaffID=soo.StaffID
    LEFT JOIN tblOrder o ON soo.OrderID=o.OrderID
    LEFT JOIN tblCustomer c ON o.CustomerID=c.CustomerID
    ORDER BY o.StartDate ASC;
END //
DELIMITER ;

-- Query 3: The manager wishes to know all the customers and their order details.
DELIMITER //
CREATE PROCEDURE proc_customer_order_details ()
BEGIN
CREATE VIEW vwCustomerOrderDetails AS
SELECT c.FirstName AS `Customer First Name`, c.LastName AS `Customer Last Name`, c.Email AS `Customer Email`, o.StartDate AS `Order Date`, se.Name AS `Service Name`, se.Price AS `Service Price`, os.Quantity AS `Service Quantity`
	FROM tblCustomer c
    LEFT JOIN tblOrder o ON c.CustomerID=o.CustomerID
    LEFT JOIN tblOrderService os ON o.OrderID=os.OrderID
    LEFT JOIN tblService se ON os.ServiceID=se.ServiceID
    ORDER BY o.StartDate ASC;
END //
DELIMITER ;

-- STORED PROCEDURE
DELIMITER //
CREATE PROCEDURE proc_new_customer(
    Email varchar(60),
    PhoneNum varchar(12),
    FirstName varchar(30),
    LastName varchar(30),
    Address1 varchar(50),
    Address2 varchar(50),
    Address3 varchar(50),
    PostCode varchar(10)
)
BEGIN
    INSERT INTO tblCustomer (Email, PhoneNum, FirstName, LastName, Address1, Address2, Address3, PostCode)
        VALUES (Email, PhoneNum, FirstName, LastName, Address1, Address2, Address3, PostCode);
END //
DELIMITER ;


-- Calling the stored procedures which protect the insertions and queries.
CALL proc_insert_data();
CALL proc_customer_orders();
CALL proc_staff_orders();
CALL proc_customer_order_details();
CALL proc_new_customer(
    'GaryReed@gmail.com',
    '07733 516164',
    'Gary',
    'Reed',
    '14 Blackwoode Avenue',
    'Euclid',
    'Lincoln',
    'LN53 9PP'
);


-- Copy all Tables
CREATE TABLE IF NOT EXISTS copy_of_tblCustomer
SELECT * FROM tblCustomer
WHERE CustomerID > 10;

CREATE TABLE IF NOT EXISTS copy_of_tblOrder
SELECT * FROM tblOrder
WHERE FinishDate <> NULL;

CREATE TABLE IF NOT EXISTS copy_of_tblOrderService
SELECT * FROM tblOrderService;

CREATE TABLE IF NOT EXISTS copy_of_tblService
SELECT * FROM tblService;

CREATE TABLE IF NOT EXISTS copy_of_tblStaff
SELECT * FROM tblStaff;

CREATE TABLE IF NOT EXISTS copy_of_tblStaffOnOrder
SELECT * FROM tblStaffOnOrder;
