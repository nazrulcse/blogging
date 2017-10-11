require "blogging/engine"
require 'active_support/core_ext/kernel/singleton_class'

module Blogging
  mattr_accessor :blog_logo, :blog_email, :user_name_field,
                 :user_photo_field, :layout, :user_class,
                 :per_page
  class << self
    def decorate_user_class!
      class_user = Blogging.user_class.classify.safe_constantize
      class_user.class_eval do
        has_many :blogs, :class_name => 'Blogging::Blog', :foreign_key => 'user_id'
        has_many :comments, :class_name => 'Blogging::Comment', :foreign_key => 'user_id'
      end
    end
  end

end
