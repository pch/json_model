module JsonModel
  module Callbacks
    def to_json
      result = true
      self.class.before_dump_callbacks.each do |method|
        result = send(method)
      end

      if result === false
        false
      else
        super
      end
    end
    
    module ClassMethods
      def from_json(json)
        obj = super(json)
        
        after_load_callbacks.each do |method|
          obj.send(method)
        end
        
        obj
      end
      
      def before_dump(callback)
        before_dump_callbacks.push(callback.to_sym)
      end
      
      def after_load(callback)
        after_load_callbacks.push(callback.to_sym)
      end
      
      def before_dump_callbacks
        @before_dump_callbacks ||= []
      end
      
      def after_load_callbacks
        @after_dump_callbacks ||= []
      end
    end
  end
end