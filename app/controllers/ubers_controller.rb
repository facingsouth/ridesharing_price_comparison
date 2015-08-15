class UbersController < ApplicationController

  before_action :require_login

# Implementing OAuth
def create
  uber = Uber.new
  uber.authorize
end

end
