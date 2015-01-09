class Log < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :date, presence: true
  validates :time, presence: true
end
