require '../entities/user_entity.rb'
require '../repositories/user_repository.rb'

module Users
  class Create
    def initialize(params, user: UserEntity, user_repository: UserRepository)
      @params = params
      @user = user
      @user_repository = user_repository
    end

    def call
      user = @user.new(@params[:name])
      @user_repository.create(user)
    end
  end
end