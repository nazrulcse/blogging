require_dependency "blogging/application_controller"

module Blogging
  module BlogAdmin
    class WidgetsController < Blogging::BlogAdmin::DashboardController
      def index
       @widgets = Blogging::BlogAdmin::Widget.all
      end

      def new
        @widget = Blogging::BlogAdmin::Widget.new
      end

      def create
        @widget = Blogging::BlogAdmin::Widget.new(widgets_params)
        if @widget.save
          redirect_to blog_admin_widgets_path
        else
          render 'new'
        end
      end

      def edit
        @widget = Blogging::BlogAdmin::Widget.find_by_id(params[:id])
      end

      def update
        @widget = Blogging::BlogAdmin::Widget.find_by_id(params[:id])
        if @widget.update_attributes(widgets_params)
          redirect_to blog_admin_widgets_path
        else
          render 'edit'
        end
      end

      def destroy
        widget = Blogging::BlogAdmin::Widget.find_by_id(params[:id])
        widget.destroy
        redirect_to blog_admin_widgets_path
      end

      private

      def widgets_params
        params.require(:blog_admin_widget).permit!
      end

    end
  end
end
