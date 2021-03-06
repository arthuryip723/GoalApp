class Goal < ActiveRecord::Base
  validates :body, :user, :category, :status, presence: true
  validates :category, inclusion: %w(public private)
  validates :status, inclusion: %W(complete uncomplete)
  after_initialize do
    self.status ||= "uncomplete"
  end

  belongs_to :user
  has_many :comments, as: :commentable
  has_many :cheers
end
