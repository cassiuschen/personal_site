require "redcarpet"
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Likeable
  include Countable
  include Tagable
  include ActionView::Helpers
  field :title, type: String
  field :url_name, type: String
  field :subtitle, type: String
  field :content, type: String

  def to_param  
    "#{id}#{(url_name)?('-' + url_name.gsub(' ','-')):('')}"  
  end

  def next_post
    @posts = Post.all.to_a
    if @posts.size > 1
      @posts[(@posts.index(self) + 1) % @posts.size]
    else
      nil
    end
  end

  def render(options = {})
    # XXX: the renderer instance should be a class variable

    options[:hard_wrap] ||= false
    options[:class] ||= ''
    assembler = Redcarpet::Render::HTML.new(:hard_wrap => options[:hard_wrap]) # auto <br> in <p>

    renderer = Redcarpet::Markdown.new(assembler, {
      :autolink => true,
      :fenced_code_blocks => true
    })
    return sanitize(MarkdownConverter.convert(self.content))
  end

  def preview
    text = self.subtitle || self.content
    return truncate(MarkdownConverter.convert(text).remove_html_tag!, length: 100, truncate_string: "...")
  end

  def length
    self.text_content.length
  end

  def text_content
    MarkdownConverter.convert(self.content).remove_html_tag!
  end

  def read_time
    ((self.length / 500.0) * 10).floor / 10.0
  end
end
