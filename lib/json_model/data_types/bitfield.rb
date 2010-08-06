class Bitfield
  
  def self.json_load(value)
    value
  end
  
  def self.json_dump(data)
    return data unless data.is_a?(Hash)
    
    result = 0
    data.each do |key, value|
      value   = value.to_i
      result ^= value if value > 0
    end
    result
  end
end