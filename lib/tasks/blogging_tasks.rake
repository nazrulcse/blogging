require 'blogging'
desc 'Schedule published blog post'
namespace :blogging do
  task :published_blog => :environment do
    puts 'Publishing schedule blog posts'
    unpublished_blogs = Blogging::Blog.where(:is_published => false)
    unpublished_blogs.each do |blog|
      if blog.published_at.nil? || Date.today >= blog.published_at
        puts 'Published blog post'
        blog.update_attributes(:is_published => true, :published_at => DateTime.now)
      end
    end
  end
end
