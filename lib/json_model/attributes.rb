module JsonModel
  
  module Attributes
    
    module InstanceMethods
      
      def initialize(attrs = {})
        super(attrs)
        attrs = symbolize_keys(attrs)
        
        self.class.attributes.each do |k, info|
          next unless attrs.include?(k)
          
          value = info[:class].json_load(attrs[k])
          send("#{k}=", value)
          
          attrs.delete(k)
        end
        
        raise StandardError, "undefined attributes: #{attrs.inspect}" if (attrs.keys - self.class.associations.keys).size > 0
      end
      
      def dump_data
        attrs = {}
        self.class.attributes.each do |name, info|
          value = send(name)
          attrs[name] = info[:class].json_dump(value) unless value.nil?
        end
        attrs
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
      
      def json_load(value)
        new(value)
      end
    end
  end
end
