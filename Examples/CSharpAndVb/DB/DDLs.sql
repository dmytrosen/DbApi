USE ApiTestDB
GO

if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcCollectionResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcCollectionResult
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcClassResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcClassResult
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcDataSet') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcDataSet
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcExistingClassResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcExistingClassResult
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcExistingCollectionResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcExistingCollectionResult
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcNoResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcNoResult
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcScalar') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcScalar
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcTestNoApiMetaData') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcTestNoApiMetaData
end
go


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'sen' AND TABLE_NAME = 'ApiTestSecondTest')
BEGIN
	DROP table sen.ApiTestSecondTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'sen' AND TABLE_NAME = 'ApiTestSeventhTest')
BEGIN
	DROP table sen.ApiTestSeventhTest
end
go
IF EXISTS (SELECT SCHEMA_ID FROM sys.schemas WHERE [name] = 'sen')
BEGIN 
	DROP SCHEMA sen
END
GO
CREATE SCHEMA sen AUTHORIZATION dbo
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestFirstTest')
BEGIN
	DROP table dbo.ApiTestFirstTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestAllTypesTest')
BEGIN
	DROP table dbo.ApiTestAllTypesTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestEighthTest')
BEGIN
	DROP table dbo.ApiTestEighthTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestFifthTest')
BEGIN
	DROP table dbo.ApiTestFifthTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestFourthTest')
BEGIN
	DROP table dbo.ApiTestFourthTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestMainTest')
BEGIN
	DROP table [dbo].ApiTestMainTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestThirdTest')
BEGIN
	DROP table dbo.ApiTestThirdTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestUser')
BEGIN
	DROP table dbo.ApiTestUser
end
go

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'IntBitValuePairArrayType')
BEGIN
	DROP TYPE dbo.IntBitValuePairArrayType
END


