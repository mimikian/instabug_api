class State < ActiveRecord::Base

  # Constants
  MAX = 4294967295

  # Validations
  validates :memory, inclusion: { :in => 0..MAX, message: 'Memory can not be negative or more than the unsigned integer limit'}
  validates :storage, inclusion: { :in => 0..MAX, message: 'Memory can not be negative or more than the unsigned integer limit'}
end
