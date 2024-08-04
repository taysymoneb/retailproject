CREATE TABLE marketing_info(
	CampaignID SERIAL PRIMARY KEY NOT NULL,
	CampaignName VARCHAR(100),
	StartDate VARCHAR(50),
	EndDate VARCHAR(50),
	Budget INT,
	TargetAudience VARCHAR(50),
	PrimaryChannel VARCHAR(50)
)

CREATE TABLE item_catalog(
	ItemID SERIAL PRIMARY KEY NOT NULL,
	ItemSold VARCHAR(100) NOT NULL,
	Description VARCHAR(500) NOT NULL,
	UnitPrice DECIMAL (10,2) NOT NULL
);

CREATE TABLE employee_info(
	EmployeeID SERIAL PRIMARY KEY NOT NULL,
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	Age INT,
	"Position" VARCHAR (100),
	HireDate DATE
)

CREATE TABLE operations_info(
	OperationID SERIAL PRIMARY KEY NOT NULL,
	EmployeeID SERIAL NOT NULL,
	OperationDate Date, 
	OperationDescription VARCHAR(200),
	TotalAmount Decimal (10,2),
	FOREIGN KEY (EmployeeID) REFERENCES employee_info(employeeID)
)

CREATE TABLE total_sales(
	SerialNumber SERIAL PRIMARY KEY,
	OrderID INT, 
	EmployeeID SERIAL NOT NULL,
	OrderDate DATE,
	TimeOrdered TIME,
	OnlineOrder BOOL,
	ItemID INT,
	UnitPrice DECIMAL(10,2),
	FOREIGN KEY (EmployeeID) REFERENCES employee_info(EmployeeID),
	FOREIGN KEY (ItemID) REFERENCES item_catalog(ItemID)
);


