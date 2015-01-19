require 'ostruct'

class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @logs = get_logs_with_params
    respond_with(@logs.sort_by)
  end

  def export
    @logs = merge_logs_by_date get_logs_with_params
    render xlsx: 'logs', template: 'logs/export'
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

    def get_logs_with_params
      user = User.where(profile_url: params[:profile_url])
      start_date = Date.parse params[:start_date]
      end_date = Date.parse params[:end_date]
      date_range = (start_date..end_date)
      Log.where(user: user, date: date_range).order(date: :desc)
    end

    def merge_logs_by_date(logs)
      merged_logs = []

      logs.group_by(&:date).each do |date, logs|
        onsite_count = 0
        offsite_count = 0

        logs.each do |log|
          log.remote ? offsite_count += log.time : onsite_count += log.time
        end

        merged_logs << OpenStruct.new(date: date, onsite_time: onsite_count, offsite_time: offsite_count)
      end

      merged_logs
    end
end
