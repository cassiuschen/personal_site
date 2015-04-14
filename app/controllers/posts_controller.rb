class PostsController < ApplicationController
  before_action :set_post, except: :index
  def index
    @posts = Post.all
  end

  def show
  end

  def like
  end

  private
  def set_post
    @post = Post.where(uid: params[:id]).last
  end
end
