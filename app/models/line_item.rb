class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  delegate :user, to: :cart
  has_one :rating
  delegate :title, :description, to: :product

  def total_price
    subtotal + shipping_price + tax
  end

  def update_product_inventory
    product.update_inventory(quantity)
  end
  
  private

    def subtotal
      product.price * quantity
    end

    def shipping_carrier
      shipment.lowest_rate.carrier
    end
    
    def shipping_price
      if user.nil?
        0 #can't have a shipping price if no user=>no address
      else
        shipment.lowest_rate.rate
      end
    end

    def from_address
      FROM_ADDRESS #constant set in initializer
    end

    def parcel
      EasyPost::Parcel.create(
        width: product.width,
        length: product.length, 
        height: product.height * quantity,
        weight: product.weight * quantity
      )
    end

    def shipment
      EasyPost::Shipment.create(
        to_address: to_address,
        from_address: from_address,
        parcel: parcel
      )
    end

    def to_address
      EasyPost::Address.create(
        name: user.name,
        street1: user.address_1,
        city: user.city,
        state: user.state,
        zip: user.zip,
        country: 'US'
      )
    end

    def tax
      if user && user.address.state == 'FL'
        0.06 * subtotal # note this is only state-level
      else
        0
      end
    end

end
