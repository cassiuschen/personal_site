module ApplicationHelper
  ALLOW_TAGS = %w(p br img h1 h2 h3 h4 h5 h6 blockquote pre code b i strong em table tr td tbody th strike del u a ul ol li span hr)
  ALLOW_ATTRIBUTES = %w(href src class title alt target rel data-floor)

  def sanitize_markdown(body)
    # TODO: This method slow, 3.5ms per call in topic body
    sanitize body, tags: ALLOW_TAGS, attributes: ALLOW_ATTRIBUTES
  end

  def bind_html(str)
    strip_tags str
  end

  def color_to_rgba(color, o = 1)
  	if color.length == 3
  		color = color.split('').map{|c| c+c}.join('')
  	end
  	color = color.rjust(6, '0')
  	"rgba(#{color[0..1].hex}, #{color[2..3].hex}, #{color[4..5].hex}, #{o})"
  end

  def c_to_a(color, o = 1)
  	color_to_rgba(color, o)
  end

  def linear_top_to_bottom(topC, bottomC)
  	"background: -moz-linear-gradient(top,#{topC},#{bottomC});background: -webkit-gradient(linear,center top,center bottom,from(#{topC}), to(#{bottomC}));-webkit-linear-gradient(top,#{topC},#{bottomC});background: -o-linear-gradient(top,#{topC}, #{bottomC});-ms-filter: 'progid:DXImageTransform.Microsoft.gradient (GradientType=0, startColorstr=#{topC}, endColorstr=#{bottomC})';"
  end
end
