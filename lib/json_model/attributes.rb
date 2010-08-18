module JsonModel
  
  module Attributes
    
    module InstanceMethods
      
      def initialize(attrs = {})
        super(attrs)
        load_attributes(attrs)
      end
      
      def dump_data
        attrs = {}
        self.class.attributes.each do |name, info|
          value = send(name)
          attrs[name] = info[:class].json_dump(value) unless value.nil?
        end
        attrs
      end
      
      def update_attributes(attrs)
        load_attributes(attrs)
      end
      
      private
      
        def load_attributes(attrs)
          attrs = symbolize_keys(attrs)
          
          self.class.attributes.each do |attr_name, info|
            next unless attrs.include?(attr_name)
            
            # TODO: make it less lame
            old_value = send(attr_name)
            if !old_value.nil? and old_value.respond_to?(:update_attributes)
              old_value.update_attributes(attrs[attr_name])
            else
              value = info[:class].json_load(attrs[attr_name])
              send("#{attr_name}=", value)
            end

            attrs.delete(attr_name)
          end
          raise StandardError, "undefined attributes: #{attrs.inspect} for #{self.class}" if (attrs.keys - self.class.associations.keys).size > 0
        end
    end
    
    module ClassMethods
      
      def attributes
        @attributes ||= {}
      end
      
      def attribute(name, klass)
        attributes.store(name, {:class => klass})
        
        self.send(:attr_accessor, name)
      end
      
      def json_dump(value)
        value.dump_data
      end
      
      def json_load(value, old_value = nil)
        if old_value.nil?
          new(value)
        else
          old_value.update_attributes(value)
        end
      end
    end
  end
end
