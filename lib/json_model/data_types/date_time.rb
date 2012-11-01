class DateTime
  def self.json_load(value)
    return value if value.nil?

    if value.to_s.match(/\d{4}-\d{2}-\d{2}/) # TODO
      value = DateTime.parse(value)
    end
    value
  end

  def self.json_dump(value)
    value.to_s
  end
end
