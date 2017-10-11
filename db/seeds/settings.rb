Blogging::BlogAdmin::Setting.find_or_create_by(:key => 'site_name', :value => 'My Site', :attr => 'text')
Blogging::BlogAdmin::Setting.find_or_create_by(:key => 'site_title', :value => 'My Blog', :attr => 'text')
Blogging::BlogAdmin::Setting.find_or_create_by(:key => 'site_url', :value => 'http://www.example.com', :attr => 'text')