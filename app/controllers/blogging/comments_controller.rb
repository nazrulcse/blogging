require_dependency "blogging/application_controller"

module Blogging
  class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
      @blog = Blog.find_by_id(comments_params[:blog_id])
      @comment = @blog.comments.build(:comment => comments_params[:comment], :user_id => current_user.id)
      if @comment.save
        respond_to do |format|
          format.js
        end
      else
        redirect_to @blog, notice: 'Comment not posted'
      end
    end

    def reply
      @comment = Comment.find_by_id(params[:id])
      @reply = Comment.new(:comment => params[:reply], :blog_id => @comment.blog_id, :parent => params[:id], :user_id => current_user.id)
      if @reply.save
        respond_to do |format|
          format.js
        end
      else
        redirect_to @blog, notice: 'Reply not posted'
      end
    end

    private

    def comments_params
      params.require(:comment).permit!
    end

  end

end
