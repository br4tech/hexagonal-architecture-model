# frozen_string_literal: true

class ClientDoctor < ApplicationRecord
  belongs_to :client
  belongs_to :doctor
end
