require 'rails/generators'
module Blogging
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../install/templates', __FILE__)

    class_option 'user_class', :type => :string
    class_option 'no_migrate', :type => :boolean

    def install_migrations
      puts 'Copying over Blogging migrations...'
      Dir.chdir(Rails.root) do
        `rake blogging:install:migrations`
      end
    end

    def determine_user_class
      @user_class = options['user_class'].presence ||
          ask('What is your user class called? [User]').presence || 'User'
    end

    def add_blogging_initializer
      path = "#{Rails.root}/config/initializers/blogging.rb"
      if File.exists?(path)
        puts 'Skipping config/initializers/blogging.rb creation, as file already exists!'
      else
        puts 'Adding blogging initializer (config/initializers/blogging.rb)...'
        template 'initializer.rb', path
      end
    end

    def add_blogging_schedule
      path = "#{Rails.root}/config/schedule.rb"
      if File.exists?(path)
        puts 'Skipping config/schedule.rb creation, as file already exists!'
      else
        puts 'Adding blogging initializer (config/schedule.rb)...'
        template 'schedule.rb', path
      end
    end

    def run_migrations
      puts 'Running rake db:migrate'
      `rake db:migrate`
    end

    def seed_database
      puts 'Creating default widget and settings'
      Blogging::Engine.load_seed
    end

    def mount_engine
      puts "Mounting Blogging::Engine at \"/blogs\" in config/routes.rb..."
      insert_into_file("#{Rails.root}/config/routes.rb", :after => /routes.draw.do\n/) do
        %Q{
          # This line mounts Blogging's routes at /blogs by default.
          # This means, any requests to the /blogs URL of your application will go to Blogging::WelcomeController#index.
          # If you would like to change where this extension is mounted, simply change the :at option to something different.
          #
          # We ask that you don't use the :as option here, as Blogging relies on it being the default of "blog"
          mount Blogging::Engine, :at => '/blogs'
        }
      end
    end

    def user_class
      @user_class
    end

  end
end
