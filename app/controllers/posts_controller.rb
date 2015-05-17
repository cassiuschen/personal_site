class PostsController < ApplicationController
  before_action :set_post, except: :index
  def index
    params[:page] ||= 1
    @posts = Post.all.page params[:page]
  end

  def show
    @liked = liked?
    @post.visit
    @next_post = @post.next_post
  end

  def like
    unless liked?
      @post.do_like
      session["liked_post_#{@post.id}".to_sym] = @post.id
      puts "liked_#{@post.id}".to_sym, session["liked_#{@post.id}".to_sym]
      @flag = :like
    else
      @post.dislike
      session["liked_post_#{@post.id}".to_sym] = nil
      @flag = :dislike
    end
  end

  private
  def set_post
    @post = Post.find /^(\d*)/.match(params[:id]).captures.join('')
  end

  def liked?
    if @post
      !!(session["liked_post_#{@post.id}".to_sym])
    else
      false
    end
  end
end
