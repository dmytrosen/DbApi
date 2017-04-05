using System;
using System.Linq;
using System.Configuration;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SqlToAdoNetApi.Dal.ApiTestDB;
using System.Data;
using System.Collections.Generic;

namespace SqlToAdoNetApi.DbApi.Test.TestCSharp.CSharp
{
    [TestClass]
    public class CSharpCodeGeneratorTest
    {
        #region API tests dataset return

        [TestMethod]
        public void GetProcDataSetTestCs()
        {
            DataSet result = DalApiTestDB.RunProc.GetProcDataSet();

            Assert.IsNotNull(result, "GetProcDataSetTestCs() must not be NULL");
            Assert.IsTrue(result.Tables.Count > 0, "GetProcDataSetTestCs().Tables must have tables");
            Assert.AreNotEqual(result.Tables[0].Columns.Count, 0, "GetProcDataSetTestCs().Tables[0].Columns must have columns");
        }

        #endregion

        #region API tests single value return

        [TestMethod]
        public void GetProcScalarTestCs()
        {
            string pr;

            long result = DalApiTestDB.RunProc.GetProcScalar(125L, out pr);

            Assert.IsNotNull(pr, "GetProcScalarTestCs().pr must not be NULL");
            Assert.AreEqual(result, 10125L, "GetProcScalarTestCs().result value does not match");
            Assert.AreEqual(pr, "625", "GetProcScalarTestCs().pr value does not match");
        }

        #endregion

        #region API tests class return

