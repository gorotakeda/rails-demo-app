class TimeSlot < ApplicationRecord
  has_many :reservations

  def formatted_time
    start_time.strftime('%H:%M')
  end
end
