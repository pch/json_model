class TimeStamp
  
  def self.json_load(value)    
    value.to_i
  end
  
  def self.json_dump(value)
    value.to_i
  end
end