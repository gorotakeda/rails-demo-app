class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :prayer_type
  belongs_to :time_slot
end
