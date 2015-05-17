class ESource
  include Mongoid::Document
  field :file, type: String
  mount_uploader :file, ESourceUploader
  field :title, type: String
  field :can_download, type: Mongoid::Boolean, default: false
  field :request_times, type: Integer, default: 0
  field :desc, type: String
  field :type, type: String, default: 'e_book'
  TYPES = {
  	e_books: 'esouce.e_book',
  	vedio: 'esource.vedio',
  	audio: 'esource.audio'
  }
  validates :tyoe, inclusion: {in: TYPES.keys}
  index stage: 1

  scope :type, -> (type) {where(type: type)}
  scope :can_download, -> {where(can_download: true)}

  TYPES.keys.each do |k|
  	scope k.to_sym, -> {where(type: k)}
  end
end
