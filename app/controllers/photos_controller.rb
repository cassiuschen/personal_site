class PhotosController < ApplicationController
  before_action :set_photo, except: :index
  def index
    params[:page] ||= 1
    @photos = Photo.all.page params[:page]
  end

  def show
    @liked = liked?
    @photo.visit
    @next_photo = @photo.next_post
  end

  def like
    unless liked?
      @photo.do_like
      session["liked_photo_#{@photo.id}".to_sym] = @photo.id
      puts "liked_#{@photo.id}".to_sym, session["liked_#{@photo.id}".to_sym]
      @flag = :like
    else
      @photo.dislike
      session["liked_photo_#{@photo.id}".to_sym] = nil
      @flag = :dislike
    end
  end

    private
  def set_photo
    @photo = Photo.find /^(\d*)/.match(params[:id]).captures.join('')
    unless @photo.raw_exif
      @photo.get_EXIF
      @photo.get_main_color
    end
  end

  def liked?
    if @photo
      !!(session["liked_photo_#{@photo.id}".to_sym])
    else
      false
    end
  end
end