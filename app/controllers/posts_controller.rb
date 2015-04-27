class PostsController < ApplicationController
  before_action :set_post, except: :index
  def index
    @posts = Post.all
  end

  def show
    flash[:notice] = "TEST NOTICE"
  end

  def like
    unless session[:liked_posts] and session[:liked_posts].include? @post.id 
      @post.like
      session[:liked_posts] ||= []
      session[:liked_posts] += [@post.id]
      @flag = :like
    else
      @post.dislike
      session[:liked_posts] -= [@post.id]
      @flag = :dislike
    end
  end

  private
  def set_post
    @post = Post.where(uid: params[:id]).last
  end
end
