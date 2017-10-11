module Blogging
  class NewsLetter < ActiveRecord::Base
    validates :email, :presence => true
    validates_format_of :email, :with => Devise::email_regexp
    validates_uniqueness_of :email
  end
end
