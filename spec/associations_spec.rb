require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Associations" do
  
  it "should create new object with association and assigned attrs" do
    person = Person.new :cars => [{'make' => 2010}]
    person.cars.size.should eql(1)
    person.cars[0].make.should eql('2010')
  end
  
  it "should allow for association names different than the class name" do
    person = Person.new(:red_cars => [{:make => 'Subaru'}])
    person.red_cars.size.should    == 1
    person.red_cars[0].should be_an_instance_of(Car)
    person.red_cars[0].make.should == "Subaru"
  end
  
  it "should load associations list when it's provided as a Hash" do
    person = Person.new('cars' => {'0' => {'make' => 'Audi', 'model' => 'A3'}})
    person.cars.size.should     == 1
    person.cars[0].make.should  == 'Audi'
    person.cars[0].model.should == 'A3'
  end

  it "should raise an error when there is no matching association defined" do
    lambda {
      person = Person.new :carss => [{'make' => 1}]
    }.should raise_error(StandardError)
  end

  it "should raise an error when there is no matching association's attribute" do
    lambda {
      person = Person.new :cars => [{'makes' => 1}]
    }.should raise_error(StandardError)
  end
  
  #it "should update associations"
end