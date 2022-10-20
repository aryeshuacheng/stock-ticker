class Player < ApplicationRecord
  has_one :portfolio
  has_many :stocks
end
