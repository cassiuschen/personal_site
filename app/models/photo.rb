require 'net/http'
require "open-uri"
class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Likeable
  include Countable
  include Tagable
  field :title, type: String
  field :file, type: String
  field :raw_exif, type: Hash
  field :url_name, type: String
  field :content_in_a_list, type: Boolean, default: false
  field :main_color, type: String, default: 'fff'

  index created_at: -1

  mount_uploader :file, PhotoUploader

  after_create do
    #self.get_EXIF
    #self.get_main_color
  end

  def to_param  
    "#{id}#{(url_name)?('-' + url_name.gsub(' ','-')):('')}"  
  end

  def next_post
    @photos = Photo.all.sort_by(&:id).to_a
    if @photos.size > 1
      @photos[(@photos.index(self) + 1) % @photos.size]
    else
      nil
    end
  end

  # 七牛图片处理
  def self.qiniu_methods(*arg)
    arg.each do |m|
      self.class_eval %Q{
        def #{m}
          self.file.url + '-#{m}'
        end
      }
    end
  end

  qiniu_methods :xlarge, :square, :small, :large

  # 从七牛获取 EXIF 和 主要色彩
  def get_EXIF
    data = nil
    open(self.file.url + '?exif') do |http|
      data = http.read
    end
    self.raw_exif = JSON.parse data
    self.save
  end

  def get_main_color
    data = nil
    open(self.file.url + '?imageAve') do |http|
      data = http.read
    end
    self.main_color = JSON.parse(data)["RGB"][2..-1]
    self.save
  end

  # 判断图片明暗
  def light_rage
    r, g, b = self.main_color[0..1], self.main_color[2..3], self.main_color[4..5]
    # 亮度计算公式
    return ((r.to_i(16) * 299 + g.to_i(16) * 587 + b.to_i(16) * 114) / 1000)
  end

  def dark?
    self.light_rage > 500 ? false : true
  end

  # 图片边框颜色，暗色图片黑框(#242424)，亮色用白框(#fff)
  def border_color
    self.dark? ? "#242424" : "#fff"
  end

  # 主要exif信息
  def exif
    data = self.raw_exif
    {
      model: data["Model"]["val"],
      iso: data["ISOSpeedRatings"]["val"],
      shutter: data["ExposureTime"]["val"],
    }
  end
end
