module Blogging
  class Category < ActiveRecord::Base
    has_many :blogs, :class_name => 'Blogging::Blog'

    def published_blogs
      blogs.where(:is_published => true, :status => true)
    end
  end
end
