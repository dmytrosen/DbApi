USE ApiTestDB

/* HISTORY   
	03/25/2017 - dsen 
*/ 	

if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcScalar') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcScalar
end
go
/* DESCRIPTION  
	SYSTEM: Test Corporate
	RETURNS: 
*/
/* DBAPI metadata
	<DbApiMetadata method="GetProcScalar" description="Get ProcScalar">
		<ProcParams>
			<!--ProcParams Input parameters-->
			<InParam name="paramBigInt" type="BigInt" nullable="true" />
			<OutParam name="eckry" type="varchar(MAX)" nullable="true" />
		</ProcParams>
		<ScalarResult type="bigint" nullable="true" description="Class ProcScalar" />
	</DbApiMetadata>
*/
create procedure dbo.sp_ProcScalar
	@paramBigInt BIGINT null, 
	@eckry VARCHAR(50) OUTPUT
as
BEGIN
	set @eckry = @paramBigInt + 500
	select @paramBigInt + 10000 
end
go
/*
declare @e VARCHAR(MAX)
declare @r bigint
exec dbo.sp_ProcScalar 125, @e output
select @e
*/