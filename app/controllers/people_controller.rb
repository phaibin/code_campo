class PeopleController < ApplicationController
  before_filter :find_person

  def show
    @topics = @person.topics.order([[:created_at]]).page(1).per(10)
    @topics_count = @person.topics.count
    @replies_count = @person.replies.count
  end

  protected

  def find_person
    # @person = User.first :conditions => {:name => /^#{params[:name]}$/i}
    @person = User.where("lower(name)=?", params[:name].downcase).first
    raise Mongoid::Errors::DocumentNotFound.new(User, params[:name]) if @person.nil?
  end
end
