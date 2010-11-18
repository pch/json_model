class TimeStamp
  def self.json_load(value)
    return value if value.nil?

    if value.to_s.match(/\d{4}-\d{2}-\d{2}/) # TODO
      value = DateTime.parse(value)
    end
    value.to_i
  end

  def self.json_dump(value)
    value.nil? ? nil : value.to_i
  end
end
