module Blogging
  class Comment < ActiveRecord::Base
    belongs_to :blog, :class_name => 'Blogging::Blog'
    has_many :replies, :class_name => Comment, :foreign_key => 'parent'
    belongs_to :parent_post, :class_name => Comment, :foreign_key => 'parent'
    belongs_to :user, :class_name => Blogging.user_class, :foreign_key => 'user_id'
  end
end
