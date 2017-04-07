# SQL to ADO.NET API (Automated ADO.NET)

Introduction
============

It is common when developer creates program component as well as stored 
procedure to act as component proxy on back end. Then developer creates 
program method to call the stored procedure from the program component. 
Some of developers still prefer old reliable ADO.NET to do that.

One time ADO.NET was very popular, and it still is to certain extent. Not 
all developers embraced ORM frameworks. Quite a number of .NET folks still 
push and pull data to and from database using the same old reliable 
ADO.NET technology. 

I reveal no secret when I say that many of such data access methods are 
alike in a way they define **SqlCommand**, open **SqlConnection**, call 
one of ADO.NET **Execute** methods, etc. It is repetitive and routine 
coding of well defined and templated code. In fact, it is so repetitive 
that many developers prefer copy/paste/adjust similar code to save time. 
The other side of the copy/paste/adjust coin is notorious for dummy 
"copy/paste" errors, and developer sometimes looses more than gains in 
terms of time saving. 

The way to make developer life better is to automate coding of ADO.NET 
part. **Repetitive and templated code is good candidate for automation!**

Automation of this sort implies hacking into a project build process to 
generate the project content before compiling the project. This sequence 
of actions is not quite MSBuild friendly and introduces configuration 
challenges. Other known challenges include unreliable project commitment 
to early binding, and inaccurate identification of source and point of 
failure while parsing/generating code outside of MSBuild. 

DB API addresses those issues and overcomes most of the challenges. It 
parses SQL script, generates data access method source code, and stores 
the code in .cs or .vb file, while the file is set to compile. DB API 
also guarantees proper sequence of build actions as well as it provides 
accurate error messaging at build time. It is also highly configurable. 

Fundamentals
============

### Metadata 

Once upon a time someone got an idea to describe stored procedure input and 
output in XML format and put this XML in the same stored procedure. This XML is 
universally called metadata. Here is an example of metadata, which DB API 
understands: 

```
/*
<DbApiMetadata method="GetListOfUsers">
	<ProcParams>
		<InParam name="UsernameLike" type="varchar(50)" />
		<OutParam name="Total" type="int" description="Total count of users" />
	</ProcParams>
	<ClassResult className="UserBase" description="Class represents basic User info">
		<ResultParams>
			<ResultParam name="UserId" typeDef="dbo.User.UserID" />
			<ResultParam name="Username" type="varchar(50)" />
			<ResultParam name="FirstName" type="varchar(50)" />
			<ResultParam name="LastName" type="varchar(50)" />
			<ResultParam name="DateOfBirth" type="datetime" />
		</ResultParams>
	</ClassResult>
</DbApiMetadata>
*/
create procedure dbo.sp_GetListOfUsers
	@UserNameLike VARCHAR(50),
	@Total int output
as
BEGIN
…
```

As you can see in example above, SQL code and metadata both are combined into 
one SQL file. It makes the script DB API-ready. 

### Executable 

Let’s assume that an application we call Runner finds DB API-ready SQL script, 
parses it and generates data access method code. 

### Build 

Then we hook up Runner to .NET Class Library project, which we configure to 
execute Runner before the project compiles. 

The rest is straightforward. MSBuild kicks-off project build, which kicks-off 
Runner, which generates code into .cs or .vb file set for compilation in the 
project. When Runner exits, MSBuild starts building the project with just 
acquired data access methods.

Definitions
===========

1.  DB API-ready script – SQL script contains both metadata and SQL stored 
    procedure code.

2.  DA Method – data access method is generated from metadata. Generated DA 
    Method calls specific stored procedure mapped to it. Only 1 DA Method is 
    generated for each stored procedure metadata. 

3.  Runner – SqlToAdoNetApi.Runner – application reads SQL tables and stored 
    procedures scripts. Then it generates source code of DA Methods. 

4.  DA Class – .NET POCO class is generated from metadata. DA Method returns 
    DA Class when stored procedure returns single or multiple rows of single 
    recordset. 

5.  DAL Project – .NET Class Library project is configured to execute Runner 
    before build. The project also hosts .cs or .vb file, where Runner writes 
    generated content into. 

6.  DAL DLL – DLL is compiled from DAL Project after Runner completes 
    generating content of DAL project. 

7.  DB API Configuration File – XML file describes databases and other 
    resources as well as defines SqlToAdoNetApi.Runner execution behavior.
 
