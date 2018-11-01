class Api::V1::SettingsController < ApplicationController
  # ==========================================================================
  # INDEX
  # ==========================================================================
  # TYPE:    GET
  # PATH:   /settings
  # SUMMARY:  Retrieves a list of all the Setting records.
  #
  def index
    query = params.except(:action, :controller, :offset, :limit, :descending, :sortby)

    if query.keys.count
      # LOOK FOR SPECIFIC RECORDS
      settings = Setting.where(query)
    else
      # RETRIEVE ALL RECORDS
      settings = []
      Setting.find_each do |record|
        settings << record
      end
    end

    descending = false

    if params[:descending]
      descending = params[:descending] == 'true' || params[:descending] == '1'
    end

    if params[:sortby]
      ordering = descending ? 'DESC' : 'ASC'
      settings = settings.order("#{params[:sortby]} #{ordering}")
    elsif descending
      settings = settings.order('id DESC')
    end

    settings = settings.limit(params[:limit]) if params[:limit]

    settings = settings.offset(params[:offset]) if params[:offset]

    render json: {
      settings: settings,
      meta: {
        total: Setting.where(query).count
      }
    }
  end

  # ==========================================================================
  # CREATE
  # ==========================================================================
  # TYPE:   POST
  # PATH:   /settings
  # SUMMARY:   Creates a new Setting record with the given parameters.
  #
  def create
    properties = setting_params(params)
    record = Setting.create(properties)
    render json: record
  end

  # ==========================================================================
  # SHOW
  # ==========================================================================
  # TYPE:   GET
  # PATH:   /settings/:id
  # SUMMARY:   Retrieves a specific Setting record.
  #
  def show
    if Setting.where(id: params[:id]).present?
      setting = Setting.find(params[:id])
      render json: setting
    else
      render json: {
        message: :error,
        error: "Setting record with ID #{params[:id]} not found."
      }, status: 404
    end
  end

  # ==========================================================================
  # UPDATE
  # ==========================================================================
  # TYPE:   PUT
  # PATH:   /settings/:id
  # SUMMARY:   Updates a specific Setting record with given parameters.
  #
  def update
    user_has_permissions(Permissions::EDIT) do
      id = params[:id]
      if Setting.where(id: id).present?
        setting = Setting.find(id)
        setting.update(setting_params(params))
        render json: setting
      else
        render json: {
          message: :error,
          error: "Setting record with ID #{params[:id]} not found."
        }, status: 404
      end
    end
  end

  # ==========================================================================
  # DESTROY
  # ==========================================================================
  # TYPE:   DELETE
  # PATH:   /settings/:id
  # SUMMARY:   Destroys a specific Setting record.
  #
  def destroy
    user_has_permissions(Permissions::EDIT) do
      id = params[:id]
      if Setting.where(id: id).present?
        setting = Setting.find(id)
        setting.destroy
        render json: {}
      else
        render json: {
          message: :error,
          error: "Setting record with ID #{params[:id]} not found."
        }, status: 404
      end
    end
  end

  private

  def setting_params(params)
    params.require(:setting).permit(:name, :value)
  end
end
