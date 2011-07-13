require 'active_record'
require 'uri'

module SexyToParam

  module ClassMethods
    def sexy_to_param(column = :slug)
      define_method(:to_param) {
        if id
          param_string = SexyToParam.escape(send(column))
          "#{id}-#{param_string}"
        end
      }
    end
  end

  class << self
    def escape(slug)
      URI.escape(slug.gsub(/[:@#\/&=\.\s]+/, '-').sub(/\A-/,''))
    end
  end

end

ActiveRecord::Base.extend SexyToParam::ClassMethods

