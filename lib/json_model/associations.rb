require 'active_support/inflector'

module JsonModel
  module Associations
    def initialize(attrs = {})
      super(attrs)

      attrs = symbolize_keys(attrs)

      self.class.associations.each do |a, info|
        send("#{a}=", [])
        next if !attrs.include?(a)

        if info[:class].nil?
          klass = eval(ActiveSupport::Inflector.classify(a))
          #klass = ActiveSupport::Inflector.constantize(klass)
        else
          klass = info[:class]
        end

        attrs[a].each do |assoc|
          if assoc.is_a?(Array)
            assoc = assoc[1]
          end

          attrib = send(a)
          attrib.push(klass.new(assoc))
        end
      end
    end

    # Converts the current object to a hash with attribute names as keys
    # and the values of the attributes as values
    #
    def as_json
      attrs = super
      self.class.associations.each do |name, info|
        attrs[name] = []

        arr = send(name)
        next if arr.nil?

        arr.each do |object|
          attrs[name].push(object.as_json) unless object.nil?
        end
      end
      attrs
    end

    module ClassMethods
      def associations
        @associations ||= {}
      end

      def has_many(association, params = {})
        associations.store(association, params)
        self.send(:attr_accessor, association)
      end
    end
  end
end