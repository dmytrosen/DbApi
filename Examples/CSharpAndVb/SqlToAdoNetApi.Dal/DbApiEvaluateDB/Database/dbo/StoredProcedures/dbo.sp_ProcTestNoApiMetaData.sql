USE ApiEvaluateDB

/* HISTORY   
	03/25/2017 - dsen 
*/ 	

if exists (select 1 from sysobjects where id = object_id(N'dbo.sp_ProcTestNoApiMetaData') and objectproperty(id, N'IsProcedure') = 1)
begin
	drop procedure dbo.sp_ProcTestNoApiMetaData
end
go
/* DESCRIPTION  
	SYSTEM: Test 
	RETURNS: 
*/
create procedure dbo.sp_ProcTestNoApiMetaData
as
begin
	select 'A' 'FirstColumn', 'b' 'SecondColumn'
end
go
