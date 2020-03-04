class Order < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  monetize :total_price_cents
end
