class Person
  include JsonModel
  
  attribute :name, String
  attribute :id, Integer
  
  has_many :cars
  
end


class Car
  include JsonModel
  
  attribute :make, String
  attribute :model, String
  attribute :bough_on, TimeStamp
end