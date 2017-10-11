require_dependency "blogging/application_controller"

module Blogging
  class WelcomeController < ApplicationController
    def index
      if params[:tag].present?
        @blogs = Blog.tagged_with([params[:tag].to_s]).where(:is_published => true, :status => true)
      else
        @blogs = Blog.published_blogs.limit(Blogging.per_page.to_i)
      end
    end

    def token
      @hash = []
      @search_res = ActsAsTaggableOn::Tag.where("name like ?", "%#{params[:q]}%")
      @search_res.each do |tag|
        @hash << { id: tag.name, name: tag.name}
      end
      unless @search_res.present?
        @hash = [{ id: params[:q], name: params[:q]}]
      end
      render json: @hash
    end

    def authentication
      store_location_for(:user, params[:url])
      respond_to do |format|
        format.js{render :layout => false}
      end
    end

    def subscribe
      subscribe = Blogging::NewsLetter.new(:email => params[:email])
      respond_to do |format|
        unless subscribe.save
          @message = subscribe.errors.collect{|field, msg| "#{field} : #{msg}"}.join(',')
        end
        format.js {render :layout => false}
      end
    end

    def page
      raw_page = Blogging::BlogAdmin::Page.find_by_slug(params[:slug])
      @page = Blogging::BlogAdmin::WidgetParser.new(raw_page)
      respond_to do |format|
        format.html {}
      end
    end

    def author_profile
      @user = User.find_by_id(params[:id])
      @blogs = @user.blogs
    end

  end
end
