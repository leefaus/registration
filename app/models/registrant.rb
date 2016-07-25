class Registrant < ApplicationRecord
  belongs_to :account
  belongs_to :partner
end
