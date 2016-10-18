class Bug < ActiveRecord::Base

  auto_increment :number

  # Enums
  enum status: %w(recent In-progress closed)
  enum priority: %w(minor major critical)

  # Validations
  validates :number, uniqueness: { scope: :application_token, message: "should be unique with respect to the application" }
  validates :status, inclusion: { in: statuses.keys,  message: "%{value} is not a valid status" }
  validates :priority, inclusion: { in: priorities.keys,  message: "%{value} is not a valid priority" }

  # Callbacks
  before_save :comment_default_value
  
  # Instance Methods

  # Set default value for comment
  def comment_default_value
    self.comment ||= ""
  end

end
