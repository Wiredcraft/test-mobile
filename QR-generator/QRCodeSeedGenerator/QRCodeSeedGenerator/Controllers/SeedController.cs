using System;
using System.Linq;
using System.Web.Http;

namespace QRCodeSeedGenerator.Controllers
{
	/// <summary>
	/// Seed object containing two properties:
	///		seed - String
	///		expires_at - DateTime
	/// </summary>
	public class Seed
	{
		public String seed; //example: 37790a1b728096b4141864f49159ad47
		public DateTime expires_at; //ISO date-time. example: 1985-04-12T23:20:50.52Z
	}

	/// <summary>
	/// Controller specifying a single path:
	///		GET /api/seed 
	///	response:
	///		'200' - seed issued
	///		content - Seed Object
	///			seed - random alphanumeric length 32 string
	///			expires_at - UTC Datetime for 30 minutes from now
	/// </summary>
	public class SeedController : ApiController
	{
		// GET api/seed
		public Seed Get()
		{
			return new Seed
			{
				seed = GenerateRandomAlphaNumeric(32),
				expires_at = DateTime.UtcNow.AddMinutes(30)
			};
		}

		//generates a random alphanumeric string of length 0-500
		public static string GenerateRandomAlphaNumeric(int length)
		{
			if (length < 0 || length > 500) throw new ArgumentOutOfRangeException(nameof(length));
			var chars = "abcdefghijklmnopqrstuvwxyz0123456789";
			Random random = new Random();
			return new string(Enumerable.Repeat(chars, length).Select(s => s[random.Next(s.Length)]).ToArray());
		}
	}
}
