using System;
using System.Linq;
using System.Configuration;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data;
using System.Collections.Generic;
using SqlToAdoNetApi.Dal.ApiEvaluateDB.SqlToAdoNetApi.Dal.ApiEvaluatetDB;

namespace SqlToAdoNetApi.DbApi.Test.VB
{
    [TestClass]
    public class VBCodeGeneratorTest
    {
        #region API tests dataset return

        [TestMethod]
        public void GetProcDataSetTestVb()
        {
            DataSet result = DalApiEvaluatetDB.RunProc.GetProcDataSet();

            Assert.IsNotNull(result, "GetProcDataSetTestVb() must not be NULL");
            Assert.IsTrue(result.Tables.Count > 0, "GetProcDataSetTestVb().Tables must have tables");
            Assert.AreNotEqual(result.Tables[0].Columns.Count, 0, "GetProcDataSetTestVb().Tables[0].Columns must have columns");
        }

        #endregion

        #region API tests single value return

        [TestMethod]
        public void GetProcScalarTestVb()
        {
            string pr = string.Empty;

            long result = DalApiEvaluatetDB.RunProc.GetProcScalar(125L, ref pr);

            Assert.IsNotNull(pr, "GetProcScalarTestVb().pr must not be NULL");
            Assert.AreEqual(result, 10125L, "GetProcScalarTestVb().result value does not match");
            Assert.AreEqual(pr, "625", "GetProcScalarTestVb().pr value does not match");
        }

        #endregion

        #region API tests class return

        [TestMethod]
        public void GetProcClassResultTestVb()
        {
            // out params
            long outParamBigInt = default(long); byte[] outParamBinary = null; bool? outParamBit = null; string outParamChar = null;
            DateTime outParamDateTime = new DateTime(100000); decimal? outParamDecimal = null; double outParamFloat = default(double);
            int? outParamInt = null; decimal outParamMoney = 6.99M; string outParamNChar = null;
            string outParamNVarChar = null; float? outParamReal = null;
            Guid outParamUniqueIdentifier = Guid.Empty; DateTime? outParamSmallDateTime = null; short outParamSmallInt = 7;
            decimal? outParamSmallMoney = null; byte[] outParamTimestamp = null;
            byte outParamTinyInt = default(byte); byte[] outParamVarBinary = null; string outParamVarChar = null;
            string outParamXml = null; DateTime? outParamDate = null; TimeSpan outParamTime = new TimeSpan(5000);
            DateTime? outParamDateTime2 = null; DateTimeOffset outParamDateTimeOffset = default(DateTimeOffset); 
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

            ProcClassResult result = DalApiEvaluatetDB.RunProc.GetProcClassResult(2, 10000L, new byte[10], true,
                "a", DateTime.Today, -125.25M, .37F, new byte[100], -1, (decimal)1.27, "b", "charly", "delta", 0.39F, Guid.NewGuid(),
                DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                ref inOutParamUpdatedBy, "Test Manifest", ref outParamBigInt, ref outParamBinary, ref outParamBit,
                ref outParamChar, ref outParamDateTime, ref outParamDecimal, ref outParamFloat, ref outParamInt,
                ref outParamMoney, ref outParamNChar, ref outParamNVarChar, ref outParamReal, ref outParamUniqueIdentifier,
                ref outParamSmallDateTime, ref outParamSmallInt, ref outParamSmallMoney, ref outParamTimestamp, ref outParamTinyInt,
                ref outParamVarBinary, ref outParamVarChar, ref outParamXml, ref outParamDate,
                ref outParamTime, ref outParamDateTime2, ref outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNotNull(result, "GetProcClassResultTestVb() must not be NULL");
            Assert.AreEqual(result.ResultXml, "<ParamXml2>Param Xml 2</ParamXml2>", "GetProcClassResultTestVb().ResultXml value does not match");
            Assert.AreEqual(outParamXml, "<ElementOut>elementOut</ElementOut>", "GetProcClassResultTestVb().outParamXml value does not match");
            Assert.AreEqual(inOutParamXml, "<Element>element</Element>", "GetProcClassResultTestVb().inOutParamXml value does not match");
            Assert.AreEqual(inOutParamDecimal, -125.25M, "GetProcClassResultTestCs().inOutParamDecimal value does not match");
        }

        [TestMethod]
        public void GetProcExistingClassResultTestVb()
        {
            // out params
            long outParamBigInt = default(long); byte[] outParamBinary = null; bool? outParamBit = null; string outParamChar = null;
            DateTime outParamDateTime = DateTime.Now.AddHours(-55); decimal? outParamDecimal = null; double outParamFloat = default(double);
            int? outParamInt = null; decimal outParamMoney = 7.99M; string outParamNChar = null;
            string outParamNVarChar = null; float? outParamReal = null;
            Guid outParamUniqueIdentifier = Guid.Empty; DateTime? outParamSmallDateTime = null; short outParamSmallInt = 8;
            decimal? outParamSmallMoney = null; byte[] outParamTimestamp = null;
            byte outParamTinyInt = default(byte); byte[] outParamVarBinary = null; string outParamVarChar = null;
            string outParamXml = null; DateTime? outParamDate = null; TimeSpan outParamTime = TimeSpan.MaxValue;
            DateTime? outParamDateTime2 = null; DateTimeOffset outParamDateTimeOffset = default(DateTimeOffset);
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
            DateTime? inOutParamDate = DateTime.Now; TimeSpan inOutParamTime = new TimeSpan(30000);
            DateTime? inOutParamDateTime2 = new DateTime(1242143234); DateTimeOffset inOutParamDateTimeOffset = DateTimeOffset.Now;
            int inOutParamUpdatedBy = -11;

            ProcClassResult result = DalApiEvaluatetDB.RunProc.GetProcExistingClassResult(3, 10001L, new byte[10], true,
                "a", DateTime.Today, -125, .37F, new byte[100], -1, (decimal)1.27, "b", "charly", "delta", 0.39F, Guid.NewGuid(),
                DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                ref inOutParamUpdatedBy, "Test Manifest", ref outParamBigInt, ref outParamBinary, ref outParamBit,
                ref outParamChar, ref outParamDateTime, ref outParamDecimal, ref outParamFloat, ref outParamInt,
                ref outParamMoney, ref outParamNChar, ref outParamNVarChar, ref outParamReal, ref outParamUniqueIdentifier,
                ref outParamSmallDateTime, ref outParamSmallInt, ref outParamSmallMoney, ref outParamTimestamp, ref outParamTinyInt,
                ref outParamVarBinary, ref outParamVarChar, ref outParamXml, ref outParamDate,
                ref outParamTime, ref outParamDateTime2, ref outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNotNull(result, "GetProcExistingClassResultTestVb() must not be NULL");
            Assert.AreEqual(result.ResultXml, "<ParamXml3>Param Xml 3</ParamXml3>", "GetProcExistingClassResultTestVb().ResultXml value does not match");
            Assert.AreEqual(outParamXml, "<ElementOut>elementOut</ElementOut>", "GetProcExistingClassResultTestVb().outParamXml value does not match");
            Assert.AreEqual(inOutParamXml, "<Element>element</Element>", "GetProcExistingClassResultTestVb().inOutParamXml value does not match");
        }

        [TestMethod]
        public void GetProcClassResultFailTestVb()
        {
            // out params
            long outParamBigInt = default(long); byte[] outParamBinary = null; bool? outParamBit = null; string outParamChar = null;
            DateTime outParamDateTime = DateTime.MaxValue; decimal? outParamDecimal = null; double outParamFloat = default(double);
            int? outParamInt = null; decimal outParamMoney = 9.999M; string outParamNChar = null;
            string outParamNVarChar = null; float? outParamReal = null;
            Guid outParamUniqueIdentifier = Guid.Empty; DateTime? outParamSmallDateTime = null; short outParamSmallInt = 9;
            decimal? outParamSmallMoney = null; byte[] outParamTimestamp = null;
            byte outParamTinyInt = default(byte); byte[] outParamVarBinary = null; string outParamVarChar = null;
            string outParamXml = null; DateTime? outParamDate = null; TimeSpan outParamTime = new TimeSpan(2500000);
            DateTime? outParamDateTime2 = null; DateTimeOffset outParamDateTimeOffset = default(DateTimeOffset);
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

            ProcClassResult result = DalApiEvaluatetDB.RunProc.GetProcClassResult(-1, 10000L, new byte[10], true,
                "a", DateTime.Today, -125, .37F, new byte[100], -1, (decimal)1.27, "b", "charly", "delta", 0.39F, Guid.NewGuid(),
                DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairEmptyTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                ref inOutParamUpdatedBy, "Test Manifest", ref outParamBigInt, ref outParamBinary, ref outParamBit,
                ref outParamChar, ref outParamDateTime, ref outParamDecimal, ref outParamFloat, ref outParamInt,
                ref outParamMoney, ref outParamNChar, ref outParamNVarChar, ref outParamReal, ref outParamUniqueIdentifier,
                ref outParamSmallDateTime, ref outParamSmallInt, ref outParamSmallMoney, ref outParamTimestamp, ref outParamTinyInt,
                ref outParamVarBinary, ref outParamVarChar, ref outParamXml, ref outParamDate,
                ref outParamTime, ref outParamDateTime2, ref outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNull(result, "GetProcClassResultFailTestVb() must be NULL");
        }

        #endregion

        #region API tests collection return

        [TestMethod]
        public void sp_ProcCollectionResultMethodTestVb()
        {
            // out params
            long outParamBigInt = default(long); byte[] outParamBinary = null; bool? outParamBit = null; string outParamChar = null;
            DateTime outParamDateTime = DateTime.Now; decimal? outParamDecimal = null; double outParamFloat = default(double);
            int? outParamInt = null; decimal outParamMoney = 5.99M; string outParamNChar = null;
            string outParamNVarChar = null; float? outParamReal = null;
            Guid outParamUniqueIdentifier = Guid.Empty; DateTime? outParamSmallDateTime = null; short outParamSmallInt = 4;
            decimal? outParamSmallMoney = null; byte[] outParamTimestamp = null;
            byte outParamTinyInt = default(byte); byte[] outParamVarBinary = null; string outParamVarChar = null;
            string outParamXml = null; DateTime? outParamDate = null; TimeSpan outParamTime = TimeSpan.MinValue;
            DateTime? outParamDateTime2 = null; DateTimeOffset outParamDateTimeOffset = default(DateTimeOffset);
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

            ICollection<ProcCollectionResult> result = DalApiEvaluatetDB.RunProc.sp_ProcCollectionResultMethod(null, 
                10002L, new byte[10], true, "a", DateTime.Today, -125, .37F, new byte[100], -1, (decimal)1.27, "b", "charly", 
                "delta", 0.39F, Guid.NewGuid(), DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                ref inOutParamUpdatedBy, "Test Manifest", ref outParamBigInt, ref outParamBinary, ref outParamBit,
                ref outParamChar, ref outParamDateTime, ref outParamDecimal, ref outParamFloat, ref outParamInt,
                ref outParamMoney, ref outParamNChar, ref outParamNVarChar, ref outParamReal, ref outParamUniqueIdentifier,
                ref outParamSmallDateTime, ref outParamSmallInt, ref outParamSmallMoney, ref outParamTimestamp, ref outParamTinyInt,
                ref outParamVarBinary, ref outParamVarChar, ref outParamXml, ref outParamDate,
                ref outParamTime, ref outParamDateTime2, ref outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNotNull(result, "sp_ProcCollectionResultMethodTestVb() collection must not be NULL");
            Assert.AreNotEqual(result.Count, 0, "sp_ProcCollectionResultMethodTestVb() collection must not be empty");

            ProcCollectionResult item = result.FirstOrDefault(i => i.ProcCollectionResultId == 1);

            Assert.IsNotNull(item, "sp_ProcCollectionResultMethodTestVb() collection does not have required item");
            Assert.AreEqual(item.ResultXml, "<ParamXml1>Param Xml 1</ParamXml1>", "sp_ProcCollectionResultMethodTestVb().item.ResultXml value does not match");
            Assert.AreEqual(outParamXml, "<ElementOut>elementOut</ElementOut>", "sp_ProcCollectionResultMethodTestVb().item.outParamXml value does not match");
            Assert.AreEqual(inOutParamXml, "<Element>element</Element>", "sp_ProcCollectionResultMethodTestVb().item.inOutParamXml value does not match");
        }

        [TestMethod]
        public void GetExistingCollectionResultTestVb()
        {
            // out params
            long outParamBigInt = default(long); byte[] outParamBinary = null; bool? outParamBit = null; string outParamChar = null;
            DateTime outParamDateTime = DateTime.MinValue; decimal? outParamDecimal = null; double outParamFloat = default(double);
            int? outParamInt = null; decimal outParamMoney = 4.99M; string outParamNChar = null;
            string outParamNVarChar = null; float? outParamReal = null;
            Guid outParamUniqueIdentifier = Guid.Empty; DateTime? outParamSmallDateTime = null; short outParamSmallInt = 3;
            decimal? outParamSmallMoney = null; byte[] outParamTimestamp = null;
            byte outParamTinyInt = default(byte); byte[] outParamVarBinary = null; string outParamVarChar = null;
            string outParamXml = null; DateTime? outParamDate = null; TimeSpan outParamTime = TimeSpan.MinValue;
            DateTime? outParamDateTime2 = null; DateTimeOffset outParamDateTimeOffset = default(DateTimeOffset);
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

            ICollection<ProcCollectionResult> result = DalApiEvaluatetDB.RunProc.GetExistingCollectionResult(10003L, 
                new byte[10], true, "a", DateTime.Today, -125, .37F, new byte[100], -1, (decimal)1.27, "b", "charly",
                "delta", 0.39F, Guid.NewGuid(), DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                ref inOutParamUpdatedBy, "Test Manifest", ref outParamBigInt, ref outParamBinary, ref outParamBit,
                ref outParamChar, ref outParamDateTime, ref outParamDecimal, ref outParamFloat, ref outParamInt,
                ref outParamMoney, ref outParamNChar, ref outParamNVarChar, ref outParamReal, ref outParamUniqueIdentifier,
                ref outParamSmallDateTime, ref outParamSmallInt, ref outParamSmallMoney, ref outParamTimestamp, ref outParamTinyInt,
                ref outParamVarBinary, ref outParamVarChar, ref outParamXml, ref outParamDate,
                ref outParamTime, ref outParamDateTime2, ref outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNotNull(result, "GetExistingCollectionResultTestVb() collection must not be NULL");
            Assert.AreNotEqual(result.Count, 0, "GetExistingCollectionResultTestVb() collection must not be empty");

            ProcCollectionResult item = result.FirstOrDefault(i => i.ProcCollectionResultId == 3);

            Assert.IsNotNull(item, "GetExistingCollectionResultTestVb() collection does not have required item");
            Assert.AreEqual(item.ResultXml, "<ParamXml3>Param Xml 3</ParamXml3>", "GetExistingCollectionResultTestVb().item.ResultXml value does not match");
            Assert.AreEqual(outParamXml, "<ElementOut>elementOut</ElementOut>", "GetExistingCollectionResultTestVb().item.outParamXml value does not match");
            Assert.AreEqual(inOutParamXml, "<Element>element</Element>", "GetExistingCollectionResultTestVb().item.inOutParamXml value does not match");
        }

        [TestMethod]
        public void sp_ProcCollectionResultMethodFailedTestVb()
        {
            // out params
            long outParamBigInt = default(long); byte[] outParamBinary = null; bool? outParamBit = null; string outParamChar = null;
            DateTime outParamDateTime = DateTime.Now.AddMonths(-1); decimal? outParamDecimal = null; double outParamFloat = default(double);
            int? outParamInt = null; decimal outParamMoney = 3.99M; string outParamNChar = null;
            string outParamNVarChar = null; float? outParamReal = null;
            Guid outParamUniqueIdentifier = Guid.Empty; DateTime? outParamSmallDateTime = null; short outParamSmallInt = 2;
            decimal? outParamSmallMoney = null; byte[] outParamTimestamp = null;
            byte outParamTinyInt = default(byte); byte[] outParamVarBinary = null; string outParamVarChar = null;
            string outParamXml = null; DateTime? outParamDate = null; TimeSpan outParamTime = TimeSpan.MinValue;
            DateTime? outParamDateTime2 = null; DateTimeOffset outParamDateTimeOffset = default(DateTimeOffset);
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

            ICollection<ProcCollectionResult> result = DalApiEvaluatetDB.RunProc.sp_ProcCollectionResultMethod(-1,
                10002L, new byte[10], true, "a", DateTime.Today, -125, .37F, new byte[100], -1, (decimal)1.27, "b", "charly",
                "delta", 0.39F, Guid.NewGuid(), DateTime.Now.AddDays(-1), (short)43, 34525, "echo", (byte?)5, new byte[100], "gamma",
                "<Element>element</Element>", CreateIntBitValuePairTable("TestDataTable"), DateTime.Now, new TimeSpan(12345),
                DateTime.Today, new DateTimeOffset(DateTime.Now), 157, DateTime.Today.AddMinutes(15), "YY",
                ref inOutParamUpdatedBy, "Test Manifest", ref outParamBigInt, ref outParamBinary, ref outParamBit,
                ref outParamChar, ref outParamDateTime, ref outParamDecimal, ref outParamFloat, ref outParamInt,
                ref outParamMoney, ref outParamNChar, ref outParamNVarChar, ref outParamReal, ref outParamUniqueIdentifier,
                ref outParamSmallDateTime, ref outParamSmallInt, ref outParamSmallMoney, ref outParamTimestamp, ref outParamTinyInt,
                ref outParamVarBinary, ref outParamVarChar, ref outParamXml, ref outParamDate,
                ref outParamTime, ref outParamDateTime2, ref outParamDateTimeOffset, ref inOutParamBigInt,
                ref inOutParamBinary, ref inOutParamBit, ref inOutParamChar, ref inOutParamDateTime,
                ref inOutParamDecimal, ref inOutParamFloat, ref inOutParamInt, ref inOutParamMoney,
                ref inOutParamNChar, ref inOutParamNVarChar, ref inOutParamReal, ref inOutParamUniqueIdentifier,
                ref inOutParamSmallDateTime, ref inOutParamSmallInt, ref inOutParamSmallMoney,
                ref inOutParamTinyInt, ref inOutParamVarBinary, ref inOutParamVarChar,
                ref inOutParamXml, ref inOutParamDate, ref inOutParamTime, ref inOutParamDateTime2,
                ref inOutParamDateTimeOffset);

            Assert.IsNotNull(result, "sp_ProcCollectionResultMethodFailedTestVb() collection must not be NULL");
            Assert.AreEqual(result.Count, 0, "sp_ProcCollectionResultMethodFailedTestVb() collection must be empty");
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