8.  Generated XML file – XML file represents assembly of all complex objects, 
    which define process of generating DA Methods and DA Classes.

9.  Generated Code File – C\# or VB.NET source code file, which contains all
    generated DA Methods and DA Classes of a Database in DAL Project. There is
    only 1 Generated Code File per database in DAL Project.

DAL Project Structure
=====================

Here is an example of DAL Project and test database configured for use of DB API 

![DAL Project](/Images/graph1.png)

As you can see, DAL Project has 4 required sections:

1.  Configuration File – DB API configuration file like DbApiDataSource.xml in the 
    example above. The file can be located anywhere; however, it is recommended 
    to keep it in structure of the project. When SqlToAdoNetApi.Runner.exe runs, 
    DbApi.DatabaseSettingsPath key in SqlToAdoNetApi.Runner.exe.config file 
    tells executable where to find Configuration File.

2.  Database scripts – collection of directories where Runner looks for tables 
    and DB API-ready scripts. Actual files can be located anywhere with 
    exception of shared folder (presently). DB folders are shown as part of the 
    DAL Project for convenience only.

3.  Exec section – location of SqlToAdoNetApi.Runner.exe executable file in 
    project. 

4.  Generated section – the project directory where C# or VB.NET generated file 
    of DA Methods is located. Location is configurable.

Let’s put all known to this point together
==========================================

As you can see on example of SqlToAdoNetApi.Dal.ApiTestDB DAL Project above 
there is no content there yet. Runner generates content of the project just 
before the project starts compiling. You will see content when DAL Project 
compiles successfully first time.

When Runner executes, it looks into SqlToAdoNetApi.Runner.exe.config file 
for **DbApi.DatabaseSettingsPath** key: 
```
<add key="DbApi.DatabaseSettingsPath" value="..\\Configuration\\DbApiDataSource.xml" />
```

The key tells Runner where to find DB API Configuration File. Then the DB API 
Configuration File tells Runner where to find DB API-ready scripts.

Then Runner parses DB API-ready scripts and composes Object Graph. Later on, 
Runner uses Object Graph as template to generate DA Methods and DA Classes.

Now let’s make sure that Runner executes before DAL Project starts compilation. 
Let’s create Target section in .csproj or .vbproj file: 

```
<Target Name="BeforeBuild">
	<Exec Command="copy \$(ProjectDir)Generated\\CSharpCode\\DoNotDelete.txt $(ProjectDir)\\Generated\\CSharpCode\\ApiTestDBGenerated.cs /y"/>
	<Exec Command="\$(ProjectDir)Exec\\SqlToAdoNetApi.Runner.exe" ContinueOnError="False">
		<Output TaskParameter="ExitCode" PropertyName="ErrorCode"/>
	</Exec\>
	<Message Importance="high" Text="\$(ErrorCode)"/>
</Target>
```
In example above, MSBuild clears content of Generated Code File 
**ApiTestDbGenerated.cs** and then Runner generates new content into this file. 

**IMPORTANT**: name of Generated Code File must match name of database key is 
followed by suffix **Generated**.cs, so Runner would know which file to write 
generated content into. 

For example, if we have Database tag configured like this in DB API Configuration 
File: 
```
<Database key="**ApiTestDB**" name="API Test DB">
  …
</Database>
```
name of the Generated Code File would be **ApiTestDbGenerated.cs**, because 
database key **ApiTestDb** is followed by suffix **Generated**.cs. 

DB API Configuration File
=========================

XML formatted API Configuration File defines all settings of DAL Project.

### \<DataSource ..\>

Root element of API Configuration File.

| Attribute     | Type                          | Presence | Description                                                                                             |
|---------------|-------------------------------|----------|---------------------------------------------------------------------------------------------------------|
| **language**  | string                        | required | programming language for code generation. “CSharp” and “VB” are the options                             |



| Child Element | Type                          | Presence | Description                                                                                             |
|---------------|-------------------------------|----------|---------------------------------------------------------------------------------------------------------|
| **Databases** | collection of complex objects | required | describes databases                                                                                     |
| **Defaults**  | complex object                | required | defines set of default variables used by Runner                                                         |
| **XmlOutput** | complex object                | required | tells Runner to generate serialize Object Graph into XML file, as well as defines location of this file |
| **LogErrors** | collection of complex objects | Required | collection of error loggers. Each logger has its own output                                             |

#### Example 
```
<DataSource language="CSharp">
	<Databases>
		<Database …>
			…
		</Database>
	</Databases>
	<Defaults>
		…
	</Defaults>
	<XmlOutput generate="true" path="../Generated/Xml" />
	<LogErrors>
		…
	</LogErrors>
</DataSource>
```

### \<Database ..\>

Database defines collection of paths as well as other parameters. Each path
represent directory, where Runner looks for tables or stored procedures, which
participate in creation of Generated Code Files.

| Attribute               | Type                          | Presence | Description                                                                        |
|-------------------------|-------------------------------|----------|------------------------------------------------------------------------------------|
| **key**                 | string                        | required | Name of DB. Spaces are not allowed. Name must be unique in Database Collection     |
| **name**                | string                        | required | Database description                                                               |



| Child Element           | Type                          | Presence | Description                                                                        |
|-------------------------|-------------------------------|----------|------------------------------------------------------------------------------------|
| **ConnectionString**    | complex object                | required | DB connection string object                                                        |
| **Namespace**           | string                        | optional | defines namespace in generated C\#/VB.NET file                                     |
| **CSharpOutput**        | complex object                | required | tells Runner to generate C\#/VB.NET file, as well as defines location of this file |
| **TableLocations**      | collection of complex objects | required | locations of SQL tables files                                                      |
| **StoredProcLocations** | collection of complex objects | required | of SQL stored procedures files                                                     |

### Example 
```
<Database key="ApiTestDB" name="API Test DB">
	<ConnectionString connectionString="DbApi.ApiTestDBConnectionString" providerName="System.Data.SqlClient" />
	<Namespace>SqlToAdoNetApi.Dal.ApiTestDB</Namespace>
	<CSharpOutput generate="true" path="../Generated/CSharpCode" />
	<TableLocations>
		<TableLocation path="../Database/sen/Tables" />
		<TableLocation path="../Database/dbo/Tables" />
	</TableLocations>
	<StoredProcLocations>
		<StorProcLocation path="../Database/dbo/StoredProcedures" />
	</StoredProcLocations>
</Database>
```

### \<ConnectionString ..\> 

Identifies configuration key, which defines DB connection string in app.config
or web.config of host application

Runner looks for tables or stored procedures, which participate in creation of
Generated Code Files.

| Attribute            | Type   | Presence | Description                                   |
|----------------------|--------|----------|-----------------------------------------------|
| **connectionString** | string | required | configuration key in app.config or web.config |
| **providerName**     | string | required | connection DB provider                        |

### \<CSharpOutput ..\> 

Identifies if C\#/VB.NET is generated as well as location of the file.

| Attribute    | Type    | Presence | Description                                                                 |
|--------------|---------|----------|-----------------------------------------------------------------------------|
| **generate** | boolean | required | flag tells generator whether to generate C\#/VB.NET file or not             |
| **path**     | string  | required | local directory path where generated code is stored in C\#/VB.NET file      |

### \<TableLocation ..\> 

Location of SQL tables files

| Attribute | Type   | Presence | Description                                              |
|-----------|--------|----------|----------------------------------------------------------|
| **path**  | string | required | local directory path where stored tables are loaded from |

### \<StorProcLocation ..\> 

Location of SQL stored procedures files

| Attribute | Type   | Presence | Description                                                        |
|-----------|--------|----------|--------------------------------------------------------------------|
| **path**  | string | required | local directory path where stored procedures files are loaded from |

### \<Defaults\>

Assembly of various parameters, which govern code generation process.



| Child Element              | Type                          | Presence | Description                                                                    |
|----------------------------|-------------------------------|----------|--------------------------------------------------------------------------------|
| **KeepRelativePath**       | boolean                       | optional | flag tells generator whether to convert relative paths to absolute ones or not |
| **NormalizeParameterName** | boolean                       | optional | tells generator whether to parameter should have camelLike style               |
| **NormalizePropertyName**  | boolean                       | optional | tells generator whether to class property should have PascalLike style         |
| **CleanupKeywords**        | collection of complex objects | optional | collection of cleanup keywords                                                 |

