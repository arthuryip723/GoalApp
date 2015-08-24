class Cheer < ActiveRecord::Base
  validates :user, :goal, presence: true
  # validates_uniqueness_of :user_id, :scope => :goal_id
  validates :user_id, uniqueness: {scope: :goal_id}
  validate :maximum_cheers

  MAXIMUM_CHEERS = 10
  belongs_to :user
  belongs_to :goal

  private
  def maximum_cheers
    if user.cheers.count > MAXIMUM_CHEERS - 1
      errors.add(:maximum_cheers, "can't cheer over 10 times")
    end
  end
end
