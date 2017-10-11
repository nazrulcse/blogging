module Blogging
  class ApplicationController < ::ApplicationController
    before_action :register_widgets
    layout Blogging.layout

    private

    def register_widgets
      BlogAdmin::Setting.register_widgets
    end

  end
end
