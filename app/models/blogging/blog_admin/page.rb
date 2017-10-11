module Blogging
  module BlogAdmin
    class Page < ActiveRecord::Base
      validates :title, :presence => true
      validates :slug, :presence => true, :uniqueness => true
      validates :menu, :presence => true, :uniqueness => true
      validates :content, :presence => true
    end
  end
end
