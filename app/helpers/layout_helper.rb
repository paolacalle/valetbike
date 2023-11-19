module LayoutHelper
    def display_alerts
      if flash[:alert].present?
        puts "there are alerts"
        content_tag(:div, class: "flash", id: "alert") do
          a = flash[:alert]
          puts "The alert is/are " + a
          content_tag(:div, a, class: "text")
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
    def display_errors
      if flash[:error].present?
        content_tag(:div, class: "flash", id: "error") do
          content_tag(:div, flash[:error], class: "text")
        end
      end
    end

    def display_successes
      if flash[:success].present?
        content_tag(:div, class: "flash", id: "success") do
          content_tag(:div, flash[:success], class: "text")
        end
      end
    end
  end