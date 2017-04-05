USE ApiEvaluateDB

/* HISTORY   
	03/25/2017 - dsen 
*/ 	

if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcNoResult') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcNoResult
end
go
/* DESCRIPTION  
	SYSTEM: Test Corporate
	RETURNS: 
*/
/* DBAPI metadata
	<DbApiMetadata method="GetProcNoResult" description="Get ProcNoResult">
		<ProcParams>
			<InParam name="paramVarChar" type="VarChar(max)" description="VarChar parameter" />
		</ProcParams>
		<NoResult description="Class ProcNoResult" />-->
	</DbApiMetadata>
*/
create procedure dbo.sp_ProcNoResult
	@paramVarChar varchar(max)
as
BEGIN
	PRINT '@paramVarChar: ' + @paramVarChar
end
go
/*
exec dbo.sp_ProcNoResult 'TEST'
*/