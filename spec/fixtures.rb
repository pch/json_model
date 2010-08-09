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
  
  attribute :name, String
  attribute :id, Integer
  attribute :address, Address
  
  has_many :cars
  has_many :red_cars, :class => Car
end
