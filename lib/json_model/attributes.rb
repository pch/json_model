module JsonModel
  module Attributes
    def initialize(attrs = {})
      super(attrs)
      load_attributes(attrs)
    end

    # Converts the current object to a hash with attribute names as keys
    # and the values of the attributes as values.
    #
    # The method calls json_dump of each attribute class.
    #
    def as_json
      attrs = {}
      self.class.attributes.each do |name, info|
        value = send(name)
        attrs[name] = info[:class].json_dump(value) unless value.nil?
      end
      attrs
    end

    # Updates existing attributes
    #
    def update_attributes(attrs)
      load_attributes(attrs)
    end

    private

      # Loads attributes from the attrs hash.
      #
      def load_attributes(attrs)
        attrs = symbolize_keys(attrs)

        self.class.attributes.each do |attr_name, info|
          next if !attrs.include?(attr_name) && info[:default].nil?

          current_value = send(attr_name)

          if !current_value.nil? && current_value.respond_to?(:update_attributes) && attrs.include?(attr_name)
            current_value.update_attributes(attrs[attr_name])
          else
            value = attrs.include?(attr_name) ? info[:class].json_load(attrs[attr_name]) : info[:default]
            send("#{attr_name}=", value)
          end

          attrs.delete(attr_name)
        end

        if (attrs.keys - self.class.associations.keys).size > 0
          raise StandardError, "undefined attributes: #{(attrs.keys - self.class.associations.keys).inspect} for #{self.class}"
        end
      end

    module ClassMethods

      def attribute(name, klass, options = {})
        options[:class] = klass
        attributes.store(name, options)
        self.send(:attr_accessor, name)
      end

      def attributes
        @attributes ||= {}
      end

      def json_dump(value)
        value.as_json
      end

      def json_load(value)
        new(value)
      end
    end
  end
end
