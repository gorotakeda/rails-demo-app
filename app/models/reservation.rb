class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :prayer_type
  belongs_to :time_slot

  validates :prayer_type_id, presence: true
  validates :reserved_date, presence: true
  validates :time_slot_id, presence: true
  validates :number_of_people, presence: true, 
            numericality: { 
              only_integer: true,
              greater_than: 0
            }
  
  # 3ヶ月先までの予約のみ許可
  validate :reserved_date_within_limit
  # 過去の日付は予約不可
  validate :reserved_date_not_in_past

  private

  def reserved_date_within_limit
    return if reserved_date.blank?
    if reserved_date > Date.current + 3.months
      errors.add(:reserved_date, "は3ヶ月先までしか予約できません")
    end
  end

  def reserved_date_not_in_past
    return if reserved_date.blank?
    if reserved_date < Date.current
      errors.add(:reserved_date, "は過去の日付を選択できません")
    end
  end
end
