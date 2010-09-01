require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TimeStamp" do
  
  it "should parse date to Integer" do
    TimeStamp.json_load("2010-12-12").should == 1292112000
  end
end
