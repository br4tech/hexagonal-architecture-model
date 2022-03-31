# frozen_string_literal: true

class Holiday < ApplicationRecord
  validates :name, :color, :starts_at, :ends_at, presence: { presence: true }
end
