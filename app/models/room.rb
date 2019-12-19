class Room < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations


  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bedroom, presence: true
  validates :bathroom, presence: true
end
