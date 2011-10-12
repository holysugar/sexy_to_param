require 'active_record'
require 'uri'

module SexyToParam

  module ClassMethods
    def sexy_to_param(column = :slug)
      define_method(:to_param) {
        if id
          slug = send(column)
          if slug.present?
            "%s-%s" % [id ,SexyToParam.escape(slug)]
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

