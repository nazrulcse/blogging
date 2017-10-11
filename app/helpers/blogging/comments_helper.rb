module Blogging
  module CommentsHelper
    def comments_replies(comment)
      html=''
      if comment
        html = "<li>#{render 'blogging/comments/comment_item', :comment => comment} </li>"
        if comment.replies
          comment.replies.each do |reply|
            html << "<ul class='child-#{reply.id}' style='padding-left: 10px; margin: 0px;'>"
            html << comments_replies(reply)
            html << '</ul>'
          end
        end
      end
      html.html_safe
    end
  end
end
