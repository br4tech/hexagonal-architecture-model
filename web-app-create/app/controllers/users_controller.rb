require '../../domain/usecases/users/create'

class UsersController < ApplicationController
  def create(params)
    Users::Create.new(params).call
  end
end