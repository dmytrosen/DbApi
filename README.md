# SQL to ADO.NET API (Automated ADO.NET)

Introduction
============

One time ADO.NET was very popular among .NET developers, and it still is. 
Not all developers have embraced ORM frameworks. Quite a number of .NET folks 
still push and pull data to and from database using the same old reliable 
ADO.NET. 

This project is about a way to make life better for .NET developer; the way 
to automate coding ADO.NET part of code.

Background
----------

It is common for developer to create program component as well as stored procedure 
to act as component proxy on backend. It is also common for developer to create 
program method to call the stored procedure from the program component. Some of 
developers prefer old reliable ADO.NET to do that.

I reveal no secret when I say that many of such data access methods are alike in a 
way they define SqlCommand, open SqlConnection, call one of ADO.NET Execute 
methods, etc. It is repetitive and routine coding of well defined and well 
templated code. It is so repetitive that many developers prefer copy/paste/adjust 
similar code to save time. Of course, the other side of the copy/paste/adjust coin 
is notorious for dummy "copy/paste" errors.

Repetitive and well templated code is good candidate for automation.

This kind of automation implies hacking into project build process to generate 
project content before project build. It creates some challenges, because this 
sequence of actions is not quite MSBuild friendly. Other challenges, like 
committing to early binding of such project, or ability to identify source of 
failure, may be difficult to overcome. 

DB API solves most of those problems. It parses SQL script, generates source code 
of data access method, and stores the code in .cs or .vb file, while the file is 
set to compile when project is compiled. DB API also guarantees proper sequence 
of build actions, as well as it provides accurate error messaging when it runs. 

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

Let’s assume that an application we call Runner finds DB API-ready SQL script, 
parses it and generates data access method code. 

Then we hook up Runner to .NET Class Library project, which we configure to 
execute Runner before its build. 

The rest is straightforward. MSBuild kicks-off project build, which kicks-off 
Runner, which generates code into .cs or .vb files of the project. Once Runner 
completes generating code, MSBuild starts building the project with just 
acquired data access methods.

Definitions
===========

1.  DA Method – data access method is generated from metadata. Generated code 
    calls specific stored procedure. Only 1 DA Method is generated for each 
    stored procedure metadata. 

2.  Runner – SqlToAdoNetApi.Runner – application reads SQL tables and stored 
    procedures scripts, and then generates source code of DA Methods. 

3.  DA Class – .NET POCO class is generated from metadata. DA Method returns 
    DA Class when stored procedure returns single or multiple rows of single 
    recordset. 

4.  DAL Project – .NET Class Library project is configured to host generated 
   .NET source code files. 

5.  DAL DLL – DLL compiled from DAL Project after Runner completed to generate 
    content of DAL project. 

6.  API Configuration File – XML file, which describes databases and other 
    resources, as well as defines SqlToAdoNetApi.Runner execution behavior.
 
7.  Generated XML file – XML file represents assembly of all complex objects, 
    which define process of generating DA Methods and DA Classes.

8.  Generated Code File – C\# or VB.NET source code file, which contains all
    generated DA Methods and DA Classes of a Database in DAL Project. There is
    only 1 Generated Code File per database in DAL Project.

DAL Project Structure
=====================

Here is an example of DAL Project and test database configured for use of DB API 

![DAL Project](/Images/graph1.png)

As you can see, DAL Project has 4 sections:

1.  Configuration File – API configuration file like DbApiDataSource.xml in the 
    example above. The file can be located anywhere; however, it is recommended 
    to keep it in structure of the project. When SqlToAdoNetApi.Runner.exe is 
    invoked, DbApi.DatabaseSettingsPath key in SqlToAdoNetApi.Runner.exe.config 
    file tells executable where to find Configuration File.

2.  Database scripts – collection of directories where Runner looks for tables 
    and stored procedures SQL scripts. Actual SQL script files can be located 
    anywhere with exception of shared folder (presently). DB folders are shown 
    as part of the DAL Project for convenience only. 

3.  Exec section – the project directory, where SqlToAdoNetApi.Runner.exe 
    executable file is located. 

4.  Generated – the project directory and files, where SqlToAdoNetApi.Runner.exe 
    writes content of Generated XML File and Generated Code File(s) into. 
    Locations are configurable. 

Let’s put all known to this point together
==========================================

As you can see on example of SqlToAdoNetApi.Dal.ApiTestDB DAL Project above, 
there is no content there yet. Runner generates content of the project just 
before the project starts compiling. 

