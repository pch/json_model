require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Attributes" do
  it "should load an array" do
    Array.json_load([1,2,3, "four"]).should eql([1,2,3,"four"])
  end
  
  it "should dump an array" do
    Array.json_dump([1,2,3, "four"]).should eql([1,2,3,"four"])
  end
  
  it "should load an integer" do
    Integer.json_load("1").should eql(1)
  end
  
  it "should dump an integer" do
    Integer.json_dump(1).should eql(1)
  end
  
  it "should load a string" do
    String.json_load("John").should eql("John")
  end
  
  it "should dump a stringr" do
    String.json_dump("John").should eql("John")
  end
  
  it "should create new object with a string attribute" do
    person = Person.new(:name => "Joe")
    person.name.should eql("Joe")
  end
  
  it "should create new object with a integer attribute" do
    person = Person.new(:id => 1)
    person.id.should eql(1)
  end
  
  it "should load attributes if hash keys are strings" do
    person = Person.new("id" => 1, "name" => "John Doe")
    person.id.should   == 1
    person.name.should == "John Doe"
  end
  
  it "should allow for JsonModel classes as attributes" do
    person = Person.new(:id => 1, :address => {:street => '5th Ave', :postal_code => '00-000'})
    person.address.should be_an_instance_of(Address)
    person.address.street.should      == '5th Ave'
    person.address.postal_code.should == '00-000'
  end
  
  it "should raise an error when there is no matching attribute defined" do
    lambda {
      person = Person.new(:asd => 1)
    }.should raise_error(StandardError)
  end
  
  it "should update given attributes" do
    person = Person.new(:id => 1, :name => "John Doe")
    person.update_attributes(:name => "Frank McDonald")
    
    person.id.should   == 1
    person.name.should == "Frank McDonald"
  end
  
  it "should update given attributes, including other JsonModel attributes" do
    person = Person.new(:name => "John Doe", :address => {:street => '5th Ave', :postal_code => '00-000'})
    person.update_attributes(:name => "Johnny Doe", :address => {:street => '7th Ave'})
    
    person.name.should == "Johnny Doe"
    person.address.street.should      == "7th Ave"
    person.address.postal_code.should == "00-000"
  end
end