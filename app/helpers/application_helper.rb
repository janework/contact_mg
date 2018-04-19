module ApplicationHelper

  def safe_glyph glyph_name
    html = "<i class='glyphicon glyphicon-".html_safe
     html += glyph_name
     html += "'></i>".html_safe
  end

end
