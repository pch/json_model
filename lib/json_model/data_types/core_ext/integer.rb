class Integer
  def self.json_load(value)
    value.nil? || value == "" ? nil : value.to_i
  end

  def self.json_dump(value)
    value.nil? ? nil : value.to_i
  end
end