class UserRepositoryAdapter < UserRepository
  def find_by_id(id)
    User.find_by(id: id)
  end

  def create(user)
    User.create(user)
  end

  def update(user)
    User.find_by(id: user[:id]).update(user)
  end

  def delete(id)
    User.find_by(id: id).destroy
  end
end