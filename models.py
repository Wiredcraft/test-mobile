from datetime import datetime
import sqlite3

def get_conn():
	return sqlite3.connect('test.db')

class User(object):

	def __init__(self, id, name, email, created_at):
		self.id = id
		self.name = name
		self.email = email
		self.created_at = created_at

	@staticmethod
	def signup(name, email, username, password):
		conn = get_conn()
		cur = conn.cursor()
		sql = 'insert into user_info (name, email, created_at) values (?, ?, ?)'
		cur.execute(sql, (name, email, datetime.now().strftime('%Y-%m-%d %H:%M:%S')))
		sql = 'insert into user_auth (username, password, user_id) values (?, ?, ?)'
		cur.execute(sql, (username, password, cur.lastrowid))
		cur.close()
		conn.commit()
		conn.close()

	@staticmethod
	def login(username, password):
		conn = get_conn()
		cur = conn.cursor()
		sql = 'select user_id from user_auth where username=? and password=?'
		rows = cur.execute(sql, (username, password))
		user_id = None
		for row in rows:
			user_id = row[0]
		cur.close()
		conn.close()
		return user_id

	@staticmethod
	def get_user(user_id):
		conn = get_conn()
		cur = conn.cursor()
		sql = 'select name, email, created_at from user_info where id=?'
		rows = cur.execute(sql, str(user_id))
		user = None
		for row in rows:
			user = User(user_id, row[0], row[1], row[2])
		cur.close()
		conn.close()
		return user

	@staticmethod
	def querybyusername(username):
		conn = get_conn()
		cur = conn.cursor()
		sql = 'select id from user_auth where username=?'
		rows = cur.execute(sql, [username])
		id = None
		for row in rows:
			id = row[0]
		cur.close()
		conn.close()
		return id

	@staticmethod
	def querybyemail(email):
		conn = get_conn()
		cur = conn.cursor()
		sql = 'select id from user_info where email=?'
		rows = cur.execute(sql, [email])
		id = None
		for row in rows:
			id = row[0]
		cur.close()
		conn.close()
		return id
