class TimeStamp
  
  def self.json_load(value)
    if value.match(/\d{2}\/\d{2}\/\d{4}/) # TODO
      value = Time.parse(value)
    end    
    value.to_i
  end
  
  def self.json_dump(value)
    value.to_i
  end
end