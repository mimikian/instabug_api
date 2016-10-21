class Bug < ActiveRecord::Base

  # Modules
  include Tire::Model::Search
  include Tire::Model::Callbacks

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

  # Class methods
  def self.search(params, app_token)
    tire.search(load: true, page: params[:page], per_page: 15) do
      query { string params[:query],  default_operator: "AND" } if params[:query].present?
      filter :term, application_token: app_token
      filter :term, :status => params[:status] unless params[:status].blank?
      filter :term, :priority => params[:priority] unless params[:priority].blank?
      filter :terms, :comment => params[:comment] unless params[:comment].blank?
    end
  end

  # Instance Methods
  # Set default value for a comment
  def comment_default_value
    self.comment ||= ""
  end

  def auto_increment_number
    max_number = Bug.maximum(:number)
    self.number ||= max_number.to_i + 1
  end

end
