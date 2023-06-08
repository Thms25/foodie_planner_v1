class MealDay < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  belongs_to :grocery

  validates :date, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def start_time
    self.date
  end
end
