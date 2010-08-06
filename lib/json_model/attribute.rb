module JsonModel
  
  class Attribute
    
    attr_accessor :name, :klass
    
    def initialize(name, klass)
      @name  = name
      @klass = klass
    end
    
    
  end
end