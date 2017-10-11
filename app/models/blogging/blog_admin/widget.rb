module Blogging
  module BlogAdmin
    class Widget < ActiveRecord::Base
      validates :name, :presence => true
      validates_format_of :name, :with => /\A([^@\s]+)\Z/i, :message => 'Invalid widget name'

      def self.rb_widget
        where(:attr_type => 'rb')
      end

    end
  end
end
