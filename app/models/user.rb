class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password
  has_many :orders, through: :carts
  has_many :carts
  has_many :wish_lists

  after_destroy :ensure_an_admin_remains

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
end
