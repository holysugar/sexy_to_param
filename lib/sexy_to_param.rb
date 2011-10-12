require 'active_record'
require 'uri'

module SexyToParam

  module ClassMethods
    def sexy_to_param(column = :slug)
      define_method(:to_param) {
        if id
          slug = send(column)
          if slug.present?
            param_string = SexyToParam.escape(send(column))
            "#{id}-#{param_string}"
          else
            id.to_s
          end
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