create table dbo.ApiTestUser
(
	UserID INT IDENTITY(1, 1) NOT NULL,
	UserName VARCHAR(50) NOT NULL, 
	[Rank] int NOT NULL, 
	CONSTRAINT PK_User PRIMARY KEY CLUSTERED (UserName ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


create table dbo.ApiTestAllTypesTest
(
	ApiTestAllTypesTesttID INT IDENTITY(1, 1) NOT NULL,
	ParamBigInt BigInt, 
	ParamBinary Binary(24), 
	ParamBit Bit, 
	ParamChar Char(10), 
	ParamDateTime DateTime, 
	ParamDecimal DECIMAL(37,5), 
	ParamFloat FLOAT(42), 
	ParamImage Image, 
	ParamInt Int, 
	ParamMoney Money, 
	ParamNChar NChar(5), 
	ParamNText NText, 
	ParamNVarChar NVarChar(20), 
	ParamReal Real, 
	ParamUniqueIdentifier UniqueIdentifier, 
	ParamSmallDateTime SmallDateTime, 
	ParamSmallInt SmallInt, 
	ParamSmallMoney SmallMoney, 
	ParamText Text, 
	ParamTimestamp Timestamp, 
	ParamTinyInt TinyInt, 
	ParamVarBinary VarBinary(1024), 
	ParamVarChar VarChar(20), 
	ParamXml Xml, 
	ParamDate Date, 
	ParamTime Time, 
	ParamDateTime2 DateTime2, 
	ParamDateTimeOffset DateTimeOffset, 
	CONSTRAINT PK_ApiTestAllTypesTesttTest PRIMARY KEY CLUSTERED (ApiTestAllTypesTesttID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, 
	ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, 
	ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar,
	ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)
	VALUES(1234567892, -- ParamBigInt - bigint
          CAST(3.575 AS BINARY(24)), -- ParamBinary - binary(24)
          1, -- ParamBit - bit
          'A', -- ParamChar - char(10)
		  CAST('2017-05-31 10:11:24.970' AS DATETIME), -- ParamDateTime - datetime
          500.005, -- ParamDecimal - decimal
          1.005, -- ParamFloat - float
          CAST(CAST(3.575 AS VARBINARY(512)) AS IMAGE), -- ParamImage - image
          5200, -- ParamInt - int
          4.99, -- ParamMoney - money
          N'nchar', -- ParamNChar - nchar(5)
          N'1.INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar, ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)', -- ParamNText - ntext
          N'ParamNVarChar nvarch', -- ParamNVarChar - nvarchar(20)
          0.075, -- ParamReal - real
          CAST('c89b5acd-9501-7ae7-d9a7-aabb07da2017' AS UNIQUEIDENTIFIER), -- ParamUniqueIdentifier - uniqueidentifier
          CAST('2017-04-30 10:11:24' AS SMALLDATETIME), -- ParamSmallDateTime - smalldatetime
          12, -- ParamSmallInt - smallint
          5.79, -- ParamSmallMoney - smallmoney
          '3.create table dbo.ApiTestAllTypesTest(ApiTestAllTypesTesttID INT IDENTITY(1, 1) NOT NULL, ParamBigInt BigInt, ParamBinary Binary(512), ParamBit Bit, ParamChar Char(10), ParamDateTime DateTime, ParamDecimal Decimal, ParamFloat Float, ParamImage Image, ParamInt Int, ParamMoney Money, ParamNChar NChar(5), ParamNText NText, ParamNVarChar NVarChar(20), ParamReal Real, ParamUniqueIdentifier UniqueIdentifier, ParamSmallDateTime SmallDateTime, ParamSmallInt SmallInt, ParamSmallMoney SmallMoney, ParamText Text, ParamTimestamp Timestamp, ParamTinyInt TinyInt, ParamVarBinary VarBinary(1024), ParamVarChar VarChar(20), ParamXml Xml, ParamDate Date, ParamTime Time, ParamDateTime2 DateTime2, ParamDateTimeOffset DateTimeOffset, CONSTRAINT PK_ApiTestAllTypesTesttTest PRIMARY KEY CLUSTERED (ApiTestAllTypesTesttID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] GO', -- ParamText - text
          7, -- ParamTinyInt - tinyint
          CAST(3.575 AS VARBINARY(1024)), -- ParamVarBinary - varbinary(1024)
          'ParamVarChar varchar', -- ParamVarChar - varchar(20)
          '<ParamXml1>Param Xml 1</ParamXml1>', -- ParamXml - xml
          DATEADD(dd, 3, GETDATE()), -- ParamDate - date
          CAST(GETDATE() AS TIME), -- ParamTime - time
          SYSDATETIME(), -- ParamDateTime2 - datetime2
          SYSDATETIMEOFFSET())  -- ParamDateTimeOffset - datetimeoffset
INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, 
	ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, 
	ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar,
	ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)
	VALUES(1234567891, -- ParamBigInt - bigint
          CAST(93.575 AS BINARY(24)), -- ParamBinary - binary(24)
          0, -- ParamBit - bit
          'B', -- ParamChar - char(10)
		  CAST('2017-05-31 10:09:24.970' AS DATETIME), -- ParamDateTime - datetime
          51, -- ParamDecimal - decimal
          1.055, -- ParamFloat - float
          CAST(CAST(93.575 AS VARBINARY(512)) AS IMAGE), -- ParamImage - image
          5000, -- ParamInt - int
          14.99, -- ParamMoney - money
          N'nchar', -- ParamNChar - nchar(5)
          N'2.INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar, ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)', -- ParamNText - ntext
          N'ParamNVarChar nvarch', -- ParamNVarChar - nvarchar(20)
          0.075, -- ParamReal - real
          CAST('c89b5acd-9501-7ae7-d9a7-aabb07dc2017' AS UNIQUEIDENTIFIER), -- ParamUniqueIdentifier - uniqueidentifier
          CAST('2017-04-30 10:11:24' AS SMALLDATETIME), -- ParamSmallDateTime - smalldatetime
          11, -- ParamSmallInt - smallint
          5.29, -- ParamSmallMoney - smallmoney
          '2.create table dbo.ApiTestAllTypesTest(ApiTestAllTypesTesttID INT IDENTITY(1, 1) NOT NULL, ParamBigInt BigInt, ParamBinary Binary(512), ParamBit Bit, ParamChar Char(10), ParamDateTime DateTime, ParamDecimal Decimal, ParamFloat Float, ParamImage Image, ParamInt Int, ParamMoney Money, ParamNChar NChar(5), ParamNText NText, ParamNVarChar NVarChar(20), ParamReal Real, ParamUniqueIdentifier UniqueIdentifier, ParamSmallDateTime SmallDateTime, ParamSmallInt SmallInt, ParamSmallMoney SmallMoney, ParamText Text, ParamTimestamp Timestamp, ParamTinyInt TinyInt, ParamVarBinary VarBinary(1024), ParamVarChar VarChar(20), ParamXml Xml, ParamDate Date, ParamTime Time, ParamDateTime2 DateTime2, ParamDateTimeOffset DateTimeOffset, CONSTRAINT PK_ApiTestAllTypesTesttTest PRIMARY KEY CLUSTERED (ApiTestAllTypesTesttID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] GO', -- ParamText - text
          9, -- ParamTinyInt - tinyint
          CAST(93.575 AS VARBINARY(1024)), -- ParamVarBinary - varbinary(1024)
          'ParamVarChar varchar', -- ParamVarChar - varchar(20)
          '<ParamXml2>Param Xml 2</ParamXml2>', -- ParamXml - xml
          DATEADD(dd, 2, GETDATE()), -- ParamDate - date
          CAST(GETDATE() AS TIME), -- ParamTime - time
          SYSDATETIME(), -- ParamDateTime2 - datetime2
          SYSDATETIMEOFFSET())  -- ParamDateTimeOffset - datetimeoffset
INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, 
	ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, 
	ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar,
	ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)
	VALUES(1234567890, -- ParamBigInt - bigint
          CAST(193.575 AS BINARY(24)), -- ParamBinary - binary(24)
          1, -- ParamBit - bit
          'C', -- ParamChar - char(10)
		  CAST('2017-05-31 10:10:24.970' AS DATETIME), -- ParamDateTime - datetime
          52, -- ParamDecimal - decimal
          1.505, -- ParamFloat - float
          CAST(CAST(193.575 AS VARBINARY(512)) AS IMAGE), -- ParamImage - image
          5030, -- ParamInt - int
          24.99, -- ParamMoney - money
          N'nchar', -- ParamNChar - nchar(5)
          N'3.INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar, ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)', -- ParamNText - ntext
          N'ParamNVarChar nvarch', -- ParamNVarChar - nvarchar(20)
          0.075, -- ParamReal - real
          CAST('c89b5acd-9501-7ae7-d9a7-aabb07dd2017' AS UNIQUEIDENTIFIER), -- ParamUniqueIdentifier - uniqueidentifier
          CAST('2017-04-30 10:11:24' AS SMALLDATETIME), -- ParamSmallDateTime - smalldatetime
          10, -- ParamSmallInt - smallint
          5.09, -- ParamSmallMoney - smallmoney
          '1.create table dbo.ApiTestAllTypesTest(ApiTestAllTypesTesttID INT IDENTITY(1, 1) NOT NULL, ParamBigInt BigInt, ParamBinary Binary(512), ParamBit Bit, ParamChar Char(10), ParamDateTime DateTime, ParamDecimal Decimal, ParamFloat Float, ParamImage Image, ParamInt Int, ParamMoney Money, ParamNChar NChar(5), ParamNText NText, ParamNVarChar NVarChar(20), ParamReal Real, ParamUniqueIdentifier UniqueIdentifier, ParamSmallDateTime SmallDateTime, ParamSmallInt SmallInt, ParamSmallMoney SmallMoney, ParamText Text, ParamTimestamp Timestamp, ParamTinyInt TinyInt, ParamVarBinary VarBinary(1024), ParamVarChar VarChar(20), ParamXml Xml, ParamDate Date, ParamTime Time, ParamDateTime2 DateTime2, ParamDateTimeOffset DateTimeOffset, CONSTRAINT PK_ApiTestAllTypesTesttTest PRIMARY KEY CLUSTERED (ApiTestAllTypesTesttID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] GO', -- ParamText - text
          8, -- ParamTinyInt - tinyint
          CAST(193.575 AS VARBINARY(1024)), -- ParamVarBinary - varbinary(1024)
          'ParamVarChar varchar', -- ParamVarChar - varchar(20)
          '<ParamXml3>Param Xml 3</ParamXml3>', -- ParamXml - xml
          DATEADD(dd, 1, GETDATE()), -- ParamDate - date
          CAST(GETDATE() AS TIME), -- ParamTime - time
          SYSDATETIME(), -- ParamDateTime2 - datetime2
          SYSDATETIMEOFFSET())  -- ParamDateTimeOffset - datetimeoffset


CREATE TABLE [ApiTestEighthTest] ([EighthTestId] INT IDENTITY(1,1),Name VARCHAR(max) not null,Submited DATETIME,	Started DATETIME,	Pinged DATETIME, Terminated DATETIME, TerminationStatus VARCHAR(8),Message VARCHAR(512),TerminationInfo NTEXT)
GO


create table dbo.ApiTestFifthTest
(
	FifthTestID INT NOT NULL CONSTRAINT UC_FifthTest_FifthTestID UNIQUE(FifthTestID),
	Name VARCHAR(64) NOT NULL, 
	Rank int NOT NULL, -- order 
	CreatedDate DATETIME NOT NULL DEFAULT(GETDATE()),
	CreatedBy VARCHAR(50) NOT NULL CONSTRAINT FK_FifthTestCreatedBy_UserUserName REFERENCES dbo.ApiTestUser (UserName),
	UpdatedDate DATETIME NOT NULL DEFAULT(GETDATE()),
	UpdatedBy VARCHAR(50) NOT NULL CONSTRAINT FK_FifthTestUpdatedBy_UserUserName REFERENCES dbo.ApiTestUser (UserName),
	CONSTRAINT PK_FifthTests PRIMARY KEY CLUSTERED (FifthTestID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE 
TABLE 
[dbo].[ApiTestFirstTest]
(
	FirstTestID 
INT 
IDENTITY(1, 1) 
NOT NULL, -- IDENTITY COLUMN
	Selected [BIT] NOT NULL DEFAULT(0), 
	CreatedDate [DATETIME] NOT NULL DEFAULT(GETDATE()), UpdatedDate DATETIME NOT NULL DEFAULT(GETDATE()), [UpdatedBy] VARCHAR(50) NOT NULL CONSTRAINT FK_FirstTestID_FirstTestUpdatedBy_UsersUserName REFERENCES dbo.ApiTestUser (UserName),
	CONSTRAINT PK_FirstTest PRIMARY KEY CLUSTERED (FirstTestID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


create table dbo.ApiTestFourthTest
(
	FourthTestID INT IDENTITY(1, 1) NOT NULL,
	TypeID int NOT NULL,
	CreatedDate DATETIME NOT NULL DEFAULT(GETDATE()),
	UpdatedDate DATETIME NOT NULL DEFAULT(GETDATE()),
	UpdatedBy VARCHAR(50) NOT NULL CONSTRAINT FK_FourthTestUpdatedBy_UsersUserName REFERENCES dbo.ApiTestUser (UserName),
	CONSTRAINT PK_FourthTest PRIMARY KEY CLUSTERED (FourthTestID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].ApiTestMainTest
(
	MainTestID INT IDENTITY(1, 1) NOT NULL, -- IDENTITY COLUMN
	Selected [BIT] NOT NULL DEFAULT(0), 
	UpdatedOn DATETIME NOT NULL DEFAULT(GETDATE()), UpdatedBy VARCHAR(50) NOT NULL CONSTRAINT FK_MainTestUpdatedBy_UserUserName REFERENCES dbo.ApiTestUser (UserName),
	CONSTRAINT PK_MainTest PRIMARY KEY CLUSTERED (MainTestID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO 


CREATE TABLE dbo.ApiTestThirdTest(ThirdTestID INT IDENTITY(1, 1) NOT NULL, RangeFrom DATETIME NULL, RangeTo DATETIME NULL, CreatedDate DATETIME NOT NULL DEFAULT(GETDATE()),UpdatedDate DATETIME NOT NULL DEFAULT(GETDATE()),
	UpdatedBy VARCHAR(50) NOT NULL CONSTRAINT FK_ThirdTestUpdatedBy_UserUserName REFERENCES dbo.ApiTestUser (UserName)) 
GO


create table [sen].[ApiTestSecondTest]
(
	[SecondTestID] INT IDENTITY(1, 1) NOT NULL,        
	TestText VARCHAR(1024) NOT NULL,	TestManifest TEXT NOT NULL,	IsScheduled BIT NOT NULL,
	ScheduledDate DATETIME NOT NULL DEFAULT(GETDATE()),
	CONSTRAINT PK_SecondTest PRIMARY KEY CLUSTERED (SecondTestID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] 
GO

CREATE table sen.ApiTestSeventhTest
(
	SeventhTestID INT NOT NULL,Name VARCHAR(64) NOT NULL,CreatedDate DATETIME NOT NULL DEFAULT(GETDATE())
) 
GO

create type dbo.IntBitValuePairArrayType as table 
(
    IntValue int NOT NULL,
    BitValue bit NOT NULL,
    PRIMARY KEY CLUSTERED(IntValue ASC) WITH (IGNORE_DUP_KEY = OFF)
)
GO


CREATE procedure dbo.sp_ProcCollectionResult
	@takeId int = NULL, 
	-- types
	@paramBigInt BigInt, 
	@paramBinary Binary(24), 
	@paramBit Bit, 
	@paramChar Char(10), 
	@paramDateTime DateTime, 
	@paramDecimal DECIMAL(32,5), 
	@paramFloat FLOAT(42), 
	@paramImage Image, 
	@paramInt Int, 
	@paramMoney Money, 
	@paramNChar NChar(5), 
	@paramNText NText, 
	@paramNVarChar NVarChar(20), 
	@paramReal Real, 
	@paramUniqueIdentifier UniqueIdentifier, 
	@paramSmallDateTime SmallDateTime, 
	@paramSmallInt SmallInt, 
	@paramSmallMoney SmallMoney, 
	@paramText Text, 
	@paramTinyInt TinyInt, 
	@paramVarBinary VarBinary(1024), 
	@paramVarChar VarChar(20), 
	@paramXml Xml, 
	@paramStructured dbo.IntBitValuePairArrayType READONLY, 
	@paramDate Date, 
	@paramTime Time, 
	@paramDateTime2 DateTime2, 
	@paramDateTimeOffset DateTimeOffset, 
	-- typeDefs
	@paramRank int, 
	@paramUpdatedDate datetime, 
	@paramUserName varchar(64), 
	@outParamUpdatedBy int output, 
	@paramTestManifest text, 
	-- output params
	@outParamBigInt BigInt output, 
	@outParamBinary Binary(512) output, 
	@outParamBit Bit output, 
	@outParamChar Char(10) output, 
	@outParamDateTime DateTime output, 
	@outparamDecimal DECIMAL(32,5) output, 
	@outParamFloat FLOAT(42) output, 
	@outParamInt Int output, 
	@outParamMoney Money output, 
	@outParamNChar nchar(5) output, 
	@outParamNVarChar NVarChar(20) output, 
	@outParamReal Real output, 
	@outParamUniqueIdentifier UniqueIdentifier output, 
	@outParamSmallDateTime SmallDateTime output, 
	@outParamSmallInt SmallInt output, 
	@outParamSmallMoney SmallMoney output, 
	@outParamTimestamp Timestamp output, 
	@outParamTinyInt TinyInt output, 
	@outParamVarBinary VarBinary(1024) output, 
	@outParamVarChar VarChar(20) output, 
	@outParamXml Xml output, 
	@outParamDate Date output, 
	@outParamTime Time output, 
	@outParamDateTime2 DateTime2 output, 
	@outParamDateTimeOffset DateTimeOffset output, 
	-- in-output params
	@inOutParamBigInt BigInt output, 
	@inOutParamBinary Binary(512) output, 
	@inOutParamBit Bit output, 
	@inOutParamChar Char(10) output, 
	@inOutParamDateTime DateTime output, 
	@inOutparamDecimal DECIMAL(32,5) output, 
	@inOutParamFloat FLOAT(42) output, 
	@inOutParamInt Int output, 
	@inOutParamMoney Money output, 
	@inOutParamNChar nchar(5) output, 
	@inOutParamNVarChar NVarChar(20) output, 
	@inOutParamReal Real output, 
	@inOutParamUniqueIdentifier UniqueIdentifier output, 
	@inOutParamSmallDateTime SmallDateTime output, 
	@inOutParamSmallInt SmallInt output, 
	@inOutParamSmallMoney SmallMoney output, 
	@inOutParamTinyInt TinyInt output, 
	@inOutParamVarBinary VarBinary(1024) output, 
	@inOutParamVarChar VarChar(20) output, 
	@inOutParamXml Xml output, 
	@inOutParamDate Date output, 
	@inOutParamTime Time output, 
	@inOutParamDateTime2 DateTime2 output, 
	@inOutParamDateTimeOffset DateTimeOffset output
as
begin
	-- set ouptup params
	SET @outParamUpdatedBy = @paramRank
	SET @outParamBigInt = @inOutParamBigInt
	SET @outParamBinary = @inOutParamBinary
	SET @outParamBit = @inOutParamBit
	SET @outParamChar = @inOutParamChar
	SET @outParamDateTime = @inOutParamDateTime
	SET @outParamDecimal = @inOutParamDecimal
	SET @outParamFloat = @inOutParamFloat
	SET @outParamInt = @inOutParamInt
	SET @outParamMoney = @inOutParamMoney
	SET @outParamNChar = @inOutParamNChar
	SET @outParamNVarChar = @inOutParamNVarChar
	SET @outParamReal = @inOutParamReal
	SET @outParamUniqueIdentifier = @inOutParamUniqueIdentifier
	SET @outParamSmallDateTime = @inOutParamSmallDateTime 
	SET @outParamSmallInt = @inOutParamSmallInt 
	SET @outParamSmallMoney = @inOutParamSmallMoney 
	SET @outParamTimestamp = CAST(GETDATE() AS TIMESTAMP) 
	SET @outParamTinyInt = @inOutParamTinyInt 
	SET @outParamVarBinary = @inOutParamVarBinary 
	SET @outParamVarChar = @inOutParamVarChar 
	SET @outParamXml = @inOutParamXml 
	SET @outParamDate = @inOutParamDate 
	SET @outParamTime = @inOutParamTime 
	SET @outParamDateTime2 = @inOutParamDateTime2 
	SET @outParamDateTimeOffset = @inOutParamDateTimeOffset 
	-- set in-output params
	SET @inOutParamBigInt = @paramBigInt
	SET @inOutParamBinary = @paramBinary 
	SET @inOutParamBit = @paramBit 
	SET @inOutParamChar = @paramChar 
	SET @inOutParamDateTime = @paramDateTime 
	SET @inOutParamDecimal = @paramDecimal 
	SET @inOutParamFloat = @paramFloat 
	SET @inOutParamInt = @paramInt 
	SET @inOutParamMoney = @paramMoney
	SET @inOutParamNChar = @paramNChar 
	SET @inOutParamNVarChar = @paramNVarChar 
	SET @inOutParamReal = @paramReal 
	SET @inOutParamUniqueIdentifier = @paramUniqueIdentifier 
	SET @inOutParamSmallDateTime = @paramSmallDateTime 
	SET @inOutParamSmallInt = @paramSmallInt 
	SET @inOutParamSmallMoney = @paramSmallMoney 
	SET @inOutParamTinyInt = @paramTinyInt 
	SET @inOutParamVarBinary = @paramVarBinary 
	SET @inOutParamVarChar = @paramVarChar 
	SET @inOutParamXml = @paramXml 
	SET @inOutParamDate = @paramDate 
	SET @inOutParamTime = @paramTime 
	SET @inOutParamDateTime2 = @paramDateTime2 
	SET @inOutParamDateTimeOffset = @paramDateTimeOffset 

	SELECT t.ApiTestAllTypesTesttID, t.ParamBigInt, t.ParamBinary, t.ParamBit, t.ParamChar, t.ParamDateTime, t.ParamDecimal, t.ParamFloat, t.ParamImage,
		t.ParamInt, t.ParamMoney, t.ParamNChar, t.ParamNText, t.ParamNVarChar, t.ParamReal, t.ParamUniqueIdentifier, t.ParamSmallDateTime, t.ParamSmallInt,
		t.ParamSmallMoney, t.ParamText, t.ParamTimestamp, t.ParamTinyInt, t.ParamVarBinary, t.ParamVarChar, t.ParamXml, t.ParamDate, t.ParamTime, 
		t.ParamDateTime2, t.ParamDateTimeOffset, 
		s.IntValue 'resultRank', dateadd(dd, s.IntValue, GETDATE()) 'resultUpdatedDate', ('User Name ' + CAST(s.IntValue AS VARCHAR(12))) 'resultUserName', 
		(10 - s.IntValue) 'resultUpdatedBy', ('Manifest content ' + CAST(s.IntValue AS VARCHAR(12))) 'resultTestManifest'
		FROM dbo.ApiTestAllTypesTest t 
		LEFT JOIN @paramStructured s ON t.ApiTestAllTypesTesttID = s.IntValue
		WHERE @takeId IS NULL
			OR @takeId IS NOT NULL
            AND t.ApiTestAllTypesTesttID = @takeId
END
go


create procedure dbo.sp_ProcClassResult
	@paramRowID INT, 
	-- types
	@paramBigInt BigInt, 
	@paramBinary Binary(24), 
	@paramBit Bit, 
	@paramChar Char(10), 
	@paramDateTime DateTime, 
	@paramDecimal DECIMAL(10,2), 
	@paramFloat FLOAT(37), 
	@paramImage Image, 
	@paramInt Int, 
	@paramMoney Money, 
	@paramNChar NChar(5), 
	@paramNText NText, 
	@paramNVarChar NVarChar(20), 
	@paramReal Real, 
	@paramUniqueIdentifier UniqueIdentifier, 
	@paramSmallDateTime SmallDateTime, 
	@paramSmallInt SmallInt, 
	@paramSmallMoney SmallMoney, 
	@paramText Text, 
	@paramTinyInt TinyInt, 
	@paramVarBinary VarBinary(1024), 
	@paramVarChar VarChar(20), 
	@paramXml Xml, 
	@paramStructured dbo.IntBitValuePairArrayType READONLY, 
	@paramDate Date, 
	@paramTime Time, 
	@paramDateTime2 DateTime2, 
	@paramDateTimeOffset DateTimeOffset, 
	-- typeDefs
	@paramRank int, 
	@paramUpdatedDate datetime, 
	@paramUserName varchar(64), 
	@outParamUpdatedBy int output, 
	@paramTestManifest text, 
	-- output params
	@outParamBigInt BigInt output, 
	@outParamBinary Binary(512) output, 
	@outParamBit Bit output, 
	@outParamChar Char(10) output, 
	@outParamDateTime DateTime output, 
	@outParamDecimal DECIMAL(10,2) output, 
	@outParamFloat FLOAT(37) output, 
	@outParamInt Int output, 
	@outParamMoney Money output, 
	@outParamNChar nchar(5) output, 
	@outParamNVarChar NVarChar(20) output, 
	@outParamReal Real output, 
	@outParamUniqueIdentifier UniqueIdentifier output, 
	@outParamSmallDateTime SmallDateTime output, 
	@outParamSmallInt SmallInt output, 
	@outParamSmallMoney SmallMoney output, 
	@outParamTimestamp Timestamp output, 
	@outParamTinyInt TinyInt output, 
	@outParamVarBinary VarBinary(1024) output, 
	@outParamVarChar VarChar(20) output, 
	@outParamXml Xml output, 
	@outParamDate Date output, 
	@outParamTime Time output, 
	@outParamDateTime2 DateTime2 output, 
	@outParamDateTimeOffset DateTimeOffset output, 
	-- in-output params
	@inOutParamBigInt BigInt output, 
	@inOutParamBinary Binary(512) output, 
	@inOutParamBit Bit output, 
	@inOutParamChar Char(10) output, 
	@inOutParamDateTime DateTime output, 
	@inOutParamDecimal DECIMAL(10,2) output, 
	@inOutParamFloat FLOAT(37) output, 
	@inOutParamInt Int output, 
	@inOutParamMoney Money output, 
	@inOutParamNChar nchar(5) output, 
	@inOutParamNVarChar NVarChar(20) output, 
	@inOutParamReal Real output, 
	@inOutParamUniqueIdentifier UniqueIdentifier output, 
	@inOutParamSmallDateTime SmallDateTime output, 
	@inOutParamSmallInt SmallInt output, 
	@inOutParamSmallMoney SmallMoney output, 
	@inOutParamTinyInt TinyInt output, 
	@inOutParamVarBinary VarBinary(1024) output, 
	@inOutParamVarChar VarChar(20) output, 
	@inOutParamXml Xml output, 
	@inOutParamDate Date output, 
	@inOutParamTime Time output, 
	@inOutParamDateTime2 DateTime2 output, 
	@inOutParamDateTimeOffset DateTimeOffset output
as
BEGIN
	EXEC dbo.sp_ProcCollectionResult @paramRowID, @paramBigInt, @paramBinary, @paramBit, @paramChar, @paramDateTime, @paramDecimal, @paramFloat, 
		@paramImage, @paramInt, @paramMoney, @paramNChar, @paramNText, @paramNVarChar, @paramReal, @paramUniqueIdentifier, 
		@paramSmallDateTime, @paramSmallInt, @paramSmallMoney, @paramText, @paramTinyInt, @paramVarBinary, @paramVarChar, @paramXml, 
		@paramStructured, @paramDate, @paramTime, @paramDateTime2, @paramDateTimeOffset, @paramRank, @paramUpdatedDate, 
		@paramUserName, @outParamUpdatedBy OUTPUT, @paramTestManifest, @outParamBigInt OUTPUT, @outParamBinary OUTPUT, 
		@outParamBit OUTPUT, @outParamChar OUTPUT, @outParamDateTime OUTPUT, @outParamDecimal OUTPUT, @outParamFloat OUTPUT, 
		@outParamInt OUTPUT, @outParamMoney OUTPUT, @outParamNChar OUTPUT, @outParamNVarChar OUTPUT, @outParamReal OUTPUT, 
		@outParamUniqueIdentifier OUTPUT, @outParamSmallDateTime OUTPUT, @outParamSmallInt OUTPUT, @outParamSmallMoney OUTPUT, 
		@outParamTimestamp OUTPUT, @outParamTinyInt OUTPUT, @outParamVarBinary OUTPUT, @outParamVarChar OUTPUT, 
		@outParamXml OUTPUT, @outParamDate OUTPUT, @outParamTime OUTPUT, @outParamDateTime2 OUTPUT, 
		@outParamDateTimeOffset OUTPUT, @inOutParamBigInt OUTPUT, @inOutParamBinary OUTPUT, @inOutParamBit OUTPUT, 
		@inOutParamChar OUTPUT, @inOutParamDateTime OUTPUT, @inOutParamDecimal OUTPUT, @inOutParamFloat OUTPUT, 
		@inOutParamInt OUTPUT, @inOutParamMoney OUTPUT, @inOutParamNChar OUTPUT, @inOutParamNVarChar OUTPUT, 
		@inOutParamReal OUTPUT, @inOutParamUniqueIdentifier OUTPUT, @inOutParamSmallDateTime OUTPUT, @inOutParamSmallInt OUTPUT, 
		@inOutParamSmallMoney OUTPUT, @inOutParamTinyInt OUTPUT, @inOutParamVarBinary OUTPUT, @inOutParamVarChar OUTPUT, 
		@inOutParamXml OUTPUT, @inOutParamDate OUTPUT, @inOutParamTime OUTPUT, @inOutParamDateTime2 OUTPUT,
		@inOutParamDateTimeOffset OUTPUT
END
go



create procedure dbo.sp_ProcDataSet
as
BEGIN
	-- first record set
	SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE 
		FROM INFORMATION_SCHEMA.TABLES where table_schema = 'dbo'
	-- second recordset 
	SELECT CATALOG_NAME, SCHEMA_NAME, SCHEMA_OWNER 
		FROM INFORMATION_SCHEMA.SCHEMATA 
end
go



create procedure dbo.sp_ProcExistingClassResult
	@paramRowID INT, 
	-- types
	@paramBigInt BigInt, 
	@paramBinary Binary(24), 
	@paramBit Bit, 
	@paramChar Char(10), 
	@paramDateTime DateTime, 
	@paramDecimal Decimal, 
	@paramFloat Float, 
	@paramImage Image, 
	@paramInt Int, 
	@paramMoney Money, 
	@paramNChar NChar(5), 
	@paramNText NText, 
	@paramNVarChar NVarChar(20), 
	@paramReal Real, 
	@paramUniqueIdentifier UniqueIdentifier, 
	@paramSmallDateTime SmallDateTime, 
	@paramSmallInt SmallInt, 
	@paramSmallMoney SmallMoney, 
	@paramText Text, 
	@paramTinyInt TinyInt, 
	@paramVarBinary VarBinary(1024), 
	@paramVarChar VarChar(20), 
	@paramXml Xml, 
	@paramStructured dbo.IntBitValuePairArrayType READONLY, 
	@paramDate Date, 
	@paramTime Time, 
	@paramDateTime2 DateTime2, 
	@paramDateTimeOffset DateTimeOffset, 
	-- typeDefs
	@paramRank int, 
	@paramUpdatedDate datetime, 
	@paramUserName varchar(64), 
	@outParamUpdatedBy int output, 
	@paramTestManifest text, 
	-- output params
	@outParamBigInt BigInt output, 
	@outParamBinary Binary(512) output, 
	@outParamBit Bit output, 
	@outParamChar Char(10) output, 
	@outParamDateTime DateTime output, 
	@outParamDecimal Decimal output, 
	@outParamFloat Float output, 
	@outParamInt Int output, 
	@outParamMoney Money output, 
	@outParamNChar nchar(5) output, 
	@outParamNVarChar NVarChar(20) output, 
	@outParamReal Real output, 
	@outParamUniqueIdentifier UniqueIdentifier output, 
	@outParamSmallDateTime SmallDateTime output, 
	@outParamSmallInt SmallInt output, 
	@outParamSmallMoney SmallMoney output, 
	@outParamTimestamp Timestamp output, 
	@outParamTinyInt TinyInt output, 
	@outParamVarBinary VarBinary(1024) output, 
	@outParamVarChar VarChar(20) output, 
	@outParamXml Xml output, 
	@outParamDate Date output, 
	@outParamTime Time output, 
	@outParamDateTime2 DateTime2 output, 
	@outParamDateTimeOffset DateTimeOffset output, 
	-- in-output params
	@inOutParamBigInt BigInt output, 
	@inOutParamBinary Binary(512) output, 
	@inOutParamBit Bit output, 
	@inOutParamChar Char(10) output, 
	@inOutParamDateTime DateTime output, 
	@inOutParamDecimal Decimal output, 
	@inOutParamFloat Float output, 
	@inOutParamInt Int output, 
	@inOutParamMoney Money output, 
	@inOutParamNChar nchar(5) output, 
	@inOutParamNVarChar NVarChar(20) output, 
	@inOutParamReal Real output, 
	@inOutParamUniqueIdentifier UniqueIdentifier output, 
	@inOutParamSmallDateTime SmallDateTime output, 
	@inOutParamSmallInt SmallInt output, 
	@inOutParamSmallMoney SmallMoney output, 
	@inOutParamTinyInt TinyInt output, 
	@inOutParamVarBinary VarBinary(1024) output, 
	@inOutParamVarChar VarChar(20) output, 
	@inOutParamXml Xml output, 
	@inOutParamDate Date output, 
	@inOutParamTime Time output, 
	@inOutParamDateTime2 DateTime2 output, 
	@inOutParamDateTimeOffset DateTimeOffset output
as
BEGIN
	EXEC dbo.sp_ProcCollectionResult @paramRowID, @paramBigInt, @paramBinary, @paramBit, @paramChar, @paramDateTime, @paramDecimal, @paramFloat, 
		@paramImage, @paramInt, @paramMoney, @paramNChar, @paramNText, @paramNVarChar, @paramReal, @paramUniqueIdentifier, 
		@paramSmallDateTime, @paramSmallInt, @paramSmallMoney, @paramText, @paramTinyInt, @paramVarBinary, @paramVarChar, @paramXml, 
		@paramStructured, @paramDate, @paramTime, @paramDateTime2, @paramDateTimeOffset, @paramRank, @paramUpdatedDate, 
		@paramUserName, @outParamUpdatedBy OUTPUT, @paramTestManifest, @outParamBigInt OUTPUT, @outParamBinary OUTPUT, 
		@outParamBit OUTPUT, @outParamChar OUTPUT, @outParamDateTime OUTPUT, @outParamDecimal OUTPUT, @outParamFloat OUTPUT, 
		@outParamInt OUTPUT, @outParamMoney OUTPUT, @outParamNChar OUTPUT, @outParamNVarChar OUTPUT, @outParamReal OUTPUT, 
		@outParamUniqueIdentifier OUTPUT, @outParamSmallDateTime OUTPUT, @outParamSmallInt OUTPUT, @outParamSmallMoney OUTPUT, 
		@outParamTimestamp OUTPUT, @outParamTinyInt OUTPUT, @outParamVarBinary OUTPUT, @outParamVarChar OUTPUT, 
		@outParamXml OUTPUT, @outParamDate OUTPUT, @outParamTime OUTPUT, @outParamDateTime2 OUTPUT, 
		@outParamDateTimeOffset OUTPUT, @inOutParamBigInt OUTPUT, @inOutParamBinary OUTPUT, @inOutParamBit OUTPUT, 
		@inOutParamChar OUTPUT, @inOutParamDateTime OUTPUT, @inOutParamDecimal OUTPUT, @inOutParamFloat OUTPUT, 
		@inOutParamInt OUTPUT, @inOutParamMoney OUTPUT, @inOutParamNChar OUTPUT, @inOutParamNVarChar OUTPUT, 
		@inOutParamReal OUTPUT, @inOutParamUniqueIdentifier OUTPUT, @inOutParamSmallDateTime OUTPUT, @inOutParamSmallInt OUTPUT, 
		@inOutParamSmallMoney OUTPUT, @inOutParamTinyInt OUTPUT, @inOutParamVarBinary OUTPUT, @inOutParamVarChar OUTPUT, 
		@inOutParamXml OUTPUT, @inOutParamDate OUTPUT, @inOutParamTime OUTPUT, @inOutParamDateTime2 OUTPUT,
		@inOutParamDateTimeOffset OUTPUT
END
go



create procedure dbo.sp_ProcExistingCollectionResult
	-- types
	@paramBigInt BigInt, 
	@paramBinary Binary(24), 
	@paramBit Bit, 
	@paramChar Char(10), 
	@paramDateTime DateTime, 
	@paramDecimal Decimal, 
	@paramFloat Float, 
	@paramImage Image, 
	@paramInt Int, 
	@paramMoney Money, 
	@paramNChar NChar(5), 
	@paramNText NText, 
	@paramNVarChar NVarChar(20), 
	@paramReal Real, 
	@paramUniqueIdentifier UniqueIdentifier, 
	@paramSmallDateTime SmallDateTime, 
	@paramSmallInt SmallInt, 
	@paramSmallMoney SmallMoney, 
	@paramText Text, 
	@paramTinyInt TinyInt, 
	@paramVarBinary VarBinary(1024), 
	@paramVarChar VarChar(20), 
	@paramXml Xml, 
	@paramStructured dbo.IntBitValuePairArrayType READONLY, 
	@paramDate Date, 
	@paramTime Time, 
	@paramDateTime2 DateTime2, 
	@paramDateTimeOffset DateTimeOffset, 
	-- typeDefs
	@paramRank int, 
	@paramUpdatedDate datetime, 
	@paramUserName varchar(64), 
	@outParamUpdatedBy int output, 
	@paramTestManifest text, 
	-- output params
	@outParamBigInt BigInt output, 
	@outParamBinary Binary(512) output, 
	@outParamBit Bit output, 
	@outParamChar Char(10) output, 
	@outParamDateTime DateTime output, 
	@outParamDecimal Decimal output, 
	@outParamFloat Float output, 
	@outParamInt Int output, 
	@outParamMoney Money output, 
	@outParamNChar nchar(5) output, 
	@outParamNVarChar NVarChar(20) output, 
	@outParamReal Real output, 
	@outParamUniqueIdentifier UniqueIdentifier output, 
	@outParamSmallDateTime SmallDateTime output, 
	@outParamSmallInt SmallInt output, 
	@outParamSmallMoney SmallMoney output, 
	@outParamTimestamp Timestamp output, 
	@outParamTinyInt TinyInt output, 
	@outParamVarBinary VarBinary(1024) output, 
	@outParamVarChar VarChar(20) output, 
	@outParamXml Xml output, 
	@outParamDate Date output, 
	@outParamTime Time output, 
	@outParamDateTime2 DateTime2 output, 
	@outParamDateTimeOffset DateTimeOffset output, 
	-- in-output params
	@inOutParamBigInt BigInt output, 
	@inOutParamBinary Binary(512) output, 
	@inOutParamBit Bit output, 
	@inOutParamChar Char(10) output, 
	@inOutParamDateTime DateTime output, 
	@inOutParamDecimal Decimal output, 
	@inOutParamFloat Float output, 
	@inOutParamInt Int output, 
	@inOutParamMoney Money output, 
	@inOutParamNChar nchar(5) output, 
	@inOutParamNVarChar NVarChar(20) output, 
	@inOutParamReal Real output, 
	@inOutParamUniqueIdentifier UniqueIdentifier output, 
	@inOutParamSmallDateTime SmallDateTime output, 
	@inOutParamSmallInt SmallInt output, 
	@inOutParamSmallMoney SmallMoney output, 
	@inOutParamTinyInt TinyInt output, 
	@inOutParamVarBinary VarBinary(1024) output, 
	@inOutParamVarChar VarChar(20) output, 
	@inOutParamXml Xml output, 
	@inOutParamDate Date output, 
	@inOutParamTime Time output, 
	@inOutParamDateTime2 DateTime2 output, 
	@inOutParamDateTimeOffset DateTimeOffset output
as
begin
	EXEC dbo.sp_ProcCollectionResult NULL, @paramBigInt, @paramBinary, @paramBit, @paramChar, @paramDateTime, @paramDecimal, @paramFloat, 
		@paramImage, @paramInt, @paramMoney, @paramNChar, @paramNText, @paramNVarChar, @paramReal, @paramUniqueIdentifier, 
		@paramSmallDateTime, @paramSmallInt, @paramSmallMoney, @paramText, @paramTinyInt, @paramVarBinary, @paramVarChar, @paramXml, 
		@paramStructured, @paramDate, @paramTime, @paramDateTime2, @paramDateTimeOffset, @paramRank, @paramUpdatedDate, 
		@paramUserName, @outParamUpdatedBy OUTPUT, @paramTestManifest, @outParamBigInt OUTPUT, @outParamBinary OUTPUT, 
		@outParamBit OUTPUT, @outParamChar OUTPUT, @outParamDateTime OUTPUT, @outParamDecimal OUTPUT, @outParamFloat OUTPUT, 
		@outParamInt OUTPUT, @outParamMoney OUTPUT, @outParamNChar OUTPUT, @outParamNVarChar OUTPUT, @outParamReal OUTPUT, 
		@outParamUniqueIdentifier OUTPUT, @outParamSmallDateTime OUTPUT, @outParamSmallInt OUTPUT, @outParamSmallMoney OUTPUT, 
		@outParamTimestamp OUTPUT, @outParamTinyInt OUTPUT, @outParamVarBinary OUTPUT, @outParamVarChar OUTPUT, 
		@outParamXml OUTPUT, @outParamDate OUTPUT, @outParamTime OUTPUT, @outParamDateTime2 OUTPUT, 
		@outParamDateTimeOffset OUTPUT, @inOutParamBigInt OUTPUT, @inOutParamBinary OUTPUT, @inOutParamBit OUTPUT, 
		@inOutParamChar OUTPUT, @inOutParamDateTime OUTPUT, @inOutParamDecimal OUTPUT, @inOutParamFloat OUTPUT, 
		@inOutParamInt OUTPUT, @inOutParamMoney OUTPUT, @inOutParamNChar OUTPUT, @inOutParamNVarChar OUTPUT, 
		@inOutParamReal OUTPUT, @inOutParamUniqueIdentifier OUTPUT, @inOutParamSmallDateTime OUTPUT, @inOutParamSmallInt OUTPUT, 
		@inOutParamSmallMoney OUTPUT, @inOutParamTinyInt OUTPUT, @inOutParamVarBinary OUTPUT, @inOutParamVarChar OUTPUT, 
		@inOutParamXml OUTPUT, @inOutParamDate OUTPUT, @inOutParamTime OUTPUT, @inOutParamDateTime2 OUTPUT,
		@inOutParamDateTimeOffset OUTPUT
END
go



create procedure dbo.sp_ProcNoResult
	@paramVarChar varchar(max)
as
BEGIN
	PRINT '@paramVarChar: ' + @paramVarChar
end
go



create procedure dbo.sp_ProcScalar
	@paramBigInt BIGINT null, 
	@eckry VARCHAR(50) OUTPUT
as
BEGIN
	set @eckry = @paramBigInt + 500
	select @paramBigInt + 10000 
end
go



create procedure dbo.sp_ProcTestNoApiMetaData
as
begin
	select 'A' 'FirstColumn', 'b' 'SecondColumn'
end
go

















USE [ApiEvaluateDB]
GO

if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcCollectionResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcCollectionResult
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcClassResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcClassResult
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcDataSet') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcDataSet
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcExistingClassResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcExistingClassResult
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcExistingCollectionResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcExistingCollectionResult
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcNoResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcNoResult
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcScalar') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcScalar
end
go
if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcTestNoApiMetaData') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcTestNoApiMetaData
end
go


IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'sen' AND TABLE_NAME = 'ApiTestSecondTest')
BEGIN
	DROP table sen.ApiTestSecondTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'sen' AND TABLE_NAME = 'ApiTestSeventhTest')
BEGIN
	DROP table sen.ApiTestSeventhTest
end
go
IF EXISTS (SELECT SCHEMA_ID FROM sys.schemas WHERE [name] = 'sen')
BEGIN 
	DROP SCHEMA sen
END
GO
CREATE SCHEMA sen AUTHORIZATION dbo
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestFirstTest')
BEGIN
	DROP table dbo.ApiTestFirstTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestAllTypesTest')
BEGIN
	DROP table dbo.ApiTestAllTypesTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestEighthTest')
BEGIN
	DROP table dbo.ApiTestEighthTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestFifthTest')
BEGIN
	DROP table dbo.ApiTestFifthTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestFourthTest')
BEGIN
	DROP table dbo.ApiTestFourthTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestMainTest')
BEGIN
	DROP table [dbo].ApiTestMainTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestThirdTest')
BEGIN
	DROP table dbo.ApiTestThirdTest
end
go
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestUser')
BEGIN
	DROP table dbo.ApiTestUser
end
go

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'IntBitValuePairArrayType')
BEGIN
	DROP TYPE dbo.IntBitValuePairArrayType
END


create table dbo.ApiTestUser
(
	UserID INT IDENTITY(1, 1) NOT NULL,
	UserName VARCHAR(50) NOT NULL, 
	[Rank] int NOT NULL, 
	CONSTRAINT PK_User PRIMARY KEY CLUSTERED (UserName ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


create table dbo.ApiTestAllTypesTest
(
	ApiTestAllTypesTesttID INT IDENTITY(1, 1) NOT NULL,
	ParamBigInt BigInt, 
	ParamBinary Binary(24), 
	ParamBit Bit, 
	ParamChar Char(10), 
	ParamDateTime DateTime, 
	ParamDecimal DECIMAL(37,5), 
	ParamFloat FLOAT(42), 
	ParamImage Image, 
	ParamInt Int, 
	ParamMoney Money, 
	ParamNChar NChar(5), 
	ParamNText NText, 
	ParamNVarChar NVarChar(20), 
	ParamReal Real, 
	ParamUniqueIdentifier UniqueIdentifier, 
	ParamSmallDateTime SmallDateTime, 
	ParamSmallInt SmallInt, 
	ParamSmallMoney SmallMoney, 
	ParamText Text, 
	ParamTimestamp Timestamp, 
	ParamTinyInt TinyInt, 
	ParamVarBinary VarBinary(1024), 
	ParamVarChar VarChar(20), 
	ParamXml Xml, 
	ParamDate Date, 
	ParamTime Time, 
	ParamDateTime2 DateTime2, 
	ParamDateTimeOffset DateTimeOffset, 
	CONSTRAINT PK_ApiTestAllTypesTesttTest PRIMARY KEY CLUSTERED (ApiTestAllTypesTesttID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, 
	ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, 
	ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar,
	ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)
	VALUES(1234567892, -- ParamBigInt - bigint
          CAST(3.575 AS BINARY(24)), -- ParamBinary - binary(24)
          1, -- ParamBit - bit
          'A', -- ParamChar - char(10)
		  CAST('2017-05-31 10:11:24.970' AS DATETIME), -- ParamDateTime - datetime
          500.005, -- ParamDecimal - decimal
          1.005, -- ParamFloat - float
          CAST(CAST(3.575 AS VARBINARY(512)) AS IMAGE), -- ParamImage - image
          5200, -- ParamInt - int
          4.99, -- ParamMoney - money
          N'nchar', -- ParamNChar - nchar(5)
          N'1.INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar, ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)', -- ParamNText - ntext
          N'ParamNVarChar nvarch', -- ParamNVarChar - nvarchar(20)
          0.075, -- ParamReal - real
          CAST('c89b5acd-9501-7ae7-d9a7-aabb07da2017' AS UNIQUEIDENTIFIER), -- ParamUniqueIdentifier - uniqueidentifier
          CAST('2017-04-30 10:11:24' AS SMALLDATETIME), -- ParamSmallDateTime - smalldatetime
          12, -- ParamSmallInt - smallint
          5.79, -- ParamSmallMoney - smallmoney
          '3.create table dbo.ApiTestAllTypesTest(ApiTestAllTypesTesttID INT IDENTITY(1, 1) NOT NULL, ParamBigInt BigInt, ParamBinary Binary(512), ParamBit Bit, ParamChar Char(10), ParamDateTime DateTime, ParamDecimal Decimal, ParamFloat Float, ParamImage Image, ParamInt Int, ParamMoney Money, ParamNChar NChar(5), ParamNText NText, ParamNVarChar NVarChar(20), ParamReal Real, ParamUniqueIdentifier UniqueIdentifier, ParamSmallDateTime SmallDateTime, ParamSmallInt SmallInt, ParamSmallMoney SmallMoney, ParamText Text, ParamTimestamp Timestamp, ParamTinyInt TinyInt, ParamVarBinary VarBinary(1024), ParamVarChar VarChar(20), ParamXml Xml, ParamDate Date, ParamTime Time, ParamDateTime2 DateTime2, ParamDateTimeOffset DateTimeOffset, CONSTRAINT PK_ApiTestAllTypesTesttTest PRIMARY KEY CLUSTERED (ApiTestAllTypesTesttID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] GO', -- ParamText - text
          7, -- ParamTinyInt - tinyint
          CAST(3.575 AS VARBINARY(1024)), -- ParamVarBinary - varbinary(1024)
          'ParamVarChar varchar', -- ParamVarChar - varchar(20)
          '<ParamXml1>Param Xml 1</ParamXml1>', -- ParamXml - xml
          DATEADD(dd, 3, GETDATE()), -- ParamDate - date
          CAST(GETDATE() AS TIME), -- ParamTime - time
          SYSDATETIME(), -- ParamDateTime2 - datetime2
          SYSDATETIMEOFFSET())  -- ParamDateTimeOffset - datetimeoffset
INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, 
	ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, 
	ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar,
	ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)
	VALUES(1234567891, -- ParamBigInt - bigint
          CAST(93.575 AS BINARY(24)), -- ParamBinary - binary(24)
          0, -- ParamBit - bit
          'B', -- ParamChar - char(10)
		  CAST('2017-05-31 10:09:24.970' AS DATETIME), -- ParamDateTime - datetime
          51, -- ParamDecimal - decimal
          1.055, -- ParamFloat - float
          CAST(CAST(93.575 AS VARBINARY(512)) AS IMAGE), -- ParamImage - image
          5000, -- ParamInt - int
          14.99, -- ParamMoney - money
          N'nchar', -- ParamNChar - nchar(5)
          N'2.INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar, ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)', -- ParamNText - ntext
          N'ParamNVarChar nvarch', -- ParamNVarChar - nvarchar(20)
          0.075, -- ParamReal - real
          CAST('c89b5acd-9501-7ae7-d9a7-aabb07dc2017' AS UNIQUEIDENTIFIER), -- ParamUniqueIdentifier - uniqueidentifier
          CAST('2017-04-30 10:11:24' AS SMALLDATETIME), -- ParamSmallDateTime - smalldatetime
          11, -- ParamSmallInt - smallint
          5.29, -- ParamSmallMoney - smallmoney
          '2.create table dbo.ApiTestAllTypesTest(ApiTestAllTypesTesttID INT IDENTITY(1, 1) NOT NULL, ParamBigInt BigInt, ParamBinary Binary(512), ParamBit Bit, ParamChar Char(10), ParamDateTime DateTime, ParamDecimal Decimal, ParamFloat Float, ParamImage Image, ParamInt Int, ParamMoney Money, ParamNChar NChar(5), ParamNText NText, ParamNVarChar NVarChar(20), ParamReal Real, ParamUniqueIdentifier UniqueIdentifier, ParamSmallDateTime SmallDateTime, ParamSmallInt SmallInt, ParamSmallMoney SmallMoney, ParamText Text, ParamTimestamp Timestamp, ParamTinyInt TinyInt, ParamVarBinary VarBinary(1024), ParamVarChar VarChar(20), ParamXml Xml, ParamDate Date, ParamTime Time, ParamDateTime2 DateTime2, ParamDateTimeOffset DateTimeOffset, CONSTRAINT PK_ApiTestAllTypesTesttTest PRIMARY KEY CLUSTERED (ApiTestAllTypesTesttID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] GO', -- ParamText - text
          9, -- ParamTinyInt - tinyint
          CAST(93.575 AS VARBINARY(1024)), -- ParamVarBinary - varbinary(1024)
          'ParamVarChar varchar', -- ParamVarChar - varchar(20)
          '<ParamXml2>Param Xml 2</ParamXml2>', -- ParamXml - xml
          DATEADD(dd, 2, GETDATE()), -- ParamDate - date
          CAST(GETDATE() AS TIME), -- ParamTime - time
          SYSDATETIME(), -- ParamDateTime2 - datetime2
          SYSDATETIMEOFFSET())  -- ParamDateTimeOffset - datetimeoffset
INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, 
	ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, 
	ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar,
	ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)
	VALUES(1234567890, -- ParamBigInt - bigint
          CAST(193.575 AS BINARY(24)), -- ParamBinary - binary(24)
          1, -- ParamBit - bit
          'C', -- ParamChar - char(10)
		  CAST('2017-05-31 10:10:24.970' AS DATETIME), -- ParamDateTime - datetime
          52, -- ParamDecimal - decimal
          1.505, -- ParamFloat - float
          CAST(CAST(193.575 AS VARBINARY(512)) AS IMAGE), -- ParamImage - image
          5030, -- ParamInt - int
          24.99, -- ParamMoney - money
          N'nchar', -- ParamNChar - nchar(5)
          N'3.INSERT INTO dbo.ApiTestAllTypesTest(ParamBigInt, ParamBinary, ParamBit, ParamChar, ParamDateTime, ParamDecimal, ParamFloat, ParamImage, ParamInt, ParamMoney, ParamNChar, ParamNText, ParamNVarChar, ParamReal, ParamUniqueIdentifier, ParamSmallDateTime, ParamSmallInt, ParamSmallMoney, ParamText, ParamTinyInt, ParamVarBinary, ParamVarChar, ParamXml, ParamDate, ParamTime, ParamDateTime2, ParamDateTimeOffset)', -- ParamNText - ntext
          N'ParamNVarChar nvarch', -- ParamNVarChar - nvarchar(20)
          0.075, -- ParamReal - real
          CAST('c89b5acd-9501-7ae7-d9a7-aabb07dd2017' AS UNIQUEIDENTIFIER), -- ParamUniqueIdentifier - uniqueidentifier
          CAST('2017-04-30 10:11:24' AS SMALLDATETIME), -- ParamSmallDateTime - smalldatetime
          10, -- ParamSmallInt - smallint
          5.09, -- ParamSmallMoney - smallmoney
          '1.create table dbo.ApiTestAllTypesTest(ApiTestAllTypesTesttID INT IDENTITY(1, 1) NOT NULL, ParamBigInt BigInt, ParamBinary Binary(512), ParamBit Bit, ParamChar Char(10), ParamDateTime DateTime, ParamDecimal Decimal, ParamFloat Float, ParamImage Image, ParamInt Int, ParamMoney Money, ParamNChar NChar(5), ParamNText NText, ParamNVarChar NVarChar(20), ParamReal Real, ParamUniqueIdentifier UniqueIdentifier, ParamSmallDateTime SmallDateTime, ParamSmallInt SmallInt, ParamSmallMoney SmallMoney, ParamText Text, ParamTimestamp Timestamp, ParamTinyInt TinyInt, ParamVarBinary VarBinary(1024), ParamVarChar VarChar(20), ParamXml Xml, ParamDate Date, ParamTime Time, ParamDateTime2 DateTime2, ParamDateTimeOffset DateTimeOffset, CONSTRAINT PK_ApiTestAllTypesTesttTest PRIMARY KEY CLUSTERED (ApiTestAllTypesTesttID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] GO', -- ParamText - text
          8, -- ParamTinyInt - tinyint
          CAST(193.575 AS VARBINARY(1024)), -- ParamVarBinary - varbinary(1024)
          'ParamVarChar varchar', -- ParamVarChar - varchar(20)
          '<ParamXml3>Param Xml 3</ParamXml3>', -- ParamXml - xml
          DATEADD(dd, 1, GETDATE()), -- ParamDate - date
          CAST(GETDATE() AS TIME), -- ParamTime - time
          SYSDATETIME(), -- ParamDateTime2 - datetime2
          SYSDATETIMEOFFSET())  -- ParamDateTimeOffset - datetimeoffset


CREATE TABLE [ApiTestEighthTest] ([EighthTestId] INT IDENTITY(1,1),Name VARCHAR(max) not null,Submited DATETIME,	Started DATETIME,	Pinged DATETIME, Terminated DATETIME, TerminationStatus VARCHAR(8),Message VARCHAR(512),TerminationInfo NTEXT)
GO


create table dbo.ApiTestFifthTest
(
	FifthTestID INT NOT NULL CONSTRAINT UC_FifthTest_FifthTestID UNIQUE(FifthTestID),
	Name VARCHAR(64) NOT NULL, 
	Rank int NOT NULL, -- order 
	CreatedDate DATETIME NOT NULL DEFAULT(GETDATE()),
	CreatedBy VARCHAR(50) NOT NULL CONSTRAINT FK_FifthTestCreatedBy_UserUserName REFERENCES dbo.ApiTestUser (UserName),
	UpdatedDate DATETIME NOT NULL DEFAULT(GETDATE()),
	UpdatedBy VARCHAR(50) NOT NULL CONSTRAINT FK_FifthTestUpdatedBy_UserUserName REFERENCES dbo.ApiTestUser (UserName),
	CONSTRAINT PK_FifthTests PRIMARY KEY CLUSTERED (FifthTestID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE 
TABLE 
[dbo].[ApiTestFirstTest]
(
	FirstTestID 
INT 
IDENTITY(1, 1) 
NOT NULL, -- IDENTITY COLUMN
	Selected [BIT] NOT NULL DEFAULT(0), 
	CreatedDate [DATETIME] NOT NULL DEFAULT(GETDATE()), UpdatedDate DATETIME NOT NULL DEFAULT(GETDATE()), [UpdatedBy] VARCHAR(50) NOT NULL CONSTRAINT FK_FirstTestID_FirstTestUpdatedBy_UsersUserName REFERENCES dbo.ApiTestUser (UserName),
	CONSTRAINT PK_FirstTest PRIMARY KEY CLUSTERED (FirstTestID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


create table dbo.ApiTestFourthTest
(
	FourthTestID INT IDENTITY(1, 1) NOT NULL,
	TypeID int NOT NULL,
	CreatedDate DATETIME NOT NULL DEFAULT(GETDATE()),
	UpdatedDate DATETIME NOT NULL DEFAULT(GETDATE()),
	UpdatedBy VARCHAR(50) NOT NULL CONSTRAINT FK_FourthTestUpdatedBy_UsersUserName REFERENCES dbo.ApiTestUser (UserName),
	CONSTRAINT PK_FourthTest PRIMARY KEY CLUSTERED (FourthTestID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].ApiTestMainTest
(
	MainTestID INT IDENTITY(1, 1) NOT NULL, -- IDENTITY COLUMN
	Selected [BIT] NOT NULL DEFAULT(0), 
	UpdatedOn DATETIME NOT NULL DEFAULT(GETDATE()), UpdatedBy VARCHAR(50) NOT NULL CONSTRAINT FK_MainTestUpdatedBy_UserUserName REFERENCES dbo.ApiTestUser (UserName),
	CONSTRAINT PK_MainTest PRIMARY KEY CLUSTERED (MainTestID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO 


CREATE TABLE dbo.ApiTestThirdTest(ThirdTestID INT IDENTITY(1, 1) NOT NULL, RangeFrom DATETIME NULL, RangeTo DATETIME NULL, CreatedDate DATETIME NOT NULL DEFAULT(GETDATE()),UpdatedDate DATETIME NOT NULL DEFAULT(GETDATE()),
	UpdatedBy VARCHAR(50) NOT NULL CONSTRAINT FK_ThirdTestUpdatedBy_UserUserName REFERENCES dbo.ApiTestUser (UserName)) 
GO


create table [sen].[ApiTestSecondTest]
(
	[SecondTestID] INT IDENTITY(1, 1) NOT NULL,        
	TestText VARCHAR(1024) NOT NULL,	TestManifest TEXT NOT NULL,	IsScheduled BIT NOT NULL,
	ScheduledDate DATETIME NOT NULL DEFAULT(GETDATE()),
	CONSTRAINT PK_SecondTest PRIMARY KEY CLUSTERED (SecondTestID ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] 
GO

CREATE table sen.ApiTestSeventhTest
(
	SeventhTestID INT NOT NULL,Name VARCHAR(64) NOT NULL,CreatedDate DATETIME NOT NULL DEFAULT(GETDATE())
) 
GO

create type dbo.IntBitValuePairArrayType as table 
(
    IntValue int NOT NULL,
    BitValue bit NOT NULL,
    PRIMARY KEY CLUSTERED(IntValue ASC) WITH (IGNORE_DUP_KEY = OFF)
)
GO


CREATE procedure dbo.sp_ProcCollectionResult
	@takeId int = NULL, 
	-- types
	@paramBigInt BigInt, 
	@paramBinary Binary(24), 
	@paramBit Bit, 
	@paramChar Char(10), 
	@paramDateTime DateTime, 
	@paramDecimal DECIMAL(32,5), 
	@paramFloat FLOAT(42), 
	@paramImage Image, 
	@paramInt Int, 
	@paramMoney Money, 
	@paramNChar NChar(5), 
	@paramNText NText, 
	@paramNVarChar NVarChar(20), 
	@paramReal Real, 
	@paramUniqueIdentifier UniqueIdentifier, 
	@paramSmallDateTime SmallDateTime, 
	@paramSmallInt SmallInt, 
	@paramSmallMoney SmallMoney, 
	@paramText Text, 
	@paramTinyInt TinyInt, 
	@paramVarBinary VarBinary(1024), 
	@paramVarChar VarChar(20), 
	@paramXml Xml, 
	@paramStructured dbo.IntBitValuePairArrayType READONLY, 
	@paramDate Date, 
	@paramTime Time, 
	@paramDateTime2 DateTime2, 
	@paramDateTimeOffset DateTimeOffset, 
	-- typeDefs
	@paramRank int, 
	@paramUpdatedDate datetime, 
	@paramUserName varchar(64), 
	@outParamUpdatedBy int output, 
	@paramTestManifest text, 
	-- output params
	@outParamBigInt BigInt output, 
	@outParamBinary Binary(512) output, 
	@outParamBit Bit output, 
	@outParamChar Char(10) output, 
	@outParamDateTime DateTime output, 
	@outparamDecimal DECIMAL(32,5) output, 
	@outParamFloat FLOAT(42) output, 
	@outParamInt Int output, 
	@outParamMoney Money output, 
	@outParamNChar nchar(5) output, 
	@outParamNVarChar NVarChar(20) output, 
	@outParamReal Real output, 
	@outParamUniqueIdentifier UniqueIdentifier output, 
	@outParamSmallDateTime SmallDateTime output, 
	@outParamSmallInt SmallInt output, 
	@outParamSmallMoney SmallMoney output, 
	@outParamTimestamp Timestamp output, 
	@outParamTinyInt TinyInt output, 
	@outParamVarBinary VarBinary(1024) output, 
	@outParamVarChar VarChar(20) output, 
	@outParamXml Xml output, 
	@outParamDate Date output, 
	@outParamTime Time output, 
	@outParamDateTime2 DateTime2 output, 
	@outParamDateTimeOffset DateTimeOffset output, 
	-- in-output params
	@inOutParamBigInt BigInt output, 
	@inOutParamBinary Binary(512) output, 
	@inOutParamBit Bit output, 
	@inOutParamChar Char(10) output, 
	@inOutParamDateTime DateTime output, 
	@inOutparamDecimal DECIMAL(32,5) output, 
	@inOutParamFloat FLOAT(42) output, 
	@inOutParamInt Int output, 
	@inOutParamMoney Money output, 
	@inOutParamNChar nchar(5) output, 
	@inOutParamNVarChar NVarChar(20) output, 
	@inOutParamReal Real output, 
	@inOutParamUniqueIdentifier UniqueIdentifier output, 
	@inOutParamSmallDateTime SmallDateTime output, 
	@inOutParamSmallInt SmallInt output, 
	@inOutParamSmallMoney SmallMoney output, 
	@inOutParamTinyInt TinyInt output, 
	@inOutParamVarBinary VarBinary(1024) output, 
	@inOutParamVarChar VarChar(20) output, 
	@inOutParamXml Xml output, 
	@inOutParamDate Date output, 
	@inOutParamTime Time output, 
	@inOutParamDateTime2 DateTime2 output, 
	@inOutParamDateTimeOffset DateTimeOffset output
as
begin
	-- set ouptup params
	SET @outParamUpdatedBy = @paramRank
	SET @outParamBigInt = @inOutParamBigInt
	SET @outParamBinary = @inOutParamBinary
	SET @outParamBit = @inOutParamBit
	SET @outParamChar = @inOutParamChar
	SET @outParamDateTime = @inOutParamDateTime
	SET @outParamDecimal = @inOutParamDecimal
	SET @outParamFloat = @inOutParamFloat
	SET @outParamInt = @inOutParamInt
	SET @outParamMoney = @inOutParamMoney
	SET @outParamNChar = @inOutParamNChar
	SET @outParamNVarChar = @inOutParamNVarChar
	SET @outParamReal = @inOutParamReal
	SET @outParamUniqueIdentifier = @inOutParamUniqueIdentifier
	SET @outParamSmallDateTime = @inOutParamSmallDateTime 
	SET @outParamSmallInt = @inOutParamSmallInt 
	SET @outParamSmallMoney = @inOutParamSmallMoney 
	SET @outParamTimestamp = CAST(GETDATE() AS TIMESTAMP) 
	SET @outParamTinyInt = @inOutParamTinyInt 
	SET @outParamVarBinary = @inOutParamVarBinary 
	SET @outParamVarChar = @inOutParamVarChar 
	SET @outParamXml = @inOutParamXml 
	SET @outParamDate = @inOutParamDate 
	SET @outParamTime = @inOutParamTime 
	SET @outParamDateTime2 = @inOutParamDateTime2 
	SET @outParamDateTimeOffset = @inOutParamDateTimeOffset 
	-- set in-output params
	SET @inOutParamBigInt = @paramBigInt
	SET @inOutParamBinary = @paramBinary 
	SET @inOutParamBit = @paramBit 
	SET @inOutParamChar = @paramChar 
	SET @inOutParamDateTime = @paramDateTime 
	SET @inOutParamDecimal = @paramDecimal 
	SET @inOutParamFloat = @paramFloat 
	SET @inOutParamInt = @paramInt 
	SET @inOutParamMoney = @paramMoney
	SET @inOutParamNChar = @paramNChar 
	SET @inOutParamNVarChar = @paramNVarChar 
	SET @inOutParamReal = @paramReal 
	SET @inOutParamUniqueIdentifier = @paramUniqueIdentifier 
	SET @inOutParamSmallDateTime = @paramSmallDateTime 
	SET @inOutParamSmallInt = @paramSmallInt 
	SET @inOutParamSmallMoney = @paramSmallMoney 
	SET @inOutParamTinyInt = @paramTinyInt 
	SET @inOutParamVarBinary = @paramVarBinary 
	SET @inOutParamVarChar = @paramVarChar 
	SET @inOutParamXml = @paramXml 
	SET @inOutParamDate = @paramDate 
	SET @inOutParamTime = @paramTime 
	SET @inOutParamDateTime2 = @paramDateTime2 
	SET @inOutParamDateTimeOffset = @paramDateTimeOffset 

	SELECT t.ApiTestAllTypesTesttID, t.ParamBigInt, t.ParamBinary, t.ParamBit, t.ParamChar, t.ParamDateTime, t.ParamDecimal, t.ParamFloat, t.ParamImage,
		t.ParamInt, t.ParamMoney, t.ParamNChar, t.ParamNText, t.ParamNVarChar, t.ParamReal, t.ParamUniqueIdentifier, t.ParamSmallDateTime, t.ParamSmallInt,
		t.ParamSmallMoney, t.ParamText, t.ParamTimestamp, t.ParamTinyInt, t.ParamVarBinary, t.ParamVarChar, t.ParamXml, t.ParamDate, t.ParamTime, 
		t.ParamDateTime2, t.ParamDateTimeOffset, 
		s.IntValue 'resultRank', dateadd(dd, s.IntValue, GETDATE()) 'resultUpdatedDate', ('User Name ' + CAST(s.IntValue AS VARCHAR(12))) 'resultUserName', 
		(10 - s.IntValue) 'resultUpdatedBy', ('Manifest content ' + CAST(s.IntValue AS VARCHAR(12))) 'resultTestManifest'
		FROM dbo.ApiTestAllTypesTest t 
		LEFT JOIN @paramStructured s ON t.ApiTestAllTypesTesttID = s.IntValue
		WHERE @takeId IS NULL
			OR @takeId IS NOT NULL
            AND t.ApiTestAllTypesTesttID = @takeId
END
go


create procedure dbo.sp_ProcClassResult
	@paramRowID INT, 
	-- types
	@paramBigInt BigInt, 
	@paramBinary Binary(24), 
	@paramBit Bit, 
	@paramChar Char(10), 
	@paramDateTime DateTime, 
	@paramDecimal DECIMAL(10,2), 
	@paramFloat FLOAT(37), 
	@paramImage Image, 
	@paramInt Int, 
	@paramMoney Money, 
	@paramNChar NChar(5), 
	@paramNText NText, 
	@paramNVarChar NVarChar(20), 
	@paramReal Real, 
	@paramUniqueIdentifier UniqueIdentifier, 
	@paramSmallDateTime SmallDateTime, 
	@paramSmallInt SmallInt, 
	@paramSmallMoney SmallMoney, 
	@paramText Text, 
	@paramTinyInt TinyInt, 
	@paramVarBinary VarBinary(1024), 
	@paramVarChar VarChar(20), 
	@paramXml Xml, 
	@paramStructured dbo.IntBitValuePairArrayType READONLY, 
	@paramDate Date, 
	@paramTime Time, 
	@paramDateTime2 DateTime2, 
	@paramDateTimeOffset DateTimeOffset, 
	-- typeDefs
	@paramRank int, 
	@paramUpdatedDate datetime, 
	@paramUserName varchar(64), 
	@outParamUpdatedBy int output, 
	@paramTestManifest text, 
	-- output params
	@outParamBigInt BigInt output, 
	@outParamBinary Binary(512) output, 
	@outParamBit Bit output, 
	@outParamChar Char(10) output, 
	@outParamDateTime DateTime output, 
	@outParamDecimal DECIMAL(10,2) output, 
	@outParamFloat FLOAT(37) output, 
	@outParamInt Int output, 
	@outParamMoney Money output, 
	@outParamNChar nchar(5) output, 
	@outParamNVarChar NVarChar(20) output, 
	@outParamReal Real output, 
	@outParamUniqueIdentifier UniqueIdentifier output, 
	@outParamSmallDateTime SmallDateTime output, 
	@outParamSmallInt SmallInt output, 
	@outParamSmallMoney SmallMoney output, 
	@outParamTimestamp Timestamp output, 
	@outParamTinyInt TinyInt output, 
	@outParamVarBinary VarBinary(1024) output, 
	@outParamVarChar VarChar(20) output, 
	@outParamXml Xml output, 
	@outParamDate Date output, 
	@outParamTime Time output, 
	@outParamDateTime2 DateTime2 output, 
	@outParamDateTimeOffset DateTimeOffset output, 
	-- in-output params
	@inOutParamBigInt BigInt output, 
	@inOutParamBinary Binary(512) output, 
	@inOutParamBit Bit output, 
	@inOutParamChar Char(10) output, 
	@inOutParamDateTime DateTime output, 
	@inOutParamDecimal DECIMAL(10,2) output, 
	@inOutParamFloat FLOAT(37) output, 
	@inOutParamInt Int output, 
	@inOutParamMoney Money output, 
	@inOutParamNChar nchar(5) output, 
	@inOutParamNVarChar NVarChar(20) output, 
	@inOutParamReal Real output, 
	@inOutParamUniqueIdentifier UniqueIdentifier output, 
	@inOutParamSmallDateTime SmallDateTime output, 
	@inOutParamSmallInt SmallInt output, 
	@inOutParamSmallMoney SmallMoney output, 
	@inOutParamTinyInt TinyInt output, 
	@inOutParamVarBinary VarBinary(1024) output, 
	@inOutParamVarChar VarChar(20) output, 
	@inOutParamXml Xml output, 
	@inOutParamDate Date output, 
	@inOutParamTime Time output, 
	@inOutParamDateTime2 DateTime2 output, 
	@inOutParamDateTimeOffset DateTimeOffset output
as
BEGIN
	EXEC dbo.sp_ProcCollectionResult @paramRowID, @paramBigInt, @paramBinary, @paramBit, @paramChar, @paramDateTime, @paramDecimal, @paramFloat, 
		@paramImage, @paramInt, @paramMoney, @paramNChar, @paramNText, @paramNVarChar, @paramReal, @paramUniqueIdentifier, 
		@paramSmallDateTime, @paramSmallInt, @paramSmallMoney, @paramText, @paramTinyInt, @paramVarBinary, @paramVarChar, @paramXml, 
		@paramStructured, @paramDate, @paramTime, @paramDateTime2, @paramDateTimeOffset, @paramRank, @paramUpdatedDate, 
		@paramUserName, @outParamUpdatedBy OUTPUT, @paramTestManifest, @outParamBigInt OUTPUT, @outParamBinary OUTPUT, 
		@outParamBit OUTPUT, @outParamChar OUTPUT, @outParamDateTime OUTPUT, @outParamDecimal OUTPUT, @outParamFloat OUTPUT, 
		@outParamInt OUTPUT, @outParamMoney OUTPUT, @outParamNChar OUTPUT, @outParamNVarChar OUTPUT, @outParamReal OUTPUT, 
		@outParamUniqueIdentifier OUTPUT, @outParamSmallDateTime OUTPUT, @outParamSmallInt OUTPUT, @outParamSmallMoney OUTPUT, 
		@outParamTimestamp OUTPUT, @outParamTinyInt OUTPUT, @outParamVarBinary OUTPUT, @outParamVarChar OUTPUT, 
		@outParamXml OUTPUT, @outParamDate OUTPUT, @outParamTime OUTPUT, @outParamDateTime2 OUTPUT, 
		@outParamDateTimeOffset OUTPUT, @inOutParamBigInt OUTPUT, @inOutParamBinary OUTPUT, @inOutParamBit OUTPUT, 
		@inOutParamChar OUTPUT, @inOutParamDateTime OUTPUT, @inOutParamDecimal OUTPUT, @inOutParamFloat OUTPUT, 
		@inOutParamInt OUTPUT, @inOutParamMoney OUTPUT, @inOutParamNChar OUTPUT, @inOutParamNVarChar OUTPUT, 
		@inOutParamReal OUTPUT, @inOutParamUniqueIdentifier OUTPUT, @inOutParamSmallDateTime OUTPUT, @inOutParamSmallInt OUTPUT, 
		@inOutParamSmallMoney OUTPUT, @inOutParamTinyInt OUTPUT, @inOutParamVarBinary OUTPUT, @inOutParamVarChar OUTPUT, 
		@inOutParamXml OUTPUT, @inOutParamDate OUTPUT, @inOutParamTime OUTPUT, @inOutParamDateTime2 OUTPUT,
		@inOutParamDateTimeOffset OUTPUT
END
go



create procedure dbo.sp_ProcDataSet
as
BEGIN
	-- first record set
	SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE 
		FROM INFORMATION_SCHEMA.TABLES where table_schema = 'dbo'
	-- second recordset 
	SELECT CATALOG_NAME, SCHEMA_NAME, SCHEMA_OWNER 
		FROM INFORMATION_SCHEMA.SCHEMATA 
end
go



create procedure dbo.sp_ProcExistingClassResult
	@paramRowID INT, 
	-- types
	@paramBigInt BigInt, 
	@paramBinary Binary(24), 
	@paramBit Bit, 
	@paramChar Char(10), 
	@paramDateTime DateTime, 
	@paramDecimal Decimal, 
	@paramFloat Float, 
	@paramImage Image, 
	@paramInt Int, 
	@paramMoney Money, 
	@paramNChar NChar(5), 
	@paramNText NText, 
	@paramNVarChar NVarChar(20), 
	@paramReal Real, 
	@paramUniqueIdentifier UniqueIdentifier, 
	@paramSmallDateTime SmallDateTime, 
	@paramSmallInt SmallInt, 
	@paramSmallMoney SmallMoney, 
	@paramText Text, 
	@paramTinyInt TinyInt, 
	@paramVarBinary VarBinary(1024), 
	@paramVarChar VarChar(20), 
	@paramXml Xml, 
	@paramStructured dbo.IntBitValuePairArrayType READONLY, 
	@paramDate Date, 
	@paramTime Time, 
	@paramDateTime2 DateTime2, 
	@paramDateTimeOffset DateTimeOffset, 
	-- typeDefs
	@paramRank int, 
	@paramUpdatedDate datetime, 
	@paramUserName varchar(64), 
	@outParamUpdatedBy int output, 
	@paramTestManifest text, 
	-- output params
	@outParamBigInt BigInt output, 
	@outParamBinary Binary(512) output, 
	@outParamBit Bit output, 
	@outParamChar Char(10) output, 
	@outParamDateTime DateTime output, 
	@outParamDecimal Decimal output, 
	@outParamFloat Float output, 
	@outParamInt Int output, 
	@outParamMoney Money output, 
	@outParamNChar nchar(5) output, 
	@outParamNVarChar NVarChar(20) output, 
	@outParamReal Real output, 
	@outParamUniqueIdentifier UniqueIdentifier output, 
	@outParamSmallDateTime SmallDateTime output, 
	@outParamSmallInt SmallInt output, 
	@outParamSmallMoney SmallMoney output, 
	@outParamTimestamp Timestamp output, 
	@outParamTinyInt TinyInt output, 
	@outParamVarBinary VarBinary(1024) output, 
	@outParamVarChar VarChar(20) output, 
	@outParamXml Xml output, 
	@outParamDate Date output, 
	@outParamTime Time output, 
	@outParamDateTime2 DateTime2 output, 
	@outParamDateTimeOffset DateTimeOffset output, 
	-- in-output params
	@inOutParamBigInt BigInt output, 
	@inOutParamBinary Binary(512) output, 
	@inOutParamBit Bit output, 
	@inOutParamChar Char(10) output, 
	@inOutParamDateTime DateTime output, 
	@inOutParamDecimal Decimal output, 
	@inOutParamFloat Float output, 
	@inOutParamInt Int output, 
	@inOutParamMoney Money output, 
	@inOutParamNChar nchar(5) output, 
	@inOutParamNVarChar NVarChar(20) output, 
	@inOutParamReal Real output, 
	@inOutParamUniqueIdentifier UniqueIdentifier output, 
	@inOutParamSmallDateTime SmallDateTime output, 
	@inOutParamSmallInt SmallInt output, 
	@inOutParamSmallMoney SmallMoney output, 
	@inOutParamTinyInt TinyInt output, 
	@inOutParamVarBinary VarBinary(1024) output, 
	@inOutParamVarChar VarChar(20) output, 
	@inOutParamXml Xml output, 
	@inOutParamDate Date output, 
	@inOutParamTime Time output, 
	@inOutParamDateTime2 DateTime2 output, 
	@inOutParamDateTimeOffset DateTimeOffset output
as
BEGIN
	EXEC dbo.sp_ProcCollectionResult @paramRowID, @paramBigInt, @paramBinary, @paramBit, @paramChar, @paramDateTime, @paramDecimal, @paramFloat, 
		@paramImage, @paramInt, @paramMoney, @paramNChar, @paramNText, @paramNVarChar, @paramReal, @paramUniqueIdentifier, 
		@paramSmallDateTime, @paramSmallInt, @paramSmallMoney, @paramText, @paramTinyInt, @paramVarBinary, @paramVarChar, @paramXml, 
		@paramStructured, @paramDate, @paramTime, @paramDateTime2, @paramDateTimeOffset, @paramRank, @paramUpdatedDate, 
		@paramUserName, @outParamUpdatedBy OUTPUT, @paramTestManifest, @outParamBigInt OUTPUT, @outParamBinary OUTPUT, 
		@outParamBit OUTPUT, @outParamChar OUTPUT, @outParamDateTime OUTPUT, @outParamDecimal OUTPUT, @outParamFloat OUTPUT, 
		@outParamInt OUTPUT, @outParamMoney OUTPUT, @outParamNChar OUTPUT, @outParamNVarChar OUTPUT, @outParamReal OUTPUT, 
		@outParamUniqueIdentifier OUTPUT, @outParamSmallDateTime OUTPUT, @outParamSmallInt OUTPUT, @outParamSmallMoney OUTPUT, 
		@outParamTimestamp OUTPUT, @outParamTinyInt OUTPUT, @outParamVarBinary OUTPUT, @outParamVarChar OUTPUT, 
		@outParamXml OUTPUT, @outParamDate OUTPUT, @outParamTime OUTPUT, @outParamDateTime2 OUTPUT, 
		@outParamDateTimeOffset OUTPUT, @inOutParamBigInt OUTPUT, @inOutParamBinary OUTPUT, @inOutParamBit OUTPUT, 
		@inOutParamChar OUTPUT, @inOutParamDateTime OUTPUT, @inOutParamDecimal OUTPUT, @inOutParamFloat OUTPUT, 
		@inOutParamInt OUTPUT, @inOutParamMoney OUTPUT, @inOutParamNChar OUTPUT, @inOutParamNVarChar OUTPUT, 
		@inOutParamReal OUTPUT, @inOutParamUniqueIdentifier OUTPUT, @inOutParamSmallDateTime OUTPUT, @inOutParamSmallInt OUTPUT, 
		@inOutParamSmallMoney OUTPUT, @inOutParamTinyInt OUTPUT, @inOutParamVarBinary OUTPUT, @inOutParamVarChar OUTPUT, 
		@inOutParamXml OUTPUT, @inOutParamDate OUTPUT, @inOutParamTime OUTPUT, @inOutParamDateTime2 OUTPUT,
		@inOutParamDateTimeOffset OUTPUT
END
go



create procedure dbo.sp_ProcExistingCollectionResult
	-- types
	@paramBigInt BigInt, 
	@paramBinary Binary(24), 
	@paramBit Bit, 
	@paramChar Char(10), 
	@paramDateTime DateTime, 
	@paramDecimal Decimal, 
	@paramFloat Float, 
	@paramImage Image, 
	@paramInt Int, 
	@paramMoney Money, 
	@paramNChar NChar(5), 
	@paramNText NText, 
	@paramNVarChar NVarChar(20), 
	@paramReal Real, 
	@paramUniqueIdentifier UniqueIdentifier, 
	@paramSmallDateTime SmallDateTime, 
	@paramSmallInt SmallInt, 
	@paramSmallMoney SmallMoney, 
	@paramText Text, 
	@paramTinyInt TinyInt, 
	@paramVarBinary VarBinary(1024), 
	@paramVarChar VarChar(20), 
	@paramXml Xml, 
	@paramStructured dbo.IntBitValuePairArrayType READONLY, 
	@paramDate Date, 
	@paramTime Time, 
	@paramDateTime2 DateTime2, 
	@paramDateTimeOffset DateTimeOffset, 
	-- typeDefs
	@paramRank int, 
	@paramUpdatedDate datetime, 
	@paramUserName varchar(64), 
	@outParamUpdatedBy int output, 
	@paramTestManifest text, 
	-- output params
	@outParamBigInt BigInt output, 
	@outParamBinary Binary(512) output, 
	@outParamBit Bit output, 
	@outParamChar Char(10) output, 
	@outParamDateTime DateTime output, 
	@outParamDecimal Decimal output, 
	@outParamFloat Float output, 
	@outParamInt Int output, 
	@outParamMoney Money output, 
	@outParamNChar nchar(5) output, 
	@outParamNVarChar NVarChar(20) output, 
	@outParamReal Real output, 
	@outParamUniqueIdentifier UniqueIdentifier output, 
	@outParamSmallDateTime SmallDateTime output, 
	@outParamSmallInt SmallInt output, 
	@outParamSmallMoney SmallMoney output, 
	@outParamTimestamp Timestamp output, 
	@outParamTinyInt TinyInt output, 
	@outParamVarBinary VarBinary(1024) output, 
	@outParamVarChar VarChar(20) output, 
	@outParamXml Xml output, 
	@outParamDate Date output, 
	@outParamTime Time output, 
	@outParamDateTime2 DateTime2 output, 
	@outParamDateTimeOffset DateTimeOffset output, 
	-- in-output params
	@inOutParamBigInt BigInt output, 
	@inOutParamBinary Binary(512) output, 
	@inOutParamBit Bit output, 
	@inOutParamChar Char(10) output, 
	@inOutParamDateTime DateTime output, 
	@inOutParamDecimal Decimal output, 
	@inOutParamFloat Float output, 
	@inOutParamInt Int output, 
	@inOutParamMoney Money output, 
	@inOutParamNChar nchar(5) output, 
	@inOutParamNVarChar NVarChar(20) output, 
	@inOutParamReal Real output, 
	@inOutParamUniqueIdentifier UniqueIdentifier output, 
	@inOutParamSmallDateTime SmallDateTime output, 
	@inOutParamSmallInt SmallInt output, 
	@inOutParamSmallMoney SmallMoney output, 
	@inOutParamTinyInt TinyInt output, 
	@inOutParamVarBinary VarBinary(1024) output, 
	@inOutParamVarChar VarChar(20) output, 
	@inOutParamXml Xml output, 
	@inOutParamDate Date output, 
	@inOutParamTime Time output, 
	@inOutParamDateTime2 DateTime2 output, 
	@inOutParamDateTimeOffset DateTimeOffset output
as
begin
	EXEC dbo.sp_ProcCollectionResult NULL, @paramBigInt, @paramBinary, @paramBit, @paramChar, @paramDateTime, @paramDecimal, @paramFloat, 
		@paramImage, @paramInt, @paramMoney, @paramNChar, @paramNText, @paramNVarChar, @paramReal, @paramUniqueIdentifier, 
		@paramSmallDateTime, @paramSmallInt, @paramSmallMoney, @paramText, @paramTinyInt, @paramVarBinary, @paramVarChar, @paramXml, 
		@paramStructured, @paramDate, @paramTime, @paramDateTime2, @paramDateTimeOffset, @paramRank, @paramUpdatedDate, 
		@paramUserName, @outParamUpdatedBy OUTPUT, @paramTestManifest, @outParamBigInt OUTPUT, @outParamBinary OUTPUT, 
		@outParamBit OUTPUT, @outParamChar OUTPUT, @outParamDateTime OUTPUT, @outParamDecimal OUTPUT, @outParamFloat OUTPUT, 
		@outParamInt OUTPUT, @outParamMoney OUTPUT, @outParamNChar OUTPUT, @outParamNVarChar OUTPUT, @outParamReal OUTPUT, 
		@outParamUniqueIdentifier OUTPUT, @outParamSmallDateTime OUTPUT, @outParamSmallInt OUTPUT, @outParamSmallMoney OUTPUT, 
		@outParamTimestamp OUTPUT, @outParamTinyInt OUTPUT, @outParamVarBinary OUTPUT, @outParamVarChar OUTPUT, 
		@outParamXml OUTPUT, @outParamDate OUTPUT, @outParamTime OUTPUT, @outParamDateTime2 OUTPUT, 
		@outParamDateTimeOffset OUTPUT, @inOutParamBigInt OUTPUT, @inOutParamBinary OUTPUT, @inOutParamBit OUTPUT, 
		@inOutParamChar OUTPUT, @inOutParamDateTime OUTPUT, @inOutParamDecimal OUTPUT, @inOutParamFloat OUTPUT, 
		@inOutParamInt OUTPUT, @inOutParamMoney OUTPUT, @inOutParamNChar OUTPUT, @inOutParamNVarChar OUTPUT, 
		@inOutParamReal OUTPUT, @inOutParamUniqueIdentifier OUTPUT, @inOutParamSmallDateTime OUTPUT, @inOutParamSmallInt OUTPUT, 
		@inOutParamSmallMoney OUTPUT, @inOutParamTinyInt OUTPUT, @inOutParamVarBinary OUTPUT, @inOutParamVarChar OUTPUT, 
		@inOutParamXml OUTPUT, @inOutParamDate OUTPUT, @inOutParamTime OUTPUT, @inOutParamDateTime2 OUTPUT,
		@inOutParamDateTimeOffset OUTPUT
END
go



create procedure dbo.sp_ProcNoResult
	@paramVarChar varchar(max)
as
BEGIN
	PRINT '@paramVarChar: ' + @paramVarChar
end
go



create procedure dbo.sp_ProcScalar
	@paramBigInt BIGINT null, 
	@eckry VARCHAR(50) OUTPUT
as
BEGIN
	set @eckry = @paramBigInt + 500
	select @paramBigInt + 10000 
end
go



create procedure dbo.sp_ProcTestNoApiMetaData
as
begin
	select 'A' 'FirstColumn', 'b' 'SecondColumn'
end
go
