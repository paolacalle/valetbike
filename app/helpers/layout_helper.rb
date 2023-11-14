module LayoutHelper
    def display_alerts
      if flash[:alert].present?
        content_tag(:div, class: "flash", id: "alert") do
          content_tag(:div, flash[:alert], class: "text")
        end
      end
    end
  
    def display_notices
      if flash[:notice].present?
        content_tag(:div, class: "flash", id: "notice") do
          content_tag(:div, flash[:notice], class: "text")
        end
      end
    end
  end