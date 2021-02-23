# frozen_string_literal: true

# Determines if a User can see and access an Office
class Access < ApplicationRecord
  belongs_to :user
  belongs_to :office

  validates :user_id, uniqueness: { scope: [:office_id] }
end
