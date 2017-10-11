# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require Blogging::Engine.root.join('db', 'seeds', 'social_page.rb')
require Blogging::Engine.root.join('db', 'seeds', 'widget.rb')
require Blogging::Engine.root.join('db', 'seeds', 'settings.rb')