class TopicsController < ApplicationController
  before_filter :old_id_redirect, :only => [:show]
  before_filter :require_logined, :except => [:index, :show, :tagged, :newest]
  before_filter :find_topic, :only => [:show, :mark, :unmark]
  before_filter :find_user_topic, :only => [:edit, :update]

  def index
    @topics = Topic.active.page(params[:page])
  end

  def newest
    respond_to do |format|
      format.html do
        @topics = Topic.order_by([[:created_at, :desc]]).page(params[:page])
        render :index
      end
      format.rss do
        @topics = Topic.order('created_at desc').limit(20)
        @page_title = I18n.t('newest_topics_title', :site_name => @site.name)
        render :index, :layout => false
      end
    end
  end

  def my
    @topics = current_user.topics.active.page(params[:page])
    render :index
  end

  def marked
    @topics = Topic.mark_by(current_user).active.page(params[:page])
    render :index
  end

  def replied
    @topics = Topic.reply_by(current_user).active.page(params[:page])
    render :index
  end

  def tagged
    respond_to do |format|
      format.html do
        @topics = Topic.joins(:tags).where(tags:{name:params[:tag]}).active.page(params[:page])
        render :index
      end
      format.rss do
        @topics = Topic.where(:tags => params[:tag]).order('created_at desc').limit(20)
        @page_title = I18n.t('tagged_newest_topics', :site_name => @site.name, :tag => params[:tag])
        render :index, :layout => false
      end
    end
  end

  def new
    @topic = Topic.new :tag_string => params[:tag]
  end

  def create
    @topic = current_user.topics.new params[:topic]
    if @topic.save
      redirect_to @topic
    else
      render :new
    end
  end

  def show
    @replies = @topic.replies.page(params[:page])

    if logined?
      if !@topic.last_read?(current_user) && current_user.notifications.has_unread?
        current_user.notifications.unread.any_of({:mentionable_type => 'Topic', :mentionable_id => @topic.id},
                                                 {:mentionable_type => 'Reply', :mentionable_id.in => @replies.map(&:id)},
                                                 {:reply_id.in => @replies.map(&:id)}).update_all(:read => true)
      end
      @topic.read_by current_user
      @reply = current_user.replies.new :topic => @topic
    end

    @relate_topics = @topic.relate_topics(5)
  end

  def edit
  end

  def update
    @topic.set_edited_at
    if @topic.update_attributes params[:topic]
      redirect_to @topic
    else
      render :edit
    end
  end

  def mark
    @topic.mark_by current_user
    respond_to do |format|
      format.html { redirect_referrer_or_default @topic }
      format.js { render :layout => false }
    end
  end

  def unmark
    @topic.unmark_by current_user
    respond_to do |format|
      format.html { redirect_referrer_or_default @topic }
      format.js { render :mark, :layout => false }
    end
  end

  protected

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def find_user_topic
    @topic = current_user.topics.number(params[:id])
  end

  # TODO remove
  def old_id_redirect
    if params[:id] !~ /\A\d+\z/
      topic = Topic.first :conditions => {:_id => params[:id]}
      redirect_to(topic, :status => 301) if topic
    end
  end
end
