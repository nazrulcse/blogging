require_dependency "blogging/application_controller"

module Blogging
  module BlogAdmin
    class DashboardController < ApplicationController
      before_filter :blog_admin_authentication!
      layout "blogging/admin"
      def index

      end

      private

      def blog_admin_authentication!
         if current_user.present?
           if current_user.is_blog_admin
             true
           else
             flash[:error] = 'Access denied'
             redirect_to root_path
           end
         else
           flash[:error] = 'You need to sign in as blog admin'
           store_location_for(:user, blog_admin_root_path)
           redirect_to main_app.new_user_session_path
         end
      end
    end
  end
end
