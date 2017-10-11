module Blogging
  module BlogAdmin
    class Setting < ActiveRecord::Base

      ATTR = {
          :text => 'Text Field',
          :area => 'Text Area',
          :check => 'Checkbox',
          :radio => 'Radio',
          :image => 'Image'
      }

      def self.register_widgets
        Blogging::BlogAdmin::Widget.rb_widget.each do |widget|
          widget_name = widget.name
          begin
            eval("def self.#{widget_name}; #{
                 method = widget_name.to_s
                 Blogging::BlogAdmin::Widget.find_by_name(method.to_s).content
                 }; end")
          rescue SyntaxError => ex
            Rails.logger.error { "#{ex.message} #{ex.backtrace.join("\n")}" }
          rescue Exception => ex
            Rails.logger.error { "#{ex.message} #{ex.backtrace.join("\n")}" }
          end
        end
      end

      def self.method_missing(method_sym, *arguments, &block)
        if method_sym.to_s =~ /^key_(.*)$/
          key = method_sym.to_s.gsub('key_', '')
          key_obj = where(:key => key.to_s).first
          if key_obj.present?
            key_obj.value
          end
        elsif method_sym.to_s =~ /^find_by_(.*)$/
          super
        else
          widget = Blogging::BlogAdmin::Widget.find_by_name(method_sym.to_s)
          if widget.present? && widget.attr_type == 'html'
            return widget.content
          else
            "<span style='color: red;'> Error with #{method_sym} </span>"
          end
        end
      end

    end
  end
end
