# frozen_string_literal: true

# Helper
module ApplicationHelper
  def flash_style(type)
    case type.to_sym
    when :error
      'is-danger'
    when :alert
      'is-warning'
    when :notice
      'is-success'
    else
      'is-info'
    end
  end

  def not_supplied
    "<i class='has-text-grey'>Não Fornecido</i>".html_safe
  end

  def cpf_mask(document)
    return if document.nil?

    document.gsub!(/(\d{3})(\d{3})(\d{3})(\d{2})$/, '\\1.\\2.\\3-\\4')
  end

  def phone_mask(number)
    return if number.nil?

    number.gsub!(/(\d{1,2})(\d{4})(\d{4})$/, "\(\\1) \\2-\\3")
  end

  def names_for(list)
    list.pluck(:name).join(', ')
  end

  def formatted_date(date)
    date.strftime('%d/%m/%Y') if date.present?
  end

  def formatted_hour(date)
    date.strftime('%H:%M') if date.present?
  end

  def formatted_currency(number)
    number_to_currency(number, unit: 'R$ ', separator: ',', delimiter: '.')
  end
end
