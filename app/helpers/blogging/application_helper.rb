module Blogging
  module ApplicationHelper

    def method_missing method, *args, &block
      method.to_s.end_with?('_path', '_url') and main_app.respond_to?(method) ? main_app.send(method, *args) : super
    end

    def most_used_tags
      @most_used_tags = ActsAsTaggableOn::Tag.most_used(10)
      @most_used_tags.map { |t| link_to t.name, tag_path(t.name), :class => 'tags__link' }.join(' ')
    end

    def get_user_name(user)
      name = user.try(Blogging.user_name_field.to_sym)
      if name.present?
        name
      else
        'dummy'
      end
    end

    def get_user_photo(user)
      photo = user.try(Blogging.user_photo_field.to_sym)
      if photo.present?
        photo
      else
         'blogging/body.png'
      end
    end

    def form_validation_message(obj)
      if obj.errors.any?
        html = "<div id='error_explanation'>"
        html << "<h2> #{pluralize(obj.errors.count, 'error')} prohibited this post from being saved:</h2> <ul>"
        obj.errors.full_messages.each do |message|
          html << "<li> <i class='fa fa-times-circle'></i> #{message} </li>"
        end
        html << '</ul></div>'
      else
        html = ''
      end
      raw(html)
    end

    def post_tag_list(tag, klass = '')
      raw tag.map { |t| link_to t, tag_path(t), :class => klass }.join(', ')
    end

    def prepopulate_tag(obj)
      tag_list = obj.tag_list
      @hash = []
      if tag_list.present?
        tag_list.each do |tag|
          @hash << { id: tag, name: tag}
        end
      end
      @hash.to_json
    end

    def get_menu
      html = ''
      @pages = Blogging::BlogAdmin::Page.all
      @pages.each do |page|
        html << "<li> #{link_to page.menu, page_path(page.slug)} </li>"
      end
      raw html
    end

    def current_menu(menu, controller)
      if menu.downcase == controller.to_s.downcase
        'active'
      end
    end

  end
end
