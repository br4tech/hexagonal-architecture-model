require '../../domain/usecases/users/list'

class UsersController < ApplicationController
  def index 
  end

  def show
    Users::Create.new(params).call    
  end
end