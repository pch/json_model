require 'json_model/attributes'
require 'json_model/attribute'
require 'json_model/associations'

require 'json_model/data_types/string'
require 'json_model/data_types/integer'
require 'json_model/data_types/boolean'
require 'json_model/data_types/array'
require 'json_model/data_types/timestamp'
require 'json_model/data_types/bitfield'
#require 'json_model/data_types/'

#
# Base class for JSON models.
#
module JsonModel
  
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
    end
  end
  
  def initialize(attrs = {})
    return unless attrs.is_a?(Hash)
  end
  
  def dump_data
    {}
  end
  
  def json_encode
    ActiveSupport::JSON.encode(dump_data)
  end
  
  module ClassMethods
    
    def create(attrs = {})
      new(attrs)
    end
    
    # Loads serialized object from json string
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
