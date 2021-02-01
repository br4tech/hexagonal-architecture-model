# frozen_string_literal: true

# Mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'Pronto Consultórios <atendimento@prontoconsultorios.com.br>'
  layout 'mailer'
end
