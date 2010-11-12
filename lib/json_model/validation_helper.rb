module JsonModel
  module ValidationHelper
    def valid?
      self_valid = super
      attr_valid = true

      self.class.attributes.each do |name, info|
        attribute  = send(name)
        attr_valid = attribute.valid? if attribute.respond_to?(:valid?)
      end

      self_valid && attr_valid
    end

    def all_errors
      errors = self.errors.to_hash

      self.class.attributes.keys.each do |name|
        attribute    = send(name)
        if !errors.has_key?(name) && attribute.respond_to?(:errors)
          errors[name] = attribute.errors
        end
      end

      errors
    end
  end
end