class Log < ActiveRecord::Base
  belongs_to :user

  validates :date, presence: true
  validates :time, presence: true
  validates :remote, presence: true
end
