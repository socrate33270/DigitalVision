module ApplicationHelper
  def landing_section_path(anchor)
    if current_page?(root_path)
      "##{anchor}"
    else
      root_path(anchor:)
    end
  end
end
