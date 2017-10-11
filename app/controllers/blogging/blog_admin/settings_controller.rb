require_dependency "blogging/application_controller"

module Blogging
  class BlogAdmin::SettingsController < Blogging::BlogAdmin::DashboardController

    def index
      @setting = Blogging::BlogAdmin::Setting.all.first || Blogging::BlogAdmin::Setting.new
      @social_pages = Blogging::BlogAdmin::SocialPage.all
      @category = Blogging::Category.new
      @categories = Blogging::Category.all
    end

    def new
      @setting = Blogging::BlogAdmin::Setting.new
    end

    def edit
      @setting = Blogging::BlogAdmin::Setting.find_by_id(params[:id])
      puts @setting.inspect
    end

    def create
      @setting = Blogging::BlogAdmin::Setting.create(settings_params)
      respond_to do |format|
        format.js { render :layout => false }
      end
    end

    def update
      @setting = Blogging::BlogAdmin::Setting.find_by_id(params[:id])
      @setting.update_attributes(settings_params)
      respond_to do |format|
        format.js { render :layout => false }
      end
    end

    def set_social_page
      page = Blogging::BlogAdmin::SocialPage.find_by_id(params[:id])
      if page.update(:url => params[:url])
        @status = true
      else
        @status = false
      end
      respond_to do |format|
        format.js{render :layout => false}
      end
    end

    def register_widgets
      Blogging::BlogAdmin::Setting.register_widgets
    end

    private

    def settings_params
      params.require(:blog_admin_setting).permit!
    end

  end
end
