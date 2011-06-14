class Float
  def self.json_load(value)
    value.nil? || value == "" ? nil : value.to_f
  end

  def self.json_dump(value)
    value.nil? ? nil : value.to_f
  end
end