# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do

  describe 'welcome' do
    let(:user) { create(:user) }
    let(:token) { Time.now.to_i.to_s }
    let(:mail) { described_class.with(user: user, token: token).welcome.deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Aqui está seu acesso a plataforma da Pronto Consultórios')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['atendimento@prontoconsultorios.com.br'])
    end

    it 'assigns @token' do
      expect(mail.body.encoded).to match(token)
    end

    xit 'sends edit password link' do
      expect(mail.body.encoded).to match("/password/edit?reset_password_token=#{token}")
    end
  end

end