Runner looks into SqlToAdoNetApi.Runner.exe.config file, where the key 
```
\<add key="DbApi.DatabaseSettingsPath" value="..\\Configuration\\DbApiDataSource.xml" /\>
```
tells it where to find API Configuration File. Then the API Configuration 
File tells Runner where to find DB API-ready scripts.

Then Runner parses DB API-ready scripts and composes Object Graph. Then 
Runner uses Object Graph to generate DA Methods and DA Classes and write 
result into respective .cs or .vb files.

Now let’s make sure that Runner executes before DAL Project starts 
compilation. Let’s create Target section in .csproj or .vbproj file: 

```
<Target Name="BeforeBuild">
	<Exec Command="copy \$(ProjectDir)Generated\\CSharpCode\\DoNotDelete.txt $(ProjectDir)\\Generated\\CSharpCode\\ApiTestDBGenerated.cs /y"/>
	<Exec Command="\$(ProjectDir)Exec\\SqlToAdoNetApi.Runner.exe" ContinueOnError="False">
		<Output TaskParameter="ExitCode" PropertyName="ErrorCode"/>
	</Exec\>
	<Message Importance="high" Text="\$(ErrorCode)"/>
</Target>
```
In example above, MSBuild clears ApiTestDbGenerated.cs and then Runner generates new content into it. 

Configuration
=============

API Configuration File
----------------------

XML formatted API Configuration File defines all settings of DAL Project. 

### \<DataSource ..\>

Root element of API Configuration File.

#### Attributes

**language** – string – required – defines programming language for code
generation. “CSharp” and “VB” are the options.

#### Child elements

**\<Databases** ..\> – collection of complex objects – required – describes
databases.

**\<Defaults**\> – complex object – required – defines set of default variables
used by Runner.

**\<XmlOutput** ..\> – complex object – tells Runner to generate serialize 
Object Graph into XML file, as well as defines location of this file.

**\<LogErrors**\> – collection of complex objects – collection of error loggers.
Each logger has its own output.

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

#### Attributes

**key** – string – required – Name of DB. Spaces are not allowed. Name must be 
unique in Database Collection.

**name** – string – required – DB description.

#### Child elements

**\<ConnectionString** ..\> – complex object – DB connection string object.

**\<Namespace\>** – string – optional – defines namespace in generated
C\#/VB.NET file

**\<CSharpOutput** ..\> – complex object – tells Runner to generate C\#/VB.NET
file, as well as defines location of this file.

**\<TableLocations**\> – collection of complex objects – locations of SQL tables
files

**\<StoredProcLocations**\> – collection of complex objects – locations of SQL
stored procedures files

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

#### Attributes

**connectionString** – string – required – configuration key in app.config or
web.config.

**providerName** – string – required – connection DB provider.

### \<CSharpOutput ..\> 

Identifies if C\#/VB.NET is generated as well as location of the file.

#### Attributes

**generate** – boolean – required – flag tells generator whether to generate
C\#/VB.NET file or not

**path** – string – required – local directory path where generated code will be
stored in C\#/VB.NET file

### \<TableLocation ..\> 

Location of SQL tables files

#### Attributes

**path** – string – required – local directory path where stored tables are
loaded from

### \<StorProcLocation ..\> 

Location of SQL stored procedures files

#### Attributes

**path** – string – required – local directory path where stored procedures
files are loaded from

### \<Defaults\>

Assembly of various parameters, which govern code generation process.

#### Child elements

**\<KeepRelativePath**\> – boolean – optional – flag tells generator whether to
convert relative paths to absolute ones or not.

**\<NormalizeParameterName**\> – boolean – optional – tells generator whether to
parameter should have camelLike style.

**\<NormalizePropertyName**\> – boolean – optional – tells generator whether to
class property should have PascalLike style.

**\<CleanupKeywords\>** – collection of complex objects – collection of cleanup
keywords

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

#### Attributes

**caseSensitive** – boolean – required – Regex expression, which is used in
table script cleanup, when extracting column descriptor.

### \<XmlOutput ..\> 

Identifies if XML is generated as well as location of the file.

#### Attributes

**generate** – boolean – required – flag tells generator whether to generate XML
file or not

**path** – string – required – local directory path where generated XML will be
stored

### \<LogType ..\>

Defines how errors are shown or logged.

#### Attributes

**output** – enum – required – defines type of error output. **VsOutput** –
error is shown in Output Window of Visual Studio. **File** – error is logged in
file located at path specified by attribute path. **PopupWindow** – error is
shown in popup window (desktop application).

**path** – string – required for **File** type output – local directory path
where logs are stored.

**disable** – string – optional – flag specifies if this log type should be
suppressed.

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

