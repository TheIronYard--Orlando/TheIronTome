class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :pay_type
  belongs_to :cart
  belongs_to :user
  delegate :email, :name, :address, to: :user
  before_save :add_line_items_from_cart
  after_save :destroy_cart
  after_save :send_notification_email
  # means you can use order.email 
  # instead of order.user.email
  attr_reader :credit_card
  validate :credit_card_is_valid, on: :create  

  def credit_card=(hash)
    @credit_card = CreditCard.new(hash)
  end

  private

    def add_line_items_from_cart
      cart.line_items.each do |item|
        item.cart_id = nil
        line_items << item
      end
    end

    def credit_card_is_valid
      unless credit_card.valid?
        errors.add :base, 'credit card is invalid'
      end
    end

    def destroy_cart
      cart.destroy
    end
      
    def send_notification_email
      OrderNotifier.received(id).deliver_later
    end

end
