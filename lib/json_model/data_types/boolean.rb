class Boolean
  
  MAPPING = {
    '1'     => true,
    'true'  => true,
    '0'     => false,
    'false' => false
  }
  
  def self.json_load(value)
    value
  end
  
  def self.json_dump(value)
    return value if MAPPING[value].nil?
    MAPPING[value]
  end
end