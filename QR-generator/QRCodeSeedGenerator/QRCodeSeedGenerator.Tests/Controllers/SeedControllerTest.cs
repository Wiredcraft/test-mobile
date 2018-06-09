using System;
using System.Text.RegularExpressions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using QRCodeSeedGenerator.Controllers;

namespace QRCodeSeedGenerator.Tests.Controllers
{
	[TestClass]
	public class SeedControllerTest
	{
		[TestMethod]
		public void Get()
		{
			// Arrange
			SeedController controller = new SeedController();

			// Act
			Seed result = controller.Get();

			// Assert
			Assert.IsNotNull(result);
			TestRandomAlphaNumeric(result.seed, 32);
			Assert.AreEqual(result.expires_at.Kind, DateTimeKind.Utc);
			Assert.IsTrue(result.expires_at > DateTime.UtcNow
				&& result.expires_at < DateTime.UtcNow.AddDays(1));
		}

		[TestMethod]
		public void GenerateRandomAlphaNumeric()
		{		
			Assert.AreEqual(SeedController.GenerateRandomAlphaNumeric(0), "");
			SeedController.GenerateRandomAlphaNumeric(5);		
			int length = new Random().Next(500);
			TestRandomAlphaNumeric(SeedController.GenerateRandomAlphaNumeric(length), length);
		}

		public void TestRandomAlphaNumeric(String test, int length)
		{
			StringAssert.Matches(test, new Regex("^[a-z0-9]*$"));
			Assert.AreEqual(test.Length, length);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentOutOfRangeException))]
		public void GenerateRandomAlphaNumericNegativeLength()
		{
			SeedController.GenerateRandomAlphaNumeric(-1);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentOutOfRangeException))]
		public void GenerateRandomAlphaNumericLengthTooLarge()
		{
			SeedController.GenerateRandomAlphaNumeric(1000);
		}
	}
}
