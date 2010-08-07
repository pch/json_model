require File.dirname(__FILE__) + '/spec_helper'

describe "Attributes" do
  it "should load an array" do
    Array.json_load([1,2,3, "four"]).should eql([1,2,3,"four"])
  end
  
  it "should dump an array" do
    Array.json_dump([1,2,3, "four"]).should eql([1,2,3,"four"])
  end
  
  it "should load an integer" do
    Integer.json_load(1).should eql(1)
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
  
  it "should raise an error when there is no matching attribute defined" do
    lambda {
      person = Person.new(:asd => 1)
    }.should raise_error(StandardError)
  end

  it "should create new object with association and assigned attrs" do
    person = Person.new :cars => [{'make' => 2010}]
    person.cars.size.should eql(1)
    person.cars[0].make.should eql('2010')
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
end