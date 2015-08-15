class UbersController < ApplicationController

  before_action :require_login

def new

end

def create
  uber = Uber.new
  uber.authorize
end

end
