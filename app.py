from flask import Flask, jsonify, request
from models import User

# create server object
app = Flask(__name__)

# get user by id, return the user info
@app.route('/user/<int:id>', methods=['GET'])
def get_user(id):
	user = User.get_user(id)
	return jsonify({'user' : user.__dict__})

# create a user, return message error or success
@app.route('/user/', methods=['POST'])
def signup():
	# receive post parmas
	name = request.values.get('name')
	email = request.values.get('email')
	username = request.values.get('username')
	password = request.values.get('password')

	# check whether username already exists
	id = User.querybyusername(username)
	if id != None:
		return jsonify({'message' : 'username already exists!'})

	# check whether email already exists
	id = User.querybyemail(email)
	if id != None:
		return jsonify({'message' : 'email already exists!'})

	User.signup(name, email, username, password)
	return jsonify({'message' : 'success'})

# check whether login success, return user_id
@app.route('/login', methods=['POST'])
def login():
	# receive post params
	username = request.values.get('username')
	password = request.values.get('password')

	user_id = User.login(username, password)
	return jsonify({'user_id' : user_id})

# start the server
if __name__ == '__main__':
	app.run(debug=True)
