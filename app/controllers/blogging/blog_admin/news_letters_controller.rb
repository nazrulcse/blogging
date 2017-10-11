require_dependency "blogging/application_controller"

module Blogging
  module BlogAdmin
    class NewsLettersController < Blogging::BlogAdmin::DashboardController
      def index
        @news_letters = Blogging::NewsLetter.all
      end

      def destroy
        subscribe = Blogging::NewsLetter.find_by_id(params[:id])
        respond_to do |format|
          subscribe.destroy
          format.js{}
        end
      end

      def create
        @subscribe = Blogging::NewsLetter.new(:email => params[:news_letter][:email])
        respond_to do |format|
          unless @subscribe.save
            @message = @subscribe.errors.collect{|field, msg| "#{field} : #{msg}"}.join(',')
          end
          format.js {render :layout => false}
        end
      end
    end
  end
end