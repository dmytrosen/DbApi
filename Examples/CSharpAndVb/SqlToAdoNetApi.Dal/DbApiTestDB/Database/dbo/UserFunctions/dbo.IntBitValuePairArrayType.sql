USE [ApiTestDB]

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'IntBitValuePairArrayType')
BEGIN
	DROP TYPE dbo.IntBitValuePairArrayType
END

/* HISTORY   
	12/15/2016 - dsen 
*/ 	
/* DESCRIPTION  
	...
*/
create type dbo.IntBitValuePairArrayType as table 
(
    IntValue int NOT NULL,
    BitValue bit NOT NULL,
    PRIMARY KEY CLUSTERED(IntValue ASC) WITH (IGNORE_DUP_KEY = OFF)
)
go