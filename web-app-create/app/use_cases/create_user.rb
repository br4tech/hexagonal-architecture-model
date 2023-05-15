class CreateUser
  def initialize(user_repository)
    @user_repository = user_repository
  end

  def execute(user)
    @user_repository.create(user)
  end
end