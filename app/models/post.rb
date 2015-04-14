class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :uid, type: String, default: ->{"#{Time.now.year}#{Time.now.month.to_s.rjust(2,'0')}#{Time.now.day.to_s.rjust(2,'0')}-#{char.gsub(' ','-')}"}
  field :subtitle, type: String
  field :content, type: String
  field :like, type: Integer, default: 0
  field :char, type: String

  def created_at_data
    "#{created_at.year}#{created_at.month.to_s.rjust(2,'0')}#{created_at.day.to_s.rjust(2,'0')}"
  end

  def short_name
    char.gsub(" ","-")
  end

  def to_param  
    "#{created_at_data}-#{short_name}"  
  end
end
