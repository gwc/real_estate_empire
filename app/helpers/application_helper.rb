module ApplicationHelper
  #Return a title on a per page basis.
  
  def title
    base_title = "Real Estate Empire Application"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("logo.png", :alt => "Real Estate Empire Application", :class => "round")
  
  end
end
