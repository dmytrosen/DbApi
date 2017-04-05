USE [ApiTestDB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestAllTypesTest')
BEGIN
	DROP table dbo.ApiTestAllTypesTest
end
go

/* HISTORY   
	12/14/2016 - dsen 
*/ 	
/* DESCRIPTION  
	...
*/
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

--SELECT * FROM dbo.ApiTestAllTypesTest
