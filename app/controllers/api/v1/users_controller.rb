require 'permissions'
require 'bcrypt'

class Api::V1::UsersController < ApplicationController

	include ::BCrypt

	# ==========================================================================
	# INDEX
	# ==========================================================================
	# TYPE:  	GET
	# PATH: 	/users
	# SUMMARY:  Retrieves a list of all the User records.
	#
	def index
		query = params.except(:action, :controller, :offset, :limit, :descending, :sortby)

		if query.keys.count then
			# LOOK FOR SPECIFIC RECORDS
			users = User.where(query)
		else
			# RETRIEVE ALL RECORDS
			users = []
			User.find_each do |record|
				users << record
			end
		end

		descending = false

		if params[:descending] then
			descending = params[:descending] == 'true' || params[:descending] == '1'
		end

		if params[:sortby] then
			ordering = descending ? 'DESC' : 'ASC'
			users = users.order("#{params[:sortby]} #{ordering}")
		elsif descending then
			users = users.order("id DESC")
		end

		if params[:limit] then
			users = users.limit(params[:limit])
		end

		if params[:offset] then
			users = users.offset(params[:offset])
		end

		render json: {
			:users => users,
			:meta => {
				:total => User.where(query).count
			}
		}
	end

	# ==========================================================================
	# CREATE
	# ==========================================================================
	# TYPE: 	POST
	# PATH: 	/users
	# SUMMARY: 	Creates a new User record with the given parameters.
	#
	def create
		properties = user_params(params)

		if properties[:password]
			properties[:password] = Password.create(properties[:password])
		end

		if User.count == 0
			properties[:permissions] = Permissions::VIEW | Permissions::EDIT | Permissions::DOWNLOAD | Permissions::POST
		end
		record = User.create(properties)
		record.issue_token
		record.save
		render json: record
	end
	
	# ==========================================================================
	# SHOW
	# ==========================================================================
	# TYPE: 	GET
	# PATH: 	/users/:id
	# SUMMARY: 	Retrieves a specific User record.
	#
	def show
		if User.where(id: params[:id]).present? then
			user = User.find(params[:id])
			render json: user
		else
			render json: {
				:message => :error,
				:error => "User record with ID #{params[:id]} not found."
			}, :status => 404
		end
	end
	
	# ==========================================================================
 	# UPDATE
 	# ==========================================================================
 	# TYPE: 	PUT
 	# PATH: 	/users/:id
 	# SUMMARY: 	Updates a specific User record with given parameters.
 	#
 	def update
 		id = params[:id]
		if User.where(id: id).present? then
			user = User.find(id)
			user.update(user_params(params))
			render json: user
		else
			render json: {
				:message => :error,
				:error => "User record with ID #{params[:id]} not found."
			}, :status => 404
		end
 	end

 	# ==========================================================================
 	# DESTROY
 	# ==========================================================================
 	# TYPE: 	DELETE
 	# PATH: 	/users/:id
 	# SUMMARY: 	Destroys a specific User record.
 	#
	def destroy
		id = params[:id]
		if User.where(id: id).present? then
			user = User.find(id)
			user.destroy
			render json: {}
		else
			render json: {
				:message => :error,
				:error => "User record with ID #{params[:id]} not found."
			}, :status => 404
		end
	end

	private
	def user_params(params)
		params.require(:user).permit(:username, :password)
	end
end
