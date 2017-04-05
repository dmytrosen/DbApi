








USE [ApiTestDB]









IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ApiTestEighthTest')
BEGIN
	DROP table dbo.ApiTestEighthTest
end
go

CREATE TABLE [ApiTestEighthTest] ([EighthTestId] INT IDENTITY(1,1),Name VARCHAR(max) not null,Submited DATETIME,	Started DATETIME,	Pinged DATETIME, Terminated DATETIME, TerminationStatus VARCHAR(8),Message VARCHAR(512),TerminationInfo NTEXT)
GO