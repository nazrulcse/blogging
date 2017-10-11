require_dependency "blogging/application_controller"

module Blogging
  class BlogsController < ApplicationController
    before_action :authenticate_user!, :only => ['create', 'destroy', 'edit', 'update']

    def index
      @blogs = Blog.all
    end

    def show
      @blog = Blogging::Blog.find_by_slug(params[:id])
      @blog.update(:view => @blog.view + 1)
      @comments = @blog.comments.where('parent IS NULL')
    end

    def new
      @blog = Blog.new
    end

    def edit
    end

    def create
      @blog = Blog.new(blog_params)
      if @blog.save
        redirect_to blog_path(@blog.slug), notice: 'Blog was successfully created.'
      else
        render :new
      end
    end

    def update
      if @blog.update(blog_params)
        redirect_to @blog, notice: 'Blog was successfully updated.'
      else
        render :edit
      end
    end

    def load_more
      if params[:tag].present?
        @blogs = Blog.tagged_with([params[:tag].to_s]).where(:is_published => true, :status => true).offset(params[:offset]).limit(Blogging.per_page)
      else
        @blogs = Blog.published_blogs.offset(params[:offset]).limit(Blogging.per_page)
      end
      respond_to do |format|
        format.js{render :layout => false}
      end
    end

    def destroy
      @blog.destroy
      redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
    end


    private

      def blog_params
        params.require(:blog).permit(:title, :description, :category_id, :tag_list, :image, :published_at).merge(:user_id => current_user.id)
      end
  end
end
