class Car
  include JsonModel
  
  attribute :make,  String
  attribute :model, String
  attribute :color, String
  attribute :bought_on, TimeStamp
end

class Address
  include JsonModel
  
  attribute :street, String
  attribute :postal_code, String
end

class Person
  include JsonModel
  include JsonModel::ValidationHelper
  
  attribute :name, String
  attribute :id, Integer
  attribute :address, Address
  
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
