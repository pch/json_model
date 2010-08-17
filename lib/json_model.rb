Dir[File.join(File.dirname(__FILE__), 'json_model', 'data_types', 'core_ext', '*.rb')].each do |extension|
  require extension
end

Dir[File.join(File.dirname(__FILE__), 'json_model', 'data_types', '*.rb')].each do |extension|
  require extension
end

require 'active_support'

#
# Base class for JSON models.
#
module JsonModel
  autoload :Attributes,   'json_model/attributes'
  autoload :Attribute,    'json_model/attribute'
  autoload :Associations, 'json_model/associations'
  autoload :Callbacks,    'json_model/callbacks'
  
  module Plugins
    def plugin(mod)
      extend  mod::ClassMethods    if mod.const_defined?(:ClassMethods)
      include mod::InstanceMethods if mod.const_defined?(:InstanceMethods)
    end
  end
  
  def self.included(base)
    base.class_eval do
      extend Plugins
      extend ClassMethods
      
      plugin Attributes
      plugin Associations
      plugin Callbacks
    end
  end
  
  def initialize(attrs = {})
    return unless attrs.is_a?(Hash)
  end
  
  def dump_data
    {}
  end
  
  def to_json
    ActiveSupport::JSON.encode(dump_data)
  end
  
  def persisted?  
    false  
  end
  
  module ClassMethods
    
    def create(attrs = {})
      new(attrs)
    end
    
    # Loads serialized object from json string
    # TODO: better name
    def from_json(json)
      attrs = ActiveSupport::JSON.decode(json)
      new(attrs)
    end
  end
  
  protected

    # Converts key names to symbols
    def symbolize_keys(attrs)
      new_attrs = {}
      attrs.each { |k, v| new_attrs[k.to_sym] = v }
      new_attrs
    end
end