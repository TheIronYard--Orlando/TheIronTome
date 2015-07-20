class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  delegate :user, to: :cart
  has_one :rating
  delegate :title, :description, to: :product

  def total_price
    product.price * quantity + shipping_price
  end

  def shipping_carrier
    shipment.lowest_rate.carrier
  end
  
  def shipping_price
    shipment.lowest_rate.rate
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

end
