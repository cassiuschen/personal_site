class Photo
  include Mongoid::Document
  include Likeable
  include Countable
  field :title, type: String
  field :file, type: String
  field :exif, type: Hash

  mount PhotoUploader, :file

end
