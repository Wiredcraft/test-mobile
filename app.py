from flask import Flask, jsonify, request
from models import User

app = Flask(__name__)

@app.route('/user/<int:id>', methods=['GET'])
def get_user(id):
	user = User.get_user(id)
	return jsonify({'user' : user.__dict__})

@app.route('/user/', methods=['POST'])
def signup():
	name = request.values.get('name')
	email = request.values.get('email')
	username = request.values.get('username')
	password = request.values.get('password')
	id = User.querybyusername(username)
	if id != None:
		return jsonify({'message' : 'username already exists!'})
	id = User.querybyemail(email)
	if id != None:
		return jsonify({'message' : 'email already exists!'})
	User.signup(name, email, username, password)
	return jsonify({'message' : 'success'})

@app.route('/login', methods=['POST'])
def login():
	username = request.values.get('username')
	password = request.values.get('password')
	user_id = User.login(username, password)
	return jsonify({'user_id' : user_id})

if __name__ == '__main__':
	app.run(debug=True)
