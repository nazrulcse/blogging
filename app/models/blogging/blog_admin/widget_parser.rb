module Blogging
  module BlogAdmin
    class WidgetParser
      def initialize(page)
        @page = page
      end

      def content
        page_content = @page.content
        widgets = page_content.scan(/{{[^}}]+}}/)
        widgets.each do |widget|
          method_sym = widget.gsub('{{', '').gsub('}}', '')
          if method_sym.present?
            method_sym = method_sym.to_s.gsub('&nbsp;', '')  # remove white space
            widget_output = Blogging::BlogAdmin::Setting.send(method_sym.strip)
            page_content = page_content.gsub(widget, widget_output)
          else
            page_content = ''
          end
        end
        page_content << page_css
      end

      def title
        @page.title
      end

      def page_css
        raw_page_css = @page.page_css
        page_css = ActionView::Base.full_sanitizer.sanitize(raw_page_css)
        "<style> #{page_css} </style>"
      end

    end
  end
end