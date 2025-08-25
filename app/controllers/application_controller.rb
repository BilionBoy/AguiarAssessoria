class ApplicationController < ActionController::Base
  include Pagy::Backend
  include LayoutByUser
end
