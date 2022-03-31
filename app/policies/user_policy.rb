# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.admin?
  end
end
