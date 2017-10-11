module Blogging
  module BlogAdmin
  module SettingsHelper
    def attr_field(obj, type, klass = '')
      case type
        when 'text'
          obj.text_field :value, :class => klass
        when 'area'
          obj.text_area :value, :class => klass
        when 'check'
          obj.check_box :value, :class => klass
        when 'radio'
          obj.radio :value, :class => klass
        when 'image'
          obj.file_field :value, :class => klass
        else
          obj.text_field :value, :class => klass
      end
    end
end
  end
end
