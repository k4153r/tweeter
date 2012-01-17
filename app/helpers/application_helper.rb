module ApplicationHelper
  # return a title on a per page basis
  def title
    base_title = "Sample App"
    if @title.nil? | @title.empty?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("rails.png", :alt => "Sample App", :class => "round")
  end
end
