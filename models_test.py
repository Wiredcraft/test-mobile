from models import User
import unittest

class TestUser(unittest.TestCase):

	def test_init(self):
		u = User(1, 'aaa', 'aaa@aaa.com', '2015-09-05 23:21:00')
		self.assertEqual(u.id, 1)
		self.assertEqual(u.name, 'aaa')
		self.assertEqual(u.email, 'aaa@aaa.com')
		self.assertEqual(u.created_at, '2015-09-05 23:21:00')

	def test_user(self):
		User.signup('aaa', 'aaa@aaa.com', 'aaa', 'aaa')
		user_id = User.login('aaa', 'aaa')
		user = User.get_user(user_id)
		self.assertEqual(user.name, 'aaa')
		self.assertEqual(user.email, 'aaa@aaa.com')

	def test_querybyusername(self):
		id = User.querybyusername('aaa')
		self.assertEqual(id, 1)

	def test_querybyemail(self):
		id = User.querybyemail('aaa@aaa.com')
		self.assertEqual(id, 1)
