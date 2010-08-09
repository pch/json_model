JSON Model for Rails
====

ActiveRecord replacement for pure JSON models.

How to use it
-------------

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
    
    person = Person.new(:id => 1, :address => {:street => '5th Ave', :postal_code => '00-000'})
    person.json_encode

### Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

### Copyright

Copyright (c) 2010 Piotr Chmolowski. See LICENSE for details.
