class Bitfield
  def self.json_load(data)
    return data unless data.is_a?(Hash)
    
    result = 0
    data.each do |key, value|
      value   = value.to_i
      result ^= value if value > 0
    end
    result
  end
  
  def self.json_dump(value)
    value
  end
end