### Example 
```
<Defaults>
	<KeepRelativePath>false</KeepRelativePath>
	<NormalizeParameterName>true</NormalizeParameterName>
	<NormalizePropertyName>true</NormalizePropertyName>
	<CleanupKeywords>
		<CleanupKeyword caseSensitive="false"\>Identity\\(\\s\*[0-9]+,\\s\*[0-9]+\\s\*\\)</CleanupKeyword>
	</CleanupKeywords>
</Defaults>
```

### \<CleanupKeyword ..\>

Collection of cleanup keywords used to cleanup SQL scripts when hunting for
table columns descriptors.

| Attribute            | Type     | Presence                                                                                   | Description                                                     |
|----------------------|----------|--------------------------------------------------------------------------------------------|-----------------------------------------------------------------|
| **caseSensitive**    | boolean  | required                                                                                   | Flag indicates if Regex expression is treated as case sensitive |



| Element content type | Presence | Description                                                                                |
|----------------------|----------|--------------------------------------------------------------------------------------------|
| string               | required | Regex expression, which is used in table script cleanup, when extracting column descriptor | 

### \<XmlOutput ..\> 

Identifies if XML is generated as well as location of the file.

#### Attributes

| Attribute    | Type    | Presence | Description                                              |
|--------------|---------|----------|----------------------------------------------------------|
| **generate** | boolean | required | flag tells generator whether to generate XML file or not |
| **path**     | string  | required | local directory path where generated XML is stored       |

### \<LogType ..\>

Defines how errors are shown or logged.

| Attribute   | Type   | Presence                                        | Description                                                                                                                                                                                                                                           |
|-------------|--------|-------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **output**  | enum   | required                                        | defines type of error output. **VsOutput** – error is shown in Output Window of Visual Studio. **File** – error is logged in file located at path specified by attribute path. **PopupWindow** – error is shown in popup window (desktop application) |
| **path**    | string | conditionally required for **File** type output | local directory path where logs are stored                                                                                                                                                                                                            |
| **disable** | string | optional                                        | flag specifies if this log type should be suppressed                                                                                                                                                                                                  |

SQL Metadata 
=============

If developer wants to make use of DB API in DAL Project, beside setting up and
configuring the project, he or she also needs to decorate stored procedures with
DbApiMetadata metadata XML:
```
<DbApiMetadata method="GetListOfUsers">
	<ProcParams>
		<InParam name="UsernameLike" type="varchar(50)" />
		<OutParam name="Total" type="int" description="Total count of users" />
	</ProcParams>
	<ClassResult className="UserBase" description="Class represents basic User info">
		<ResultParams>
			<ResultParam name="UserId" typeDef="dbo.User.UserID" />
			<ResultParam name="Username" type="varchar(50)" />
			<ResultParam name="FirstName" type="varchar(50)" />
			<ResultParam name="LastName" type="varchar(50)" />
			<ResultParam name="DateOfBirth" type="datetime" />
		</ResultParams>
	</ClassResult>
</DbApiMetadata>
```

**Important**: Runner ignores stored procedure if it does not have DbApiMetadata metadata tag. 

### \<DbApiMetadata ..\> 

Root element of metadata object, which defines input and output parameters of
stored procedure.

| Attribute       | Type                                                                                       | Presence | Description                                                                                                                                                                                                                                                                                                                                                                                |
|-----------------|--------------------------------------------------------------------------------------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **method**      | string                                                                                     | optional | specifies DA Method name. Runner generates C\# method **GetListOfUser** In the example above. If not provided, C\# method takes name of stored procedure                                                                                                                                                                                                                                   |
| **description** | string                                                                                     | optional | description is added as comments of the DA Method                                                                                                                                                                                                                                                                                                                                          |



| Child Element   | Type                                                                                       | Presence | Description                                                                                                                                                                                                                                                                                                                                                                                |
|-----------------|--------------------------------------------------------------------------------------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **ProcParams**  | collection of complex objects                                                              | required | collection of input parameters. C\# generator supports 3 types of parameters: **InParam**, **OutParam** and **InOutParam**, which are transformed into **regular** parameters as well as parameters with **out** and **ref** modifiers in DA Method respectively. VB.NET generator takes only regular and **ByRef** parameter types, because **OUT** modifier is not supported by language |
| **ProcResult**  | one of **ClassResult**, **CollectionResult**, **ScalarResult**, **DataSetResult**, **NoResult** complex object | required | defines return type of DA Method. It may also define class for **ClassResult** and **CollectionResult** types of **ProcResult**.                                                                                                                                                                                                                                       |

