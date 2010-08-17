require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Callbacks" do
  
  it "should call the :before_callback before dumping an object to json" do
    person = Person.new(:id => 1, :name => "John Doe")
    
    person.should_receive(:before_callback).and_return("before")
    person.to_json.should match(/^\{.*\}$/)
  end
  
  it "should call the :after_callback after loading an object from json" do
    person = Person.from_json("{\"red_cars\":[],\"name\":\"John Johnson\",\"id\":1,\"cars\":[]}")
    person.name.should == 'John von Johnson'
  end
  
  it "should fail dumping an object to json if the :before_callback returns false" do
    person = Person.new(:id => 1, :name => "Tom Cruise")
    person.to_json.should be_false
  end
end
