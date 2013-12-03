module ApplicationHelper
  def page_title
    if @page_title
      "#{@page_title} - #{@site.name}"
    else
      "#{@site.name}"
    end
  end
  
  def page_title_with_notification
    if logined? && current_user.notifications.unread.count != 0
      "(#{current_user.notifications.unread.count}) #{page_title}"
    else
      page_title
    end
  end

  def format_text(text, options = {})
    sanitize markdown(link_mentions(text.to_s, options[:mention_names]))
  end

  @@html_render  = Redcarpet::Render::HTML.new :hard_wrap => true, :no_styles => true
  @@markdown     = Redcarpet::Markdown.new @@html_render, :autolink => true, :no_intra_emphasis => true
  def markdown(text)
    @@markdown.render(text)
  end

  def link_mentions(text, mention_names)
    if mention_names && mention_names.any?
      text.gsub(/@(#{mention_names.join('|')})(?![.\w])/) do
        username = $1
        %Q[@<a href="/~#{username}">#{username}</a>]
      end
    else
      text
    end
  end

  def link_avatar_to_person(user, options = {})
    options[:size] ||= 48
    link_to image_tag(user.gravatar_url(:size => options[:size])), person_path(:name => user)
  end

  def link_to_person(user)
    link_to user.name, person_path(:name => user)
  end

  def format_time(time)
    timeago_tag time, :limit => 1.weeks.ago
  end
end
