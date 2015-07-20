class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :pay_type
  belongs_to :cart
  belongs_to :user
  delegate :email, :name, :address, to: :user
  before_save :add_line_items_from_cart
  after_create :destroy_cart
  after_create :send_notification_email
  after_create :update_product_inventory
  # means you can use order.email 
  # instead of order.user.email
  attr_reader :credit_card
  validate :credit_card_is_valid, on: :create  

  def credit_card=(hash)
    @credit_card = CreditCard.new(hash)
  end

  def first_item
    line_items.first
  end

  def additional_items
    line_items[1..-1]
  end
  
  private

    def add_line_items_from_cart
      cart.line_items.each do |item|
        item.cart_id = nil
        line_items << item
      end
      self.price = cart.total_price
    end

    def credit_card_is_valid
      unless credit_card.valid?
        credit_card.errors.each do |attribute, msg|
          errors.add :base, msg
        end
      end
    end

    def destroy_cart
      cart.destroy
    end
      
    def send_notification_email
      OrderNotifier.received(id).deliver_later
    end

    def update_product_inventory
      line_items.each{|line_item| line_item.update_product_inventory }
    end
end