Where:

-  **ClassResult** – return object of class type
-  **CollectionResult** – return collection of class type objects
-  **ScalarResult** – return any value type; byte, bool, int …
-  **DataSetResult** – return DataSet, which may have 1 or more DataTables
-  **NoResult** – return is not required

### \<InParam ..\>, \<OutParam ..\> and \<InOutParam ..\> 

XML element of metadata object, which defines type and other properties of input
parameter.

| Attribute       | Type   | Presence    | Description                                                                                                                                                                                                                                           |
|-----------------|--------|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **name**        | string | required    | specifies parameter name                                                                                                                                                                                                                              |
| **type**        | string | conditional | specifies SQL parameter type. Presently SqlDbType.Variant and SqlDbType.Udt are not supported. The rest of SqlDbType types are supported by DB API. If **type** is not specified, **typeDef** attribute must be                                       |
| **typeDef**     | string | required    | specifies type of parameter, where the type itself is defined by schema.Table.Column.type. It is preferred way to specify type of input parameter, because when type of column in table changes, DB API changes type of input parameter automatically |
| **nullable**    | string | required    | tells Runner to generate nullable value type of DA Method input parameter                                                                                                                                                                             |
| **description** | string | optional    | description is added as comments of the DA Method’s input parameter                                                                                                                                                                                   |

### \<ClassResult ..\>, \<CollectionResult ..\>, \<ScalarResult ..\>, \<DataSetResult ..\>, \<NoResult ..\>

element defines return type of DA Method.

### \<ClassResult ..\>

| Attribute        | Type                          | Presence    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|------------------|-------------------------------|-------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **className**    | string                        | conditional | specifies name of class, which defines type of returned POCO object. If it is not specified, **classNameDef** attribute must be defined to give name of class, which is declared elsewhere; in other metadata of another stored procedure. It is done to support DA Methods returning the same type of objects. For example, GetUser and GetUsers procedures return **UserAccount** class and ICollection\<**UserAccount**\> collection respectively, while both returning objects of **UserAccount** type |
| **classNameDef** | string                        | conditional | specifies name of class scripted elsewhere. See className for explanation                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **ResultParams** | collection of complex objects | required    | collection of properties of POCO class                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| **description**  | string                        | optional    | description is added as comments of the DA Method’s return                                                                                                                                                                                                                                                                                                                                                                                                                                                 |

### \<CollectionResult ..\>

Same as **ClassResult**, only DA Method returns ICollection of ClassResult
objects.

### \<ScalarResult ..\>

Return any value type; byte, bool, int … from DB perspective, it is single row,
single column of single recordset.

| Attribute       | Type   | Presence | Description                                                |
|-----------------|--------|----------|------------------------------------------------------------|
| **description** | string | optional | description is added as comments of the DA Method’s return |

### \<DataSetResult ..\>

Return DataSet, which may have 1 or more DataTables.

| Attribute       | Type   | Presence | Description                                                |
|-----------------|--------|----------|------------------------------------------------------------|
| **description** | string | optional | description is added as comments of the DA Method’s return |

### \<NoResult ..\>

Return is not required. Strictly speaking, this result type returns integer,
which have number of affected rows or last DML statement of the stored procedure
called.

| Attribute       | Type   | Presence | Description                                                |
|-----------------|--------|----------|------------------------------------------------------------|
| **description** | string | optional | description is added as comments of the DA Method’s return |

### \<ResultParam ..\>

Property of return type POCO class, when return type is specified as ClassResult
and CollectionResult.

| Attribute       | Type   | Presence    | Description                                                                                                                                                                                                                                           |
|-----------------|--------|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **name**        | string | required    | specifies parameter name                                                                                                                                                                                                                              |
| **type**        | string | conditional | specifies SQL parameter type. Presently SqlDbType.Variant and SqlDbType.Udt are not supported. The rest of SqlDbType types are supported by DB API. If **type** is not specified, **typeDef** attribute must be                                       |
| **typeDef**     | string | required    | specifies type of parameter, where the type itself is defined by schema.Table.Column.type. It is preferred way to specify type of input parameter, because when type of column in table changes, DB API changes type of input parameter automatically |
| **nullable**    | string | required    | tells Runner to generate nullable value type of DA Method input parameter                                                                                                                                                                             |
| **description** | string | optional    | description is added as comments of the DA Method’s input parameter                                                                                                                                                                                   |

