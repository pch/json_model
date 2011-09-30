module JsonModel
  module ValidationHelper
    def valid?
      self_valid = super
      attr_valid = true

      self.class.attributes.each do |name, info|
        attribute  = send(name)
        attr_valid = attr_valid && attribute.valid? if attribute.respond_to?(:valid?)
      end

      self.class.associations.each do |name, info|
        objects = send(name)
        objects.each do |obj|
          attr_valid = attr_valid && obj.valid? if obj.respond_to?(:valid?)
        end
      end

      self_valid && attr_valid
    end

    def all_errors
      errors = self.errors.to_hash

      self.class.attributes.keys.each do |name|
        attribute    = send(name)
        if !errors.has_key?(name) && attribute.respond_to?(:all_errors)
          errors[name] = attribute.all_errors
        end
      end

      self.class.associations.keys.each do |name|
        assoc_errors = []
        objects      = send(name)

        objects.each do |obj|
          if obj.respond_to?(:all_errors)
            assoc_errors.push(obj.all_errors)
          end
        end

        errors[name] = assoc_errors if assoc_errors.length > 0
      end

      errors
    end
  end
end
