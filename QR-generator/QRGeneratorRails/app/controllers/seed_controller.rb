require 'randomstring'
require 'seed'

class SeedController < ApplicationController
	def create
		# create seed string
		seed = Randomstring.generate()

		# create expires_at string
		# invalid after 30s
		time = Time.now() + 1 * 30

		# format date string
		expires_at = time.strftime('%FT%T.%2LZ')

		# render json 
		render :json => { seed: seed, expires_at: expires_at }.to_json 
	end
end
