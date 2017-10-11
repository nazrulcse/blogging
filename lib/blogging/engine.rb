require "blogging/engine"
require 'rmagick'
require 'carrierwave'
require 'htmlentities'
require 'nokogiri'
module Blogging
  class Engine < ::Rails::Engine
    isolate_namespace Blogging
    initializer :blogging do
      require 'acts-as-taggable-on'
    end

    config.to_prepare do
      Dir.glob(Blogging::Engine.root + 'app/decorators/lib/blogging/*_decorator*.rb').each do |c|
        require_dependency(c)
      end
    end

  end

end
