# frozen_string_literal: true

# Especialidades / Dados da Consulta
class Expertise < ApplicationRecord
  belongs_to :doctor
  validates :name, presence: true
end
