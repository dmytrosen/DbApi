# SQL to ADO.NET API (Automated ADO.NET)

Introduction
============

One time ADO.NET was very popular among .NET developers. It still is. Quite a
number of .NET folks still push and pull data to and from database using the
same old reliable ADO.NET, which, by the way, Microsoft continues to improve.
Not all (and far from it) developers have embraced ORM frameworks. There are
good reasons for that. However, discussion of those reasons is out of scope of
this document.

This document is about a way to make life of .NET developer easy by automating
ADO.NET part of development.

Background
----------

It is common when developer writes stored procedure code as well as a component,
which is intended to use the stored procedure. Then he or she creates a
respective method in corresponding data access layer project to connect both:
.NET component and beck-end stored procedure. Most common way to create this
method among developers is copy/paste/adjust similar code. It works well,
because this kind of ADO.NET coding is pretty much straightforward, well known
and well templated. It is so routing that it begs to be automated.

Not surprisingly, some companies have created one variation or another of an
ADO.NET code generator. Quite often such code generator takes form of internal
tool or API, which generates a data access layer DLL before MSBuild starts
building solution. Once DAL method is generated, it is discoverable through .NET
reflection. Hence, .NET project containing this method can be bound at design
time, if build sequence is guaranteed of course.

This approach is not quite native to MSBuild. Committing early binding to such
DAL project may be difficult at times. Another major problem is limited ability
of such tool to identify source of failure, because corresponding code or XML
which feeds generator is not part of the built solution.

Ideal workflow would be like this. Developer creates or modifies a stored
procedure and saves the changes. Then he or she initiates build of a DAL
project. This action kicks off a process, which reads the stored procedure,
generates respective method and puts relevant ADO.NET content in it. Once it’s
done, the DAL project or DLL (depends on what generator delivers) is ready for
use by other .NET projects.

Let’s take a look on “SQL to ADO.NET API” (later on – DB API), which does it
all.

Fundamentals
============

### Metadata 

Once upon a time someone got an idea to describe input and output of stored
procedure in XML and put this XML in the same stored procedure. This XML is
universally called metadata. Example of metadata when using DB API:
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
Having all in one SQL file solves SQL script-metadata mapping problem, reduces
number of files and improves understanding of code. On other hand, adopting XML
as method descriptor’s metalanguage streamlines conversion of metadata to .NET
runtime object of well known type. Simple deserialization does the job.
Deserialized metadata object has everything it needs to generate matching
ADO.NET method.

### Configuration 

DAL project is configured to run an executable. In DB API case, the executable
is the code generator. Let’s call it Runner.

MSBuild invokes Runner before it starts build DAL project. Runner loads and
parses SQL scripts and metadata, and generates corresponding data access
methods.

DB API expects DAL project to be of .NET Class Library, C\# or VB.NET language.
This project serves as a code placeholder, where Runner puts generated C\# or
VB.NET generated code.

Definitions
===========

1.  Runner – SqlToAdoNetApi.Runner – an application, which reads SQL scripts of
    SQL tables and stored procedures, and generates source code of DA Methods
    either using C\# or VB.NET programming languages. It is, by all means,
    SQL-to-C\#/VB.NET code generator.

2.  DA Method – generated data access method contains ADO.NET code, which talks
    to associated stored procedure.

3.  DA Class – generated .NET POCO class. DA Method returns it when stored
    procedure returns single row of single recordset. ClassResult or
    CollectionResult return type must be specified as return type in metadata.

4.  DAL Project - data access layer compiled project. The project, which is
    configured to host generated .NET source code files. DAL Project is .NET
    class library.

5.  DAL DLL – DLL as result of DAL Project compilation.

6.  API Configuration File – XML file, which describes databases and other
    resources, as well as defines SqlToAdoNetApi.Runner execution behavior.

7.  Generated XML file – XML file represents assembly of all complex objects,
    which define generated SQL tables, DA Methods and DA Classes.

8.  Generated Code File – C\# or VB.NET source code file, which contains all
    generated DA Methods and DA Classes of a Database in DAL Project. There is
    only 1 Generated Code File per database in DAL Project.

DAL Project Structure
=====================

Graphical example of DAL Project of test database configured for this DB API.

![DAL Project](/Images/graph1.png)

DAL Project has 4 sections:

1.  Configuration File – API configuration file like DbApiDataSource.xml in the
    example above. The file can be located anywhere; however, it is recommended
    to keep it in structure of the project. When SqlToAdoNetApi.Runner.exe is
    invoked, DbApi.DatabaseSettingsPath key in SqlToAdoNetApi.Runner.exe.config
    file tells executable where the Configuration File is located.

2.  Database scripts – all database scripts: tables and stored procedures. The
    scripts are parsed during SQL-to-C\#/VB.NET code generation process. Actual
    SQL script files can be located anywhere with exception of shared folder
    (presently). DB folders are shown as part of the DAL Project for convenience
    only.

