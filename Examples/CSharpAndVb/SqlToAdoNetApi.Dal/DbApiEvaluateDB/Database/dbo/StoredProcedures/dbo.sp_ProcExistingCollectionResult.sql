USE ApiEvaluateDB

/* HISTORY   
	03/25/2017 - dsen 
*/ 	

if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcExistingCollectionResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcExistingCollectionResult
end
go
/* DESCRIPTION  
	SYSTEM: Test Corporate
	RETURNS: 
*/
/* DBAPI metadata
	<DbApiMetadata method="GetExistingCollectionResult" description="Get ProcExistingCollectionResult">
		<ProcParams>
			<!--ProcParams Input parameters-->
			<InParam name="paramBigInt" type="BigInt" />
			<InParam name="paramBinary" type="Binary(512)" description="Binary parameter" />
			<InParam name="paramBit" type="Bit" nullable="true" description="Bit parameter" />
			<InParam name="paramChar" type="Char(10)" description="Char parameter" />
			<InParam name="paramDateTime" type="DateTime" nullable="false" description="DateTime parameter" />
			<InParam name="paramDecimal" type="Decimal" nullable="true" description="Decimal parameter" />
			<InParam name="paramFloat" type="Float" description="Float parameter" />
			<InParam name="paramImage" type="Image" description="Image parameter" />
			<InParam name="paramInt" type="Int" nullable="true" description="Int parameter" />
			<InParam name="paramMoney" type="Money" nullable="false" description="Money parameter" />
			<InParam name="paramNChar" type="NChar(5)" description="NChar parameter" />
			<InParam name="paramNText" type="NText" description="NText parameter" />
			<InParam name="paramNVarChar" type="NVarChar(20)" description="NVarChar parameter" />
			<InParam name="paramReal" type="Real" nullable="true" description="Real parameter" />
			<InParam name="paramUniqueIdentifier" type="UniqueIdentifier" description="UniqueIdentifier parameter" />
			<InParam name="paramSmallDateTime" type="SmallDateTime" nullable="false" description="SmallDateTime parameter" />
			<InParam name="paramSmallInt" type="SmallInt" nullable="true" description="SmallInt parameter" />
			<InParam name="paramSmallMoney" type="SmallMoney" description="SmallMoney parameter" />
			<InParam name="paramText" type="Text" description="Text parameter" />
			<InParam name="paramTinyInt" type="TinyInt" nullable="true" description="TinyInt parameter" />
			<InParam name="paramVarBinary" type="VarBinary(1024)" description="VarBinary parameter" />
			<InParam name="paramVarChar" type="VarChar(8000)" description="VarChar parameter" />
			<InParam name="paramXml" type="Xml" description="Xml parameter" />
			<InParam name="paramStructured" type="Structured" description="Structured parameter" />
			<InParam name="paramDate" type="Date" nullable="false" description="Date parameter" />
			<InParam name="paramTime" type="Time" nullable="true" description="Time parameter" />
			<InParam name="paramDateTime2" type="DateTime2" description="DateTime2 parameter" />
			<InParam name="paramDateTimeOffset" type="DateTimeOffset" nullable="true" description="DateTimeOffset parameter" />
			<!--ProcParams mixed typeDef parameters-->
			<InParam name="paramRank" typeDef="dbo.ApiTestUser.Rank" description="Rank parameter owerriden" />
			<InParam name="paramUpdatedDate" typeDef="ApiTestMainTest.UpdatedOn" />
			<InParam name="paramUserName" typeDef="dbo.ApiTestUser.UserName" description="User Name parameter owerriden" />
			<OutParam name="outParamUpdatedBy" typeDef="ApiTestUser.UserID" />
			<InParam name="paramTestManifest" typeDef="sen.ApiTestSecondTest.TestManifest" description="Test Manifest parameter owerriden" />
			<!--ProcParams Output parameters-->
			<OutParam name="outParamBigInt" type="BigInt" nullable="false" description="BigInt output parameter" />
			<OutParam name="outParamBinary" type="Binary(512)" description="Binary output parameter" />
			<OutParam name="outParamBit" type="Bit" nullable="true" description="Bit output parameter" />
			<OutParam name="outParamChar" type="Char(10)" description="Char output parameter" />
			<OutParam name="outParamDateTime" type="DateTime" description="DateTime output parameter" />
			<OutParam name="outParamDecimal" type="Decimal" nullable="true" description="Decimal output parameter" />
			<OutParam name="outParamFloat" type="Float" nullable="false" description="Float output parameter" />
			<OutParam name="outParamInt" type="Int" nullable="true" description="Int output parameter" />
			<OutParam name="outParamMoney" type="Money" description="Money output parameter" />
			<OutParam name="outParamNChar" type="NChar(5)" description="NChar output parameter" />
			<OutParam name="outParamNVarChar" type="NVarChar(4000)" description="NVarChar output parameter" />
			<OutParam name="outParamReal" type="Real" nullable="true" description="Real output parameter" />
			<OutParam name="outParamUniqueIdentifier" type="UniqueIdentifier" nullable="false" description="UniqueIdentifier output parameter" />
			<OutParam name="outParamSmallDateTime" type="SmallDateTime" nullable="true" description="SmallDateTime output parameter" />
			<OutParam name="outParamSmallInt" type="SmallInt" description="SmallInt output parameter" />
			<OutParam name="outParamSmallMoney" type="SmallMoney" nullable="true" description="SmallMoney output parameter" />
			<OutParam name="outParamTimestamp" type="Timestamp" description="Timestamp output parameter" />
			<OutParam name="outParamTinyInt" type="TinyInt" nullable="false" description="TinyInt output parameter" />
			<OutParam name="outParamVarBinary" type="VarBinary(1024)" description="VarBinary output parameter" />
			<OutParam name="outParamVarChar" type="VarChar(max)" description="VarChar output parameter" />
			<OutParam name="outParamXml" type="Xml" description="Xml output parameter" />
			<OutParam name="outParamDate" type="Date" nullable="true" description="Date output parameter" />
			<OutParam name="outParamTime" type="Time" description="Time output parameter" />
			<OutParam name="outParamDateTime2" type="DateTime2" nullable="true" description="DateTime2 output parameter" />
			<OutParam name="outParamDateTimeOffset" type="DateTimeOffset" nullable="false" description="DateTimeOffset output parameter" />
			<!--ProcParams In-Output parameters-->
			<InOutParam name="inOutParamBigInt" type="BigInt" nullable="false" description="BigInt in-output parameter" />
			<InOutParam name="inOutParamBinary" type="Binary(512)" description="Binary in-output parameter" />
			<InOutParam name="inOutParamBit" type="Bit" nullable="true" description="Bit in-output parameter" />
			<InOutParam name="inOutParamChar" type="Char(10)" description="Char in-output parameter" />
			<InOutParam name="inOutParamDateTime" type="DateTime" description="DateTime in-output parameter" />
			<InOutParam name="inOutParamDecimal" type="Decimal" nullable="true" description="Decimal in-output parameter" />
			<InOutParam name="inOutParamFloat" type="Float" nullable="false" description="Float in-output parameter" />
			<InOutParam name="inOutParamInt" type="Int" nullable="true" description="Int in-output parameter" />
			<InOutParam name="inOutParamMoney" type="Money" description="Money in-output parameter" />
			<InOutParam name="inOutParamNChar" type="NChar(5)" description="NChar in-output parameter" />
			<InOutParam name="inOutParamNVarChar" type="NVarChar(4000)" description="NVarChar in-output parameter" />
			<InOutParam name="inOutParamReal" type="Real" nullable="true" description="Real in-output parameter" />
			<InOutParam name="inOutParamUniqueIdentifier" type="UniqueIdentifier" nullable="false" description="UniqueIdentifier in-output parameter" />
			<InOutParam name="inOutParamSmallDateTime" type="SmallDateTime" nullable="true" description="SmallDateTime in-output parameter" />
			<InOutParam name="inOutParamSmallInt" type="SmallInt" description="SmallInt in-output parameter" />
			<InOutParam name="inOutParamSmallMoney" type="SmallMoney" nullable="true" description="SmallMoney in-output parameter" />
			<InOutParam name="inOutParamTinyInt" type="TinyInt" nullable="false" description="TinyInt in-output parameter" />
			<InOutParam name="inOutParamVarBinary" type="VarBinary(1024)" description="VarBinary in-output parameter" />
			<InOutParam name="inOutParamVarChar" type="VarChar(max)" description="VarChar in-output parameter" />
			<InOutParam name="inOutParamXml" type="Xml" description="Xml in-output parameter" />
			<InOutParam name="inOutParamDate" type="Date" nullable="true" description="Date in-output parameter" />
			<InOutParam name="inOutParamTime" type="Time" description="Time in-output parameter" />
			<InOutParam name="inOutParamDateTime2" type="DateTime2" nullable="true" description="DateTime2 in-output parameter" />
			<InOutParam name="inOutParamDateTimeOffset" type="DateTimeOffset" nullable="false" description="DateTimeOffset in-output parameter" />
		</ProcParams>
		<CollectionResult classNameDef="ProcCollectionResult" description="Class ProcCollectionResult" />
	</DbApiMetadata>
*/
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
/*
DECLARE @tt dbo.IntBitValuePairArrayType 
INSERT INTO @tt(IntValue, BitValue) VALUES(5, 1)
INSERT INTO @tt(IntValue, BitValue) VALUES(4, 0)
INSERT INTO @tt(IntValue, BitValue) VALUES(3, 1)
INSERT INTO @tt(IntValue, BitValue) VALUES(2, 0)
INSERT INTO @tt(IntValue, BitValue) VALUES(1, 1)

DECLARE @outParamUpdatedBy INT, @outParamBigInt BigInt, @outParamBinary Binary(512), @outParamBit Bit, @outParamChar Char(10), 
	@outParamDateTime DateTime, @outParamDecimal Decimal, @outParamFloat Float, @outParamInt Int, @outParamMoney Money, 
	@outParamNChar nchar(5), @outParamNVarChar NVarChar(20), @outParamReal Real, @outParamUniqueIdentifier UniqueIdentifier, 
	@outParamSmallDateTime SmallDateTime, @outParamSmallInt SmallInt, @outParamSmallMoney SmallMoney, @outParamTimestamp Timestamp, 
	@outParamTinyInt TinyInt, @outParamVarBinary VarBinary(1024), @outParamVarChar VarChar(20), @outParamXml Xml, @outParamDate Date, 
	@outParamTime Time, @outParamDateTime2 DateTime2, @outParamDateTimeOffset DateTimeOffset, 
	@inOutParamBigInt BIGINT = 9876543210, 
	@inOutParamBinary Binary(512) = 35.42, 
	@inOutParamBit Bit = 1, 
	@inOutParamChar Char(10) = 'aBcDeFgHiJ', 
	@inOutParamDateTime DateTime = GETDATE(), 
	@inOutParamDecimal Decimal = 125, 
	@inOutParamFloat Float = 750, 
	@inOutParamInt Int = 5, 
	@inOutParamMoney Money = 4.99, 
	@inOutParamNChar nchar(5) = 'EDCBA', 
	@inOutParamNVarChar NVarChar(20) = 'SDGHSGHPDS FGHPFIDHG', 
	@inOutParamReal Real = 654, 
	@inOutParamUniqueIdentifier UniqueIdentifier = '8E4C1F23-7533-43D5-B260-0E4DA16BBB7C', 
	@inOutParamSmallDateTime SmallDateTime = '2017-05-01', 
	@inOutParamSmallInt SmallInt = 7, 
	@inOutParamSmallMoney SmallMoney = 9.5, 
	@inOutParamTinyInt TinyInt = 2, 
	@inOutParamVarBinary VarBinary(1024) = CAST(193.575 AS VARBINARY(1024)), 
	@inOutParamVarChar VarChar(20) = '@inOutParamVarChar VarChar(20)', 
	@inOutParamXml Xml = '<inOutParamXml>inOutParamXml</inOutParamXml>', 
	@inOutParamDate Date = GETDATE(), 
	@inOutParamTime Time = CAST(GETDATE() AS TIME), 
	@inOutParamDateTime2 DateTime2 = CAST(GETDATE() AS DATETIME2), 
	@inOutParamDateTimeOffset DateTimeOffset = CAST(GETDATE() AS DATETIMEOFFSET)
declare @indatetimeoffset datetimeoffset = CAST(GETDATE() AS datetimeoffset)

EXEC dbo.sp_ProcExistingCollectionResult 1234567895, 7, 1, 'A', '2017-05-31 10:11:24.970', 50, 1.005, 
	null, 5200, 4.99, N'nchar', N'1.INSERT INTO...', 
	N'ParamNVarChar nvarch', 0.075, 'c89b5acd-9501-7ae7-d9a7-aabb07da2017', '2017-04-30 10:11:24', 12, 5.79, 
	'3.create table ...', 7, 3.575, 'ParamVarChar varchar', '<ParamXml1>Param Xml 1</ParamXml1>', @tt, 
	'2017-05-31', '10:11:24', '2017-05-31 10:11:24.977', @indatetimeoffset, 
	5, '2017-05-31 10:11:24.975', '@paramUserName', @outParamUpdatedBy OUTPUT, '@paramTestManifest',
	@outParamBigInt output, @outParamBinary output, @outParamBit output, @outParamChar output, @outParamDateTime output, 
	@outParamDecimal output, @outParamFloat output, @outParamInt output, @outParamMoney output, @outParamNChar output, 
	@outParamNVarChar output, @outParamReal output, @outParamUniqueIdentifier output, @outParamSmallDateTime output, 
	@outParamSmallInt output, @outParamSmallMoney output, @outParamTimestamp output, @outParamTinyInt output, 
	@outParamVarBinary output, @outParamVarChar output, @outParamXml output, @outParamDate output, @outParamTime output, 
	@outParamDateTime2 output, @outParamDateTimeOffset output, 
	@inOutParamBigInt output, @inOutParamBinary output, @inOutParamBit output, @inOutParamChar output, 
	@inOutParamDateTime output, @inOutParamDecimal output, @inOutParamFloat output, @inOutParamInt output, 
	@inOutParamMoney output, @inOutParamNChar output, @inOutParamNVarChar output, @inOutParamReal output, 
	@inOutParamUniqueIdentifier output, @inOutParamSmallDateTime output, @inOutParamSmallInt output, 
	@inOutParamSmallMoney output, @inOutParamTinyInt output, @inOutParamVarBinary output, 
	@inOutParamVarChar output, @inOutParamXml output, @inOutParamDate output, @inOutParamTime output, 
	@inOutParamDateTime2 output, @inOutParamDateTimeOffset output

SELECT @outParamUpdatedBy '@outParamUpdatedBy', @outParamBigInt '@outParamBigInt', @outParamBinary '@outParamBinary', 
	@outParamBit '@outParamBit', @outParamChar '@outParamChar', @outParamDateTime '@outParamDateTime', 
	@outParamDecimal '@outParamDecimal', @outParamFloat '@outParamFloat', @outParamInt '@outParamInt', 
	@outParamMoney '@outParamMoney', @outParamNChar '@outParamNChar', @outParamNVarChar '@outParamNVarChar', 
	@outParamReal '@outParamReal', @outParamUniqueIdentifier '@outParamUniqueIdentifier', 
	@outParamSmallDateTime '@outParamSmallDateTime', @outParamSmallInt '@outParamSmallInt', 
	@outParamSmallMoney '@outParamSmallMoney', @outParamTimestamp '@outParamTimestamp', @outParamTinyInt '@outParamTinyInt', 
	@outParamVarBinary '@outParamVarBinary', @outParamVarChar '@outParamVarChar', @outParamXml '@outParamXml', 
	@outParamDate '@outParamDate', @outParamTime '@outParamTime', @outParamDateTime2 '@outParamDateTime2', 
	@outParamDateTimeOffset '@outParamDateTimeOffset', @inOutParamBigInt '@inOutParamBigInt', 
	@inOutParamBinary '@inOutParamBinary', @inOutParamBit '@inOutParamBit', @inOutParamChar '@inOutParamChar', 
	@inOutParamDateTime '@inOutParamDateTime', @inOutParamDecimal '@inOutParamDecimal', 
	@inOutParamFloat '@inOutParamFloat', @inOutParamInt '@inOutParamInt', @inOutParamMoney '@inOutParamMoney', 
	@inOutParamNChar '@inOutParamNChar', @inOutParamNVarChar '@inOutParamNVarChar', @inOutParamReal '@inOutParamReal', 
	@inOutParamUniqueIdentifier '@inOutParamUniqueIdentifier', @inOutParamSmallDateTime '@inOutParamSmallDateTime', 
	@inOutParamSmallInt '@inOutParamSmallInt', @inOutParamSmallMoney '@inOutParamSmallMoney', @inOutParamTinyInt '@inOutParamTinyInt', 
	@inOutParamVarBinary '@inOutParamVarBinary', @inOutParamVarChar '@inOutParamVarChar', @inOutParamXml '@inOutParamXml', 
	@inOutParamDate '@inOutParamDate', @inOutParamTime '@inOutParamTime', @inOutParamDateTime2 '@inOutParamDateTime2', 
	@inOutParamDateTimeOffset '@inOutParamDateTimeOffset'
*/