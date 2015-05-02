class Photo
  paginates_per 10

  include Mongoid::Document
  include Mongoid::Timestamps
  include Likeable
  include Countable
  field :title, type: String
  field :file, type: String
  field :exif, type: Hash
  field :content_in_a_list, type: Bool, default: false

  #mount PhotoUploader, :file

  def to_data
  end

end
