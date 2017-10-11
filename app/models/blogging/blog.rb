module Blogging
  class Blog < ActiveRecord::Base
    belongs_to :category, :class_name => 'Blogging::Category'
    has_many :comments, :class_name => 'Blogging::Comment'
    belongs_to :user, :class_name => Blogging.user_class.to_s, :foreign_key => 'user_id'
    acts_as_taggable
    mount_uploader :image, ImageUploader
    validates :title, :presence => true
    validates :description, :presence => true
    validates :category_id, :presence => true
    before_save :create_slug

    def create_slug
      if self.new_record? || self.title_changed?
        index = 1
        new_slug = "#{DateTime.now.year}-#{DateTime.now.day}-#{title.strip.downcase.gsub(' ', '-')}"
        while check_for_slug(new_slug).present?
          new_slug = "#{DateTime.now.year}-#{DateTime.now.day}-#{title.strip.downcase.gsub(' ', '-')}-#{index}"
          index += 1
        end
        self.slug = new_slug
        if self.published_at.nil? || self.published_at <= DateTime.now
          self.is_published = true
        end
      end
    end

    def check_for_slug(new_slug)
      Blogging::Blog.find_by_slug(new_slug)
    end

    def self.published_blogs
      where(:is_published => true, :status => true)
    end

    def self.popular
      where(:is_published => true, :status => true).order(:view => :desc).limit(5)
    end

    def self.recent
      where(:is_published => true, :status => true).order(:created_at => :desc).limit(5)
    end

  end
end
