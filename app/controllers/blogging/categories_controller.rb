require_dependency "blogging/application_controller"

module Blogging
  class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    # GET /categories
    def index
      @categories = Category.all
    end

    # GET /categories/1
    def show
      @category = Category.where('lower(name) = ?', params[:id].downcase).first
      if @category.present?
        @blogs = @category.published_blogs
      end
    end

    # GET /categories/new
    def new
      @category = Category.new
    end

    # GET /categories/1/edit
    def edit
      @category = Blogging::Category.find_by_id(params[:id])
    end

    # POST /categories
    def create
      @category = Category.new(category_params)
      respond_to do |format|
        @category.save
        format.js { render :layout => false }
      end
    end

    # PATCH/PUT /categories/1
    def update
      respond_to do |format|
        if @category.update(category_params)
          format.js { render :layout => false }
        else
          render :edit
        end
      end
    end

    # DELETE /categories/1
    def destroy
      @category.destroy
      respond_to do |format|
        format.js {}
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find_by_id(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name)
    end
  end
end
