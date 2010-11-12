class Car
  include JsonModel

  attribute :make,  String
  attribute :model, String
  attribute :color, String
  attribute :bought_on, TimeStamp
end

class Address
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  include JsonModel

  attribute :street, String
  attribute :postal_code, String
end

class Person
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  include JsonModel
  include JsonModel::ValidationHelper

  attribute :name, String, :default => "Henry Johnson"
  attribute :id, Integer
  attribute :address, Address, :default => Address.new

  has_many :cars
  has_many :red_cars, :class => Car

  before_dump :before_callback
  before_dump :scientologist_filter

  after_load  :after_callback

  def before_callback
    "before"
  end

  def scientologist_filter
    false if self.name == "Tom Cruise"
  end

  def after_callback
    self.name = self.name.gsub(" ", " von ") if self.name == "John Johnson"
  end
end
