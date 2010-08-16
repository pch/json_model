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
      
      before_dump :scientologist_filter
      after_load  :add_nobiliary_particle
      
      def scientolofist_filter
        # One of the main principles of the Church of Scientology
        # states that its members cannot be dumped to JSON
        false if self.name == "Tom Cruise"
      end
      
      def add_nobliary_particle
        self.name = self.name.gsub(" ", " von ")
      end
    end
    
    person = Person.new(:id => 1, :address => {:street => '5th Ave', :postal_code => '00-000'})
    person.to_json

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
