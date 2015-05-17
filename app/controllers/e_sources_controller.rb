class ESourcesController < ApplicationController
  before_action :set_source, except: :index
  def index
    params[:page] ||= 1
    @sources = ESources.all.page params[:page]
  end

  def show
  end

  def request
  end

  def download
  end

  private
  def set_source
    @source = ESources.find params[:id]
  end
end
