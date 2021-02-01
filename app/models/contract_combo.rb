class ContractCombo < ApplicationRecord
  belongs_to :client
  has_many :contracts

  def main_contract; self.contracts.first; end
  def starts_at; self.main_contract.starts_at; end
  def ends_at; self.main_contract.ends_at; end
  def offices; self.main_contract.offices; end
end