3.  Exec section – the project directory, where SqlToAdoNetApi.Runner.exe
    executable is located.

4.  Generated – the project directory, where SqlToAdoNetApi.Runner.exe places
    Generated XML File and Generated Code File(s) to. Locations are
    configurable.

Let’s put all known to this point together
==========================================

As you see on the Graph 1 of SqlToAdoNetApi.Dal.ApiTestDB DAL Project example,
there is almost nothing there. That is because Runner generates all code and
puts it into Generated section directories. C\#/VB.NET code goes into
ApiTestDbGenerated.cs file, which is set with Build Action “Compile” in DAL
Project. Therefore, when the SqlToAdoNetApi.Dal.ApiTestDB DAL Project is
compiled, all generated code is compiled in it.

Developer has to tell the Runner which stored procedure to compile and how. When
Runner starts, it looks into SqlToAdoNetApi.Runner.exe.config file, where the
key

\<add key="DbApi.DatabaseSettingsPath"
value="..\\Configuration\\DbApiDataSource.xml" /\>

tells it where to find API Configuration File of DAL Project. Then the API
Configuration File tells Runner where to find scripts of SQL tables and stored
procedures.

Then Runner loads, reads and parses all table and stored procedure files
composing Object Graph, which is used later to generate DA Methods and DA
Classes from SQL Metadata of all SQL files.

Once it’s done, DAL Project is ready for compilation.

Now let’s make sure that Runner executes before DAL Project starts compilation.
In order to do that, DAL Project file must have Target section as it is shown
below:
```
<Target Name="BeforeBuild">
	<Exec Command="copy \$(ProjectDir)Generated\\CSharpCode\\DoNotDelete.txt $(ProjectDir)\\Generated\\CSharpCode\\ApiTestDBGenerated.cs /y"/>
	<Exec Command="\$(ProjectDir)Exec\\SqlToAdoNetApi.Runner.exe" ContinueOnError="False">
		<Output TaskParameter="ExitCode" PropertyName="ErrorCode"/>
	</Exec\>
	<Message Importance="high" Text="\$(ErrorCode)"/>
</Target>
```
In this example, MSBuild clears ApiTestDbGenerated.cs and then Runner generates
new content into it.

Configuration
=============

API Configuration File
----------------------

API Configuration File is of XML format and defines all settings of DAL Project.

### \<DataSource ..\>

Root element of configuration object, which defines settings of the DAL Project.

#### Attributes

**language** – string – required – defines programming language for code
generation. “CSharp” and “VB” are the only options.

#### Child elements

**\<Databases** ..\> – collection of complex objects – required – describes
databases.

**\<Defaults**\> – complex object – required – defines set of default variables
used by Runner.

**\<XmlOutput** ..\> – complex object – tells Runner to generate Object Graph in
form of XML, as well as defines location of this file.

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

Database defines collection of paths, as well as other parameters. Each path
represent directory, where Runner looks for tables or stored procedures, which
participate in generation of Generated Code Files.

#### Attributes

**key** – string – required – Name of DB. Spaces are not allowed. Must be unique
in Database Collection.

**name** – string – required – Name of DB used as DB description.

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

World of S/W development is not perfect and avoiding mistakes is a difficult
task. DB API understands it and tries to help developer to troubleshoot metadata
along with tuning configuration files.

#### Tip 1

Configure LogType output VsOutput or/and File for automatic build, and all 3 for
debugging.
```
<LogErrors>
	<LogType output="VsOutput" />
	<LogType output="File" path="../../../Logs" nameTemplate="Log" />
	<LogType output="PopupWindow" disable="false" />
</LogErrors>
```

If error has made to build, log into File option likely is the most useful.

![File log](/Images/log.png)

If developer actively changes code, Popup Window probably is the best way to
detect and understand the error.

![Popup Window log](/Images/logr.png)

#### Tip 2

Turn on XML output while developing. You always can analyze the XML to find out
why e.g. property is not generated. Turn off XML output for automated production
build.

#### Tip 3

If in some reason it is not possible to configure to invoke Runner in \<Target
Name="BeforeBuild"\> in DAL Project, alternative would be to make use of 
pre-build events of the project.

Example of SQL to ADO.NET API
=============================

Get source code.

![Source code](/Images/graph2.png)

Prepare test databases
----------------------

Unit test project requires test databases:

-   **ApiEvaluateDB**

-   **ApiTestDB**

The databases can be restored from backups of the test databases created using
SQL Server 2014:

-   **\$\\DbApi\\DB\\ApiEvaluateDB.bak**

-   **\$\\DbApi\\DB\\ApiTestDB.bak**

![DB backup](/Images/graph3.png)

If the backups are not restored successfully for some reason, either create the
databases manually or run script:

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
