class PostsController < ApplicationController
  before_action :set_post, except: :index
  def index
    @posts = Post.all
  end

  def show
    @liked = liked?
    @post.visit
  end

  def like
    unless liked?
      @post.do_like
      session["liked_#{@post.id}".to_sym] = @post.id
      puts "liked_#{@post.id}".to_sym, session["liked_#{@post.id}".to_sym]
      @flag = :like
    else
      @post.dislike
      session["liked_#{@post.id}".to_sym] = nil
      @flag = :dislike
    end
  end

  private
  def set_post
    @post = Post.where(uid: params[:id]).last
  end

  def liked?
    if @post
      !!(session["liked_#{@post.id}".to_sym])
    else
      false
    end
  end
end
