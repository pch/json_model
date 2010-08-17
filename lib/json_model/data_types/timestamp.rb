class TimeStamp
  
  def self.json_load(value)
    if value.to_s.match(/\d{2}\/\d{2}\/\d{4}/) # TODO
      value = DateTime.parse(value)
    end    
    value.to_i
  end
  
  def self.json_dump(value)
    value.to_i
  end
end
