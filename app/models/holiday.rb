# frozen_string_literal: true

class Holiday < ApplicationRecord
  has_many  :day_offs

  validates :name, :color, :starts_at, :ends_at, presence: { presence: true }
end
