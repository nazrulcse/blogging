require_dependency "blogging/application_controller"

module Blogging
  module BlogAdmin
    class PagesController < Blogging::BlogAdmin::DashboardController
      def index
        @pages = Blogging::BlogAdmin::Page.all
      end


      def destroy
        @page =  Blogging::BlogAdmin::Page.find_by_id(params[:id])
        @page.destroy
        redirect_to blog_admin_pages_path
      end

      def new
        @page =  Blogging::BlogAdmin::Page.new
      end

      def show
        @page =  Blogging::BlogAdmin::Page.find_by_id(params[:id])
      end

      def create
        @page =  Blogging::BlogAdmin::Page.new(page_params)
        if @page.save
          redirect_to blog_admin_pages_path
        else
          render 'new'
        end
      end

      def edit
        @page =  Blogging::BlogAdmin::Page.find_by_id(params[:id])
      end

      def update
        @page = Blogging::BlogAdmin::Page.find_by_id(params[:id])
        @page.update_attributes(page_params)
        redirect_to blog_admin_pages_path
      end

      private

      def page_params
        params.require(:blog_admin_page).permit!
      end

    end
  end
end
