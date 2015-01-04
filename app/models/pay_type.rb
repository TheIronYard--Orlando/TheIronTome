class PayType < ActiveRecord::Base
  has_many :orders
end
