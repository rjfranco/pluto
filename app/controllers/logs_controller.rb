class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    user = User.where(profile_url: params[:profile_url])
    start_date = Date.parse params[:start_date]
    end_date = Date.parse params[:end_date]
    date_range = (start_date..end_date)
    @logs = Log.where(user: user, date: date_range)
    respond_with(@logs)
  end

  def show
    respond_with(@log)
  end

  def new
    @log = Log.new
    respond_with(@log)
  end

  def edit
  end

  def create
    if current_user
      @log = Log.new(log_params)
      @log.user = current_user
      @log.save
      respond_with(@log)
    end
  end

  def update
    @log.update(log_params)
    respond_with(@log)
  end

  def destroy
    @log.destroy
    respond_with(@log)
  end

  private
    def set_log
      @log = Log.find(params[:id])
    end

    def log_params
      params.require(:log).permit(:time, :date, :remote)
    end
end
