require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TimeStamp" do
  
  it "should parse date to Integer" do
    TimeStamp.json_load("12/12/2010").should == 1292112000
  end
end
