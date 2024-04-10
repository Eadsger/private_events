class Event < ApplicationRecord
  validates :title, :description, :date_time, :location, presence: true
  belongs_to :creator, class_name: 'User'
  has_many :rsvps, foreign_key: :attended_event_id
  has_many :attendees, through: :rsvps

  scope :past, -> { where('date_time < ?', Date.today).order(date_time: :desc) }
  scope :future, -> { where('date_time > ?', Date.today).order(:date_time) }
end
