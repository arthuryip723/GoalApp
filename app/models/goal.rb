class Goal < ActiveRecord::Base
  validates :body, :user_id, :category, :status, presence: true
  validates :category, inclusion: %w(public private)
  validates :status, inclusion: %W(complete uncomplete)
  after_initialize do
    self.status ||= "uncomplete"
  end

  belongs_to :user
end