No worries. If stored procedure does not have DbApiMetadata metadata in it, it
will be ignored by Runner.

### \<DbApiMetadata ..\> 

Root element of metadata object, which defines input and output parameters of
stored procedure.

#### Attributes

**method** – string – optional – specifies DA Method name. Runner generates C\#
method **GetListOfUser** In the example above. If not provided, C\# method takes
name of stored procedure.

**description** – string – optional – description is added as comments of the DA
Method.

#### Child elements

**\<ProcParams** ..\> – collection of complex objects – required – collection of
input parameters. C\# generator supports 3 types of parameters: **InParam**,
**OutParam** and **InOutParam**, which are transformed into **regular**
parameters as well as parameters with **out** and **ref** modifiers in DA Method
respectively. VB.NET generator takes only regular and **ByRef** parameter types,
because **OUT** modifier is not supported by language.

**\<ProcResult ..\>** *(\<ClassResult ..\>, \<CollectionResult ..\>,
\<ScalarResult ..\>, \<DataSetResult ..\>, \<NoResult ..\>)* – complex object –
complex object – required – defines return type of DA Method. It may also define
class for **ClassResult** and **CollectionResult** types of **ProcResult**. Must
be 1 of 5 types:

1.  ClassResult – return object of class type.

2.  CollectionResult – return collection of class type objects.

3.  ScalarResult – return any value type; byte, bool, int …

4.  DataSetResult – return DataSet, which may have 1 or more DataTables.

5.  NoResult – return is not required.

### \<InParam ..\>, \<OutParam ..\> and \<InOutParam ..\> 

XML element of metadata object, which defines type and other properties of input
parameter.

#### Attributes

**name** – string – mandatory – specifies parameter name

**type** – string – conditional – specifies SQL parameter type. Presently
SqlDbType.Variant and SqlDbType.Udt are not supported. The rest of SqlDbType
types are supported by DB API. If **type** is not specified, **typeDef**
attribute must be.

**typeDef** – string – mandatory – specifies type of parameter, where the type
itself is defined by schema.Table.Column.type. It is preferred way to specify
type of input parameter, because when type of column in table changes, DB API
changes type of input parameter automatically.

**nullable** – string – mandatory – tells Runner to generate nullable value type
of DA Method input parameter.

**description** – string – optional – description is added as comments of the DA
Method’s input parameter.

### \<ClassResult ..\>, \<CollectionResult ..\>, \<ScalarResult ..\>, \<DataSetResult ..\>, \<NoResult ..\>

element defines return type of DA Method.

#### Attributes

**name** – string – mandatory – specifies parameter name

### \<ClassResult ..\>

**className** – string – conditional – specifies name of class, which defines
type of returned POCO object. If it is not specified, **classNameDef** attribute
must be defined to give name of class, which is declared elsewhere; in other
metadata of another stored procedure. It is done to support DA Methods returning
the same type of objects. For example, GetUser and GetUsers procedures return
**UserAccount** class and ICollection\<**UserAccount**\> collection
respectively, while both returning objects of **UserAccount** type.

**classNameDef** – string – conditional – specifies name of class scripted
elsewhere. See className for explanation.

**ResultParams** – collection of complex objects – required – collection of
properties of POCO class.

**description** – string – optional – description is added as comments of the DA
Method’s return.

### \<CollectionResult ..\>

Same as **ClassResult**, only DA Method returns collection of ClassResult
objects.

### \<ScalarResult ..\>

Return any value type; byte, bool, int … from DB perspective, it is single row,
single column of single recordset.

### \<DataSetResult ..\>

Return DataSet, which may have 1 or more DataTables.

### \<NoResult ..\>

Return is not required. Strictly speaking, this result type returns integer,
which have number of affected rows or last DML statement of the stored procedure
called.

### \<ResultParam ..\>

Property of return type POCO class, when return type is specified as ClassResult
and CollectionResult.

#### Attributes

**name** – string – mandatory – specifies parameter name

**type** – string – conditional – specifies SQL parameter type. Presently
SqlDbType.Variant and SqlDbType.Udt are not supported. The rest of SqlDbType
types are supported by DB API. If **type** is not specified, **typeDef**
attribute must be.

**typeDef** – string – mandatory – specifies type of parameter, where the type
itself is defined by schema.Table.Column.type. It is preferred way to specify
type of input parameter, because when type of column in table changes, DB API
changes type of input parameter automatically.

**nullable** – string – mandatory – tells Runner to generate nullable value type
of DA Method input parameter.

**description** – string – optional – description is added as comments of the DA
Method’s input parameter.

### Why SQL Runner parses tables?

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
