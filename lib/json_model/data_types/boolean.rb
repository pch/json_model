class Boolean
  
  MAPPING = {
    '1'     => true,
    'true'  => true,
    '0'     => false,
    'false' => false
  }
  
  def self.json_load(value)
    return value if MAPPING[value].nil?
    MAPPING[value]
  end
  
  def self.json_dump(value)
    value
  end
end