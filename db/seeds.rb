# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# 御祈祷の種類
prayer_types = [
  { name: '七五三', description: '七五三のお祝い', price: 5000 },
  { name: '安産祈願', description: '安産のご祈祷', price: 7000 },
  { name: '交通安全', description: '交通安全のご祈祷', price: 5000 },
  { name: '学業成就', description: '学業成就のご祈祷', price: 5000 }
]

prayer_types.each do |prayer|
  PrayerType.find_or_create_by!(name: prayer[:name]) do |pt|
    pt.attributes = prayer
  end
end

# 予約枠
(9..16).each do |hour|
  TimeSlot.find_or_create_by!(
    start_time: "#{hour}:00",
    capacity: 2
  )
  
  TimeSlot.find_or_create_by!(
    start_time: "#{hour}:30",
    capacity: 2
  )
end