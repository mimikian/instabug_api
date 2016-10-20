class Bug < ActiveRecord::Base

  # Relations
  has_one :state, dependent: :destroy
  accepts_nested_attributes_for :state

  # Enums
  enum status: %w(recent In-progress closed)
  enum priority: %w(minor major critical)

  # Validations
  validates :application_token, :status, :priority, presence: true
  validates :number, uniqueness: { scope: :application_token, message: "should be unique with respect to the application" }
  validates :status, inclusion: { in: statuses.keys,  message: "%{value} is not a valid status" }
  validates :priority, inclusion: { in: priorities.keys,  message: "%{value} is not a valid priority" }

  # Callbacks
  before_save :comment_default_value, :auto_increment_number

  # Instance Methods

  # Set default value for comment
  def comment_default_value
    self.comment ||= ""
  end

  def auto_increment_number
    max_number = Bug.maximum(:number)
    self.number ||= max_number.to_i + 1
  end

end
