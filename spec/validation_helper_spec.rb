require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "JsonModel::ValidationHelper" do
  
  it "should respond to valid?" do
    person = Person.create(:id => 1, :name => "John Doe")
    person.respond_to?(:valid?).should be_true
  end
end
