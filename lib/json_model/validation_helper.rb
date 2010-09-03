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
  end
end