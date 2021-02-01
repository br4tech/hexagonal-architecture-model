# frozen_string_literal: true

# Represents system users such Admin and Secretary
class User < ApplicationRecord
  enum status: { 'active' => 0, 'blocked' => 1 }
  enum role: { 'admin' => 0, 'manager' => 1, 'regular' => 2 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :accesses, dependent: :delete_all
  has_many :offices, -> { where('accesses.allow = true') }, through: :accesses
  accepts_nested_attributes_for :accesses, allow_destroy: true

  has_one_attached :avatar

  validates :name, :role, presence: true

  # after_create :send_welcome_mail

  def admin?
    role == 'admin'
  end

  def to_param
    [id, name.parameterize].join('-')
  end

  def active_for_authentication?
    super && self.status == "active"
  end
  
  def inactive_message
    "Desculpe, esta conta está desativada."
  end

  private

  def send_welcome_mail
    token, enc = Devise.token_generator.generate(User, :reset_password_token)
    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
    UserMailer.with(user: self, token: token).welcome.deliver_now
  end
end
