require_dependency "blogging/application_controller"

module Blogging
  module BlogAdmin
    class PostsController < Blogging::BlogAdmin::DashboardController
      def index
        @posts = Blogging::Blog.all
      end

      def approve
        @blog = Blogging::Blog.find_by_id(params[:id])
        @blog.update(:status => true)
      end

      def destroy
        @blog = Blogging::Blog.find_by_id(params[:id])
        @blog.destroy
        redirect_to blog_admin_posts_path
      end

      def new
        @post = Blogging::Blog.new
      end

      def show
        @post = Blogging::Blog.find_by_id(params[:id])
      end

      def create
        @post = Blogging::Blog.new(posts_params)
        if @post.save
          redirect_to blog_admin_posts_path
        else
          render 'new'
        end
      end

      def edit
        @post = Blogging::Blog.find_by_id(params[:id])
      end

      def update
        @post = Blogging::Blog.find_by_id(params[:id])
        @post.update_attributes(posts_params)
        redirect_to blog_admin_posts_path
      end

      private

      def posts_params
        params.require(:blog).merge(:user_id => current_user.id).permit!
      end

    end
  end
end
