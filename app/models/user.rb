class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_many :orders#, through: :carts
  has_many :line_items, through: :orders
  has_one :cart

  before_destroy :ensure_an_admin_remains

  def address
    "#{address_1} #{address_2} #{city}, #{state} #{zipcode}"
  end

  private
  def ensure_an_admin_remains
    if User.count == 1
      raise "Can't delete last user"
    end
  end
end