## Why Runner parses SQL tables?

It is all well and good when stored procedure is brand new and shiny, and all
input and output parameters match types of relative columns of tables, which
they suppose to match. A day comes, when another developer changes type of one
of the column. Now type of respective input (or output) parameter does not match
the table column type. This problem is difficult to identify, and sometimes code
goes all the way to production before it breaks.

Let’s consider case of 2 input parameters:

Let’s assume type of **UserRank** parameter matches type of
**dbo.User.UserRank** column, which is INT at the moment. So, we confidently
define type of the parameter as INT.

\<ResultParam name="UserRank" type="int" nullable="true" /\>

Let’s also assume **dbo.User.UserID** column type is INT. However, this time we
tell parameter **UserId** to use type of **dbo.User.UserID** column, whatever it
is at the moment, instead of hardcoding it to INT.

\<ResultParam name="UserId" typeDef="dbo.User.UserID" nullable="true" /\>

Lets assume DB API generates method:

public ICollection\<AppUser\> GetUsers(…, int? userId, int? userRank, …) { … }

Now, let's alter type of **dbo.User.UserRank** and **dbo.User.UserID** columns to
BIGINT. DB API continues to generate input parameter **userRank** type as
**int?**, which is wrong; however, type of parameter **userId** now is **long?**, 
which is correct.

public ICollection\<AppUser\> GetUsers(…, long? userId, int? userRank, …) { … }

#### Conclusion

Adopting usage of **typeDef** instead of **type** brings certain advantage. Type
of parameter of DA Method matches type of mapped table column. When the column
type changes, DB API adjusts the DA Method parameter type to match new type of
the column automatically.

Troubleshooting
===============

World of S/W development is not perfect and avoiding mistakes is a difficult task. 
DB API understands it and helps troubleshooting metadata along with tuning 
configuration files. 

#### Tip 1

Configure LogType output VsOutput or/and File for automatic build, and all 3 
loggers when debugging.
```
<LogErrors>
	<LogType output="VsOutput" />
	<LogType output="File" path="../../../Logs" nameTemplate="Log" />
	<LogType output="PopupWindow" disable="false" />
</LogErrors>
```

If error has made to build, File option likely is the most useful.

![File log](/Images/log.png)

If developer is actively working with code, Popup Window probably is the best 
way to detect and understand the error.

![Popup Window log](/Images/logr.png)

#### Tip 2

Turn on XML output while developing. You always can analyze the XML file to find 
out why e.g. property is not generated. Turn off XML output for automated 
production build.

#### Tip 3

If in some reason it is not possible to configure Runner in \<Target
Name="BeforeBuild"\>, alternative would be to make use of pre-build events of 
the project.

Example of SQL to ADO.NET API
=============================

Get source code.

![Source code](/Images/graph2.png)

Prepare test databases
----------------------

Unit test project requires test databases:

-   **ApiEvaluateDB**

-   **ApiTestDB**

You can restore test databases from backups: 

-   **\$\\DbApi\\DB\\ApiEvaluateDB.bak**

-   **\$\\DbApi\\DB\\ApiTestDB.bak**

The backups were created in SQL Server 2014. 

![DB backup](/Images/graph3.png)

If you don’t want or cannot restore backups for any reason, either create the 
databases manually, or run script:

-   **\$\\DbApi\\DB\\CreateDBs.sql** (change “C:\\...\\” path to actual location
    of the test databases in the script)

Then run script:

-   **\$\\DbApi\\DB\\DDLs.sql**

to create all required SQL objects required for unit testing.

Test solution
-------------

Open **SqlToAdoNetApi** solution in Visual Studio 2015+.

Open **App.config** file and configure connection strings to point to your test
databases:
```
<add key="DbApi.ApiTestDBConnectionString" value="Data Source=YOUR-DB-INSTANCE;Initial Catalog=ApiTestDB;Integrated Security=True" />
<add key="DbApi.ApiEvaluatetDBConnectionString" value="Data Source=YOUR-DB-INSTANCE;Initial Catalog=ApiEvaluateDB;Integrated Security=True" />
```

Build the solution.

Run unit tests in **SqlToAdoNetApi.Dal.Test**. It should produce result similar
to one below:

![Unit Test result](/Images/unittest.png)

License
=======

This project, along with any associated source code and files, is licensed under
Apache License 2.0.
