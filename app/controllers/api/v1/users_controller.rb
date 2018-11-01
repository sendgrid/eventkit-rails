require 'permissions'
require 'bcrypt'

class Api::V1::UsersController < ApplicationController
  include ::BCrypt

  # ==========================================================================
  # INDEX
  # ==========================================================================
  # TYPE:    GET
  # PATH:   /users
  # SUMMARY:  Retrieves a list of all the User records.
  #
  def index
    def find_users
      query = params.except(:action, :controller, :offset, :limit, :descending, :sortby)

      if query.keys.count
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

      if params[:descending]
        descending = params[:descending] == 'true' || params[:descending] == '1'
      end

      if params[:sortby]
        ordering = descending ? 'DESC' : 'ASC'
        users = users.order("#{params[:sortby]} #{ordering}")
      elsif descending
        users = users.order('id DESC')
      end

      users = users.limit(params[:limit]) if params[:limit]

      users = users.offset(params[:offset]) if params[:offset]

      render json: {
        users: users.as_json(except: %i[password token_expires]),
        meta: {
          total: User.where(query).count
        }
      }
    end

    if User.count == 0
      find_users
    else
      user_has_permissions(Permissions::EDIT) do
        find_users
      end
    end
  end

  # ==========================================================================
  # CREATE
  # ==========================================================================
  # TYPE:   POST
  # PATH:   /users
  # SUMMARY:   Creates a new User record with the given parameters.
  #
  def create
    def new_user
      properties = user_params(params)

      if properties[:password]
        properties[:password] = Password.create(properties[:password])
      end

      if User.count == 0
        properties[:permissions] = Permissions::VIEW | Permissions::EDIT | Permissions::DOWNLOAD | Permissions::POST
      end
      if properties[:username]
        check_for_duplicate_username(properties[:username], nil) do
          record = User.create(properties)
          record.issue_token
          record.save
          render json: record
        end
      end
    end

    if User.count == 0
      new_user
    else
      user_has_permissions(Permissions::EDIT) do
        new_user
      end
    end
  end

  # ==========================================================================
  # SHOW
  # ==========================================================================
  # TYPE:   GET
  # PATH:   /users/:id
  # SUMMARY:   Retrieves a specific User record.
  #
  def show
    user_has_permissions(Permissions::EDIT) do
      if User.where(id: params[:id]).present?
        user = User.find(params[:id])
        render json: user
      else
        render json: {
          message: :error,
          error: "User record with ID #{params[:id]} not found."
        }, status: 404
      end
    end
  end

  # ==========================================================================
  # UPDATE
  # ==========================================================================
  # TYPE:   PUT
  # PATH:   /users/:id
  # SUMMARY:   Updates a specific User record with given parameters.
  #
  def update
    user_has_permissions(Permissions::EDIT) do
      id = params[:id].to_i
      if User.where(id: id).present?
        user = User.find(id)

        properties = user_params(params)

        if properties[:password]
          properties[:password] = Password.create(properties[:password])
        end

        if properties[:username]
          check_for_duplicate_username(properties[:username], id) do
            user.update(properties)
            render json: user
          end
        end
      else
        render json: {
          message: :error,
          error: "User record with ID #{params[:id]} not found."
        }, status: 404
      end
    end
  end

  def check_for_duplicate_username(username, id, &block)
    if User.where(username: username).present?
      user = User.where(username: username).first
      if user.id == id
        yield if block
      else
        render json: {
          message: :error,
          error: "A user with username \"#{username}\" already exists."
        }, status: 409
      end
    elsif block
      yield
    end
  end

  # ==========================================================================
  # DESTROY
  # ==========================================================================
  # TYPE:   DELETE
  # PATH:   /users/:id
  # SUMMARY:   Destroys a specific User record.
  #
  def destroy
    user_has_permissions(Permissions::EDIT) do
      id = params[:id]
      if User.where(id: id).present?
        user = User.find(id)
        user.destroy
        render json: {}
      else
        render json: {
          message: :error,
          error: "User record with ID #{params[:id]} not found."
        }, status: 404
      end
    end
  end

  private

  def user_params(params)
    params.require(:user).permit(:username, :password, :permissions)
  end
end
