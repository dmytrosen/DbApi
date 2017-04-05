USE ApiEvaluateDB

/* HISTORY   
	03/25/2017 - dsen 
*/ 	

if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcDataSet') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcDataSet
end
go
/* DESCRIPTION  
	SYSTEM: Test Corporate
	RETURNS: 
*/
/* DBAPI metadata
	<DbApiMetadata method="GetProcDataSet" description="Get ProcDataSet">
		<DataSetResult description="ProcDataSet" />
	</DbApiMetadata>
*/
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
