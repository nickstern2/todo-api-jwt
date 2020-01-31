# Replaced ::Base
# class ApplicationController < ActionController::Base
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
end