        [TestMethod]
        public void GetProcClassResultTestCs()
        {
            // out params
            long outParamBigInt; byte[] outParamBinary; bool? outParamBit; string outParamChar;
            DateTime outParamDateTime; decimal? outParamDecimal; double outParamFloat;
            int? outParamInt; decimal outParamMoney; string outParamNChar;
            string outParamNVarChar; float? outParamReal;
            Guid outParamUniqueIdentifier; DateTime? outParamSmallDateTime; short outParamSmallInt;
            decimal? outParamSmallMoney; byte[] outParamTimestamp;
            byte outParamTinyInt; byte[] outParamVarBinary; string outParamVarChar;
            string outParamXml; DateTime? outParamDate; TimeSpan outParamTime;
            DateTime? outParamDateTime2; DateTimeOffset outParamDateTimeOffset; 
            // ref params
            long inOutParamBigInt = -10101; byte[] inOutParamBinary = new byte[4];
            bool? inOutParamBit = false; string inOutParamChar = "Z"; DateTime inOutParamDateTime = DateTime.Now;
            decimal? inOutParamDecimal = -1110; double inOutParamFloat = -5;
            int? inOutParamInt = -9; decimal inOutParamMoney = -10; string inOutParamNChar = "X";
            string inOutParamNVarChar = "V"; float? inOutParamReal = -15;
            Guid inOutParamUniqueIdentifier = Guid.NewGuid(); DateTime? inOutParamSmallDateTime = DateTime.Now;
            short inOutParamSmallInt = -11; decimal? inOutParamSmallMoney = -12;
            byte inOutParamTinyInt = 3; byte[] inOutParamVarBinary = new byte[3];
            string inOutParamVarChar = "B"; string inOutParamXml = "<ElementOut>elementOut</ElementOut>";
            DateTime? inOutParamDate = DateTime.Now; TimeSpan inOutParamTime = new TimeSpan(3);
            DateTime? inOutParamDateTime2 = new DateTime(1242143234); DateTimeOffset inOutParamDateTimeOffset = DateTimeOffset.Now;
            int inOutParamUpdatedBy = -11;

            ProcClassResult result = DalApiTestDB.RunProc.GetProcClassResult(2, 10000L, new byte[10], true,
                "a", DateTime.Today, -125.25M, .37F, new byte[100], -1, (decimal)1.27, "b", "charly", "delta", 0.39F, Guid.NewGuid(),
                DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                out inOutParamUpdatedBy, "Test Manifest", out outParamBigInt, out outParamBinary, out outParamBit,
                out outParamChar, out outParamDateTime, out outParamDecimal, out outParamFloat, out outParamInt,
                out outParamMoney, out outParamNChar, out outParamNVarChar, out outParamReal, out outParamUniqueIdentifier,
                out outParamSmallDateTime, out outParamSmallInt, out outParamSmallMoney, out outParamTimestamp, out outParamTinyInt,
                out outParamVarBinary, out outParamVarChar, out outParamXml, out outParamDate,
                out outParamTime, out outParamDateTime2, out outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNotNull(result, "GetProcClassResultTestCs() must not be NULL");
            Assert.AreEqual(result.ResultXml, "<ParamXml2>Param Xml 2</ParamXml2>", "GetProcClassResultTestCs().ResultXml value does not match");
            Assert.AreEqual(outParamXml, "<ElementOut>elementOut</ElementOut>", "GetProcClassResultTestCs().outParamXml value does not match");
            Assert.AreEqual(inOutParamXml, "<Element>element</Element>", "GetProcClassResultTestCs().inOutParamXml value does not match");
            Assert.AreEqual(inOutParamDecimal, -125.25M, "GetProcClassResultTestCs().inOutParamDecimal value does not match");
        }

        [TestMethod]
        public void GetProcExistingClassResultTestCs()
        {
            // out params
            long outParamBigInt; byte[] outParamBinary; bool? outParamBit; string outParamChar;
            DateTime outParamDateTime; decimal? outParamDecimal; double outParamFloat;
            int? outParamInt; decimal outParamMoney; string outParamNChar;
            string outParamNVarChar; float? outParamReal;
            Guid outParamUniqueIdentifier; DateTime? outParamSmallDateTime; short outParamSmallInt;
            decimal? outParamSmallMoney; byte[] outParamTimestamp;
            byte outParamTinyInt; byte[] outParamVarBinary; string outParamVarChar;
            string outParamXml; DateTime? outParamDate; TimeSpan outParamTime;
            DateTime? outParamDateTime2; DateTimeOffset outParamDateTimeOffset;
            // ref params
            long inOutParamBigInt = -10101; byte[] inOutParamBinary = new byte[4];
            bool? inOutParamBit = false; string inOutParamChar = "Z"; DateTime inOutParamDateTime = DateTime.Now;
            decimal? inOutParamDecimal = -1110; double inOutParamFloat = -5;
            int? inOutParamInt = -9; decimal inOutParamMoney = -10; string inOutParamNChar = "X";
            string inOutParamNVarChar = "V"; float? inOutParamReal = -15;
            Guid inOutParamUniqueIdentifier = Guid.NewGuid(); DateTime? inOutParamSmallDateTime = DateTime.Now;
            short inOutParamSmallInt = -11; decimal? inOutParamSmallMoney = -12;
            byte inOutParamTinyInt = 3; byte[] inOutParamVarBinary = new byte[3];
            string inOutParamVarChar = "B"; string inOutParamXml = "<ElementOut>elementOut</ElementOut>";
            DateTime? inOutParamDate = DateTime.Now; TimeSpan inOutParamTime = new TimeSpan(3);
            DateTime? inOutParamDateTime2 = new DateTime(1242143234); DateTimeOffset inOutParamDateTimeOffset = DateTimeOffset.Now;
            int inOutParamUpdatedBy = -11;

            ProcClassResult result = DalApiTestDB.RunProc.GetProcExistingClassResult(3, 10001L, new byte[10], true,
                "a", DateTime.Today, -125, .37F, new byte[100], -1, (decimal)1.27, "b", "charly", "delta", 0.39F, Guid.NewGuid(),
                DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                out inOutParamUpdatedBy, "Test Manifest", out outParamBigInt, out outParamBinary, out outParamBit,
                out outParamChar, out outParamDateTime, out outParamDecimal, out outParamFloat, out outParamInt,
                out outParamMoney, out outParamNChar, out outParamNVarChar, out outParamReal, out outParamUniqueIdentifier,
                out outParamSmallDateTime, out outParamSmallInt, out outParamSmallMoney, out outParamTimestamp, out outParamTinyInt,
                out outParamVarBinary, out outParamVarChar, out outParamXml, out outParamDate,
                out outParamTime, out outParamDateTime2, out outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNotNull(result, "GetProcExistingClassResultTestCs() must not be NULL");
            Assert.AreEqual(result.ResultXml, "<ParamXml3>Param Xml 3</ParamXml3>", "GetProcExistingClassResultTestCs().ResultXml value does not match");
            Assert.AreEqual(outParamXml, "<ElementOut>elementOut</ElementOut>", "GetProcExistingClassResultTestCs().outParamXml value does not match");
            Assert.AreEqual(inOutParamXml, "<Element>element</Element>", "GetProcExistingClassResultTestCs().inOutParamXml value does not match");
        }

        [TestMethod]
        public void GetProcClassResultFailTestCs()
        {
            // out params
            long outParamBigInt; byte[] outParamBinary; bool? outParamBit; string outParamChar;
            DateTime outParamDateTime; decimal? outParamDecimal; double outParamFloat;
            int? outParamInt; decimal outParamMoney; string outParamNChar;
            string outParamNVarChar; float? outParamReal;
            Guid outParamUniqueIdentifier; DateTime? outParamSmallDateTime; short outParamSmallInt;
            decimal? outParamSmallMoney; byte[] outParamTimestamp;
            byte outParamTinyInt; byte[] outParamVarBinary; string outParamVarChar;
            string outParamXml; DateTime? outParamDate; TimeSpan outParamTime;
            DateTime? outParamDateTime2; DateTimeOffset outParamDateTimeOffset;
            // ref params
            long inOutParamBigInt = -10101; byte[] inOutParamBinary = new byte[4];
            bool? inOutParamBit = false; string inOutParamChar = "Z"; DateTime inOutParamDateTime = DateTime.Now;
            decimal? inOutParamDecimal = -1110; double inOutParamFloat = -5;
            int? inOutParamInt = -9; decimal inOutParamMoney = -10; string inOutParamNChar = "X";
            string inOutParamNVarChar = "V"; float? inOutParamReal = -15;
            Guid inOutParamUniqueIdentifier = Guid.NewGuid(); DateTime? inOutParamSmallDateTime = DateTime.Now;
            short inOutParamSmallInt = -11; decimal? inOutParamSmallMoney = -12;
            byte inOutParamTinyInt = 3; byte[] inOutParamVarBinary = new byte[3];
            string inOutParamVarChar = "B"; string inOutParamXml = "<ElementOut>elementOut</ElementOut>";
            DateTime? inOutParamDate = DateTime.Now; TimeSpan inOutParamTime = new TimeSpan(3);
            DateTime? inOutParamDateTime2 = new DateTime(1242143234); DateTimeOffset inOutParamDateTimeOffset = DateTimeOffset.Now;
            int inOutParamUpdatedBy = -11;

            ProcClassResult result = DalApiTestDB.RunProc.GetProcClassResult(-1, 10000L, new byte[10], true,
                "a", DateTime.Today, -125, .37F, new byte[100], -1, (decimal)1.27, "b", "charly", "delta", 0.39F, Guid.NewGuid(),
                DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairEmptyTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                out inOutParamUpdatedBy, "Test Manifest", out outParamBigInt, out outParamBinary, out outParamBit,
                out outParamChar, out outParamDateTime, out outParamDecimal, out outParamFloat, out outParamInt,
                out outParamMoney, out outParamNChar, out outParamNVarChar, out outParamReal, out outParamUniqueIdentifier,
                out outParamSmallDateTime, out outParamSmallInt, out outParamSmallMoney, out outParamTimestamp, out outParamTinyInt,
                out outParamVarBinary, out outParamVarChar, out outParamXml, out outParamDate,
                out outParamTime, out outParamDateTime2, out outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNull(result, "GetProcClassResultFailTestCs() must be NULL");
        }

        #endregion

        #region API tests collection return

        [TestMethod]
        public void sp_ProcCollectionResultMethodTestCs()
        {
            // out params
            long outParamBigInt; byte[] outParamBinary; bool? outParamBit; string outParamChar;
            DateTime outParamDateTime; decimal? outParamDecimal; double outParamFloat;
            int? outParamInt; decimal outParamMoney; string outParamNChar;
            string outParamNVarChar; float? outParamReal;
            Guid outParamUniqueIdentifier; DateTime? outParamSmallDateTime; short outParamSmallInt;
            decimal? outParamSmallMoney; byte[] outParamTimestamp;
            byte outParamTinyInt; byte[] outParamVarBinary; string outParamVarChar;
            string outParamXml; DateTime? outParamDate; TimeSpan outParamTime;
            DateTime? outParamDateTime2; DateTimeOffset outParamDateTimeOffset;
            // ref params
            long inOutParamBigInt = -10101; byte[] inOutParamBinary = new byte[4];
            bool? inOutParamBit = false; string inOutParamChar = "Z"; DateTime inOutParamDateTime = DateTime.Now;
            decimal? inOutParamDecimal = -1110; double inOutParamFloat = -5;
            int? inOutParamInt = -9; decimal inOutParamMoney = -10; string inOutParamNChar = "X";
            string inOutParamNVarChar = "V"; float? inOutParamReal = -15;
            Guid inOutParamUniqueIdentifier = Guid.NewGuid(); DateTime? inOutParamSmallDateTime = DateTime.Now;
            short inOutParamSmallInt = -11; decimal? inOutParamSmallMoney = -12;
            byte inOutParamTinyInt = 3; byte[] inOutParamVarBinary = new byte[3];
            string inOutParamVarChar = "B"; string inOutParamXml = "<ElementOut>elementOut</ElementOut>";
            DateTime? inOutParamDate = DateTime.Now; TimeSpan inOutParamTime = new TimeSpan(3);
            DateTime? inOutParamDateTime2 = new DateTime(1242143234); DateTimeOffset inOutParamDateTimeOffset = DateTimeOffset.Now;
            int inOutParamUpdatedBy = -11;

            ICollection<ProcCollectionResult> result = DalApiTestDB.RunProc.sp_ProcCollectionResultMethod(null, 
                10002L, new byte[10], true, "a", DateTime.Today, -125, .37F, new byte[100], -1, (decimal)1.27, "b", "charly", 
                "delta", 0.39F, Guid.NewGuid(), DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                out inOutParamUpdatedBy, "Test Manifest", out outParamBigInt, out outParamBinary, out outParamBit,
                out outParamChar, out outParamDateTime, out outParamDecimal, out outParamFloat, out outParamInt,
                out outParamMoney, out outParamNChar, out outParamNVarChar, out outParamReal, out outParamUniqueIdentifier,
                out outParamSmallDateTime, out outParamSmallInt, out outParamSmallMoney, out outParamTimestamp, out outParamTinyInt,
                out outParamVarBinary, out outParamVarChar, out outParamXml, out outParamDate,
                out outParamTime, out outParamDateTime2, out outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNotNull(result, "sp_ProcCollectionResultMethodTestCs() collection must not be NULL");
            Assert.AreNotEqual(result.Count, 0, "sp_ProcCollectionResultMethodTestCs() collection must not be empty");

            ProcCollectionResult item = result.FirstOrDefault(i => i.ProcCollectionResultId == 1);

            Assert.IsNotNull(item, "sp_ProcCollectionResultMethodTestCs() collection does not have required item");
            Assert.AreEqual(item.ResultXml, "<ParamXml1>Param Xml 1</ParamXml1>", "sp_ProcCollectionResultMethodTestCs().item.ResultXml value does not match");
            Assert.AreEqual(outParamXml, "<ElementOut>elementOut</ElementOut>", "sp_ProcCollectionResultMethodTestCs().item.outParamXml value does not match");
            Assert.AreEqual(inOutParamXml, "<Element>element</Element>", "sp_ProcCollectionResultMethodTestCs().item.inOutParamXml value does not match");
        }

        [TestMethod]
        public void GetExistingCollectionResultTestCs()
        {
            // out params
            long outParamBigInt; byte[] outParamBinary; bool? outParamBit; string outParamChar;
            DateTime outParamDateTime; decimal? outParamDecimal; double outParamFloat;
            int? outParamInt; decimal outParamMoney; string outParamNChar;
            string outParamNVarChar; float? outParamReal;
            Guid outParamUniqueIdentifier; DateTime? outParamSmallDateTime; short outParamSmallInt;
            decimal? outParamSmallMoney; byte[] outParamTimestamp;
            byte outParamTinyInt; byte[] outParamVarBinary; string outParamVarChar;
            string outParamXml; DateTime? outParamDate; TimeSpan outParamTime;
            DateTime? outParamDateTime2; DateTimeOffset outParamDateTimeOffset;
            // ref params
            long inOutParamBigInt = -10101; byte[] inOutParamBinary = new byte[4];
            bool? inOutParamBit = false; string inOutParamChar = "Z"; DateTime inOutParamDateTime = DateTime.Now;
            decimal? inOutParamDecimal = -1110; double inOutParamFloat = -5;
            int? inOutParamInt = -9; decimal inOutParamMoney = -12; string inOutParamNChar = "X";
            string inOutParamNVarChar = "V"; float? inOutParamReal = -15;
            Guid inOutParamUniqueIdentifier = Guid.NewGuid(); DateTime? inOutParamSmallDateTime = DateTime.Now;
            short inOutParamSmallInt = -10; decimal? inOutParamSmallMoney = -12;
            byte inOutParamTinyInt = 3; byte[] inOutParamVarBinary = new byte[3];
            string inOutParamVarChar = "B"; string inOutParamXml = "<ElementOut>elementOut</ElementOut>";
            DateTime? inOutParamDate = DateTime.Now; TimeSpan inOutParamTime = new TimeSpan(5);
            DateTime? inOutParamDateTime2 = new DateTime(1242143234); DateTimeOffset inOutParamDateTimeOffset = DateTimeOffset.Now;
            int inOutParamUpdatedBy = -11;

            ICollection<ProcCollectionResult> result = DalApiTestDB.RunProc.GetExistingCollectionResult(10003L, 
                new byte[10], true, "a", DateTime.Today, -125, .37F, new byte[100], -1, (decimal)1.27, "b", "charly",
                "delta", 0.39F, Guid.NewGuid(), DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                out inOutParamUpdatedBy, "Test Manifest", out outParamBigInt, out outParamBinary, out outParamBit,
                out outParamChar, out outParamDateTime, out outParamDecimal, out outParamFloat, out outParamInt,
                out outParamMoney, out outParamNChar, out outParamNVarChar, out outParamReal, out outParamUniqueIdentifier,
                out outParamSmallDateTime, out outParamSmallInt, out outParamSmallMoney, out outParamTimestamp, out outParamTinyInt,
                out outParamVarBinary, out outParamVarChar, out outParamXml, out outParamDate,
                out outParamTime, out outParamDateTime2, out outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNotNull(result, "GetExistingCollectionResultTestCs() collection must not be NULL");
            Assert.AreNotEqual(result.Count, 0, "GetExistingCollectionResultTestCs() collection must not be empty");

            ProcCollectionResult item = result.FirstOrDefault(i => i.ProcCollectionResultId == 3);

            Assert.IsNotNull(item, "GetExistingCollectionResultTestCs() collection does not have required item");
            Assert.AreEqual(item.ResultXml, "<ParamXml3>Param Xml 3</ParamXml3>", "GetExistingCollectionResultTestCs().item.ResultXml value does not match");
            Assert.AreEqual(outParamXml, "<ElementOut>elementOut</ElementOut>", "GetExistingCollectionResultTestCs().item.outParamXml value does not match");
            Assert.AreEqual(inOutParamXml, "<Element>element</Element>", "GetExistingCollectionResultTestCs().item.inOutParamXml value does not match");
        }

        [TestMethod]
        public void sp_ProcCollectionResultMethodFailedTestCs()
        {
            // out params
            long outParamBigInt; byte[] outParamBinary; bool? outParamBit; string outParamChar;
            DateTime outParamDateTime; decimal? outParamDecimal; double outParamFloat;
            int? outParamInt; decimal outParamMoney; string outParamNChar;
            string outParamNVarChar; float? outParamReal;
            Guid outParamUniqueIdentifier; DateTime? outParamSmallDateTime; short outParamSmallInt;
            decimal? outParamSmallMoney; byte[] outParamTimestamp;
            byte outParamTinyInt; byte[] outParamVarBinary; string outParamVarChar;
            string outParamXml; DateTime? outParamDate; TimeSpan outParamTime;
            DateTime? outParamDateTime2; DateTimeOffset outParamDateTimeOffset;
            // ref params
            long inOutParamBigInt = -10101; byte[] inOutParamBinary = new byte[4];
            bool? inOutParamBit = false; string inOutParamChar = "Z"; DateTime inOutParamDateTime = DateTime.Now;
            decimal? inOutParamDecimal = -1110; double inOutParamFloat = -5;
            int? inOutParamInt = -9; decimal inOutParamMoney = -10; string inOutParamNChar = "X";
            string inOutParamNVarChar = "V"; float? inOutParamReal = -15;
            Guid inOutParamUniqueIdentifier = Guid.NewGuid(); DateTime? inOutParamSmallDateTime = DateTime.Now;
            short inOutParamSmallInt = -11; decimal? inOutParamSmallMoney = -12;
            byte inOutParamTinyInt = 3; byte[] inOutParamVarBinary = new byte[3];
            string inOutParamVarChar = "B"; string inOutParamXml = "<ElementOut>elementOut</ElementOut>";
            DateTime? inOutParamDate = DateTime.Now; TimeSpan inOutParamTime = new TimeSpan(3);
            DateTime? inOutParamDateTime2 = new DateTime(1242143234); DateTimeOffset inOutParamDateTimeOffset = DateTimeOffset.Now;
            int inOutParamUpdatedBy = -11;

            ICollection<ProcCollectionResult> result = DalApiTestDB.RunProc.sp_ProcCollectionResultMethod(-1,
                10002L, new byte[10], true, "a", DateTime.Today, -125, .37F, new byte[100], -1, (decimal)1.27, "b", "charly",
                "delta", 0.39F, Guid.NewGuid(), DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                out inOutParamUpdatedBy, "Test Manifest", out outParamBigInt, out outParamBinary, out outParamBit,
                out outParamChar, out outParamDateTime, out outParamDecimal, out outParamFloat, out outParamInt,
                out outParamMoney, out outParamNChar, out outParamNVarChar, out outParamReal, out outParamUniqueIdentifier,
                out outParamSmallDateTime, out outParamSmallInt, out outParamSmallMoney, out outParamTimestamp, out outParamTinyInt,
                out outParamVarBinary, out outParamVarChar, out outParamXml, out outParamDate,
                out outParamTime, out outParamDateTime2, out outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNotNull(result, "sp_ProcCollectionResultMethodFailedTestCs() collection must not be NULL");
            Assert.AreEqual(result.Count, 0, "sp_ProcCollectionResultMethodFailedTestCs() collection must be empty");
        }

        #endregion

        #region Private methods

        private DataTable CreateIntBitValuePairTable(string name)
        {
            DataTable testDataTable = CreateIntBitValuePairEmptyTable(name);
            DataRow dr = testDataTable.NewRow();

            dr["IntValue"] = 5;
            dr["BitValue"] = 1;
            testDataTable.Rows.Add(dr);
            dr = testDataTable.NewRow();
            dr["IntValue"] = 4;
            dr["BitValue"] = 0;
            testDataTable.Rows.Add(dr);
            dr = testDataTable.NewRow();
            dr["IntValue"] = 3;
            dr["BitValue"] = 1;
            testDataTable.Rows.Add(dr);
            dr = testDataTable.NewRow();
            dr["IntValue"] = 2;
            dr["BitValue"] = 0;
            testDataTable.Rows.Add(dr);
            dr = testDataTable.NewRow();
            dr["IntValue"] = 1;
            dr["BitValue"] = 1;
            testDataTable.Rows.Add(dr);
            return testDataTable;
        }

        private DataTable CreateIntBitValuePairEmptyTable(string name)
        {
            DataTable testDataTable = new DataTable(name);

            testDataTable.Columns.Add(new DataColumn("IntValue", typeof(int)));
            testDataTable.Columns.Add(new DataColumn("BitValue", typeof(bool)));
            return testDataTable;
        }

        #endregion
    }
}
