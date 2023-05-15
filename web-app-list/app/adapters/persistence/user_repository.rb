class Persistence::UserRepository
  include UserRepository

  def create(name:, email:)
    user = User.create(name: name, email: email)
    User.new(id: user.id, name: user.name, email: user.email)
  end

  def find(id)
    user = User.find(id)
    User.new(id: user.id, name: user.name, email: user.email)
  end
end