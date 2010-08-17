require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "JsonModel" do
  
  it "should create a new object via the 'create' method" do
    person = Person.create(:id => 1, :name => "John Doe")
    person.id.should == 1
    person.name.should == "John Doe"
  end
  
  it "should encode objects to JSON" do
    person = Person.new(:id => 1, :name => "John Doe", :address => {:street => '5th Ave'}, :cars => [{ :make => 'Audi', :model => 'A4' }])
    json   = person.to_json
    
    json.should match(/^\{.+\}$/)
    json.should match(/\"name\":\"John Doe\"/)
    json.should match(/\"id\":1/)
    json.should match(/\"address\":\{\"street\":\"5th Ave\"\}/)
    json.should match(/\"cars\":\[\{.+\}\]/)
    json.should match(/\"model\":\"A4\"/)
    json.should match(/\"make\":\"Audi\"/)
    json.should match(/\"red_cars\":\[\]/)
  end
  
  it "should load objects from JSON" do
    person = Person.from_json("{\"cars\":[{\"model\":\"A4\",\"make\":\"Audi\"}],\"name\":\"John Doe\",\"red_cars\":[],\"id\":1}")
    person.id.should == 1
    person.name.should == "John Doe"
    person.cars.should be_an(Array)
    person.cars[0].should be_a(Car)
    person.cars[0].make.should      == 'Audi'
    person.cars[0].model.should     == 'A4'
  end
end
