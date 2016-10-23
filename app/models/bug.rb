class Bug < ActiveRecord::Base

  # Modules
  include Tire::Model::Search
  include Tire::Model::Callbacks

  # Relations
  has_one :state, dependent: :destroy
  accepts_nested_attributes_for :state

  # enums
  enum priority: %w(minor major critical)

  # Validations
  validate :accepted_status, on: :create
  validates :application_token, :status, :priority, presence: true
  validates :number, uniqueness: { scope: :application_token, message: "should be unique with respect to the application" }
  validates :priority, inclusion: { in: priorities.keys,  message: "%{value} is not a valid priority" }


  # Callbacks
  before_save :comment_default_value, :auto_increment_number
  after_commit :flush_cache
  after_create :flush_count_cache

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

  def self.cached_count(app_token)
    Rails.cache.fetch([self.name, app_token ,"count"]) { Bug.where(application_token: app_token).size}
  end

  def self.cached_vesrion(app_token, number)
    Rails.cache.fetch([self.name, app_token , number]) { Bug.find_by(application_token: app_token, number: number) }
  end

  def self.get_map_status_value(key)
    mapped_to = STATUS_VALUES[key]
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

  def status_mapped_value
    STATUS_KEYS[status]
  end

  def state
    State.find_by(bug_id: id)
  end

  # Validation methods
  def accepted_status
    errors.add(:status, "invalid status") if status.nil?
  end

  # Cached methods
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def flush_count_cache
    Rails.cache.delete([self.class.name, application_token ,"count"])
  end

  # Constants
  STATUS_VALUES = {'new' => 0, 'In-progress' =>  1, 'closed' => 2 }
  STATUS_KEYS = {0 => 'new', 1 => 'In-progress', 2 => 'closed' }
end
