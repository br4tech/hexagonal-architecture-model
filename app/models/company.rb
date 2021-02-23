class Company < ApplicationRecord
  enum categories: { pronto: 0, density: 1 } # Fixo ou Por Hora
end
