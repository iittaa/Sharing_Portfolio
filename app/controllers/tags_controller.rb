class TagsController < ApplicationController
  before_action :logged_in_user, only:[:show, :index]


  def show
    @tag = Tag.find_by(id: params[:id])  
    @posts = @tag.posts.all 
  end

  def index
    @tag_list = Tag.all
  end
end
