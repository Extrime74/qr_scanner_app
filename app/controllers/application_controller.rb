class ApplicationController < ActionController::Base
  # Allow only browsers natively supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has
  allow_browser versions: :modern
end
