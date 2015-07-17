module Rollbar
  module Encoding
    def self.encode(object)
      can_be_encoded = object.is_a?(Symbol) || object.is_a?(String)

      return object unless can_be_encoded

      encoding_class.new(object).encode
    end

    def self.encoding_class
      if String.instance_methods.include?(:encode)
        require 'rollbar/encoding/encoder'
        Encoder
      else
        require 'rollbar/encoding/legacy_encoder'
        LegacyEncoder
      end
    end
  end
end
