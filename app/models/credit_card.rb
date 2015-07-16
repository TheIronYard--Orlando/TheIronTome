class CreditCard
  # it would be better to incorporate this into a payment gateway gem like ActiveMerchant.
  # this will check to see whether the number could possibly be valid,
  # but it doesn't talk to any financial systems to find out whether it *is* valid.
  
  include ActiveModel::Validations
  validate :number_fits_luhn
  validate :has_not_expired
  attr_accessor :number, :cvv

  def initialize(attributes)
    @number = attributes[:number]
    @cvv = attributes[:cvv]
    @expiration_month = attributes[:expiration_month]
    @expiration_year = attributes[:expiration_year]
  end

  def expiration_year
    @expiration_year.to_i
  end

  def expiration_month
    @expiration_month.to_i
  end

  private

    def number_fits_luhn
      unless Luhn.valid? number
        errors.add :number, 'is not a valid number'
      end
    end

    def has_not_expired
      if expired?
        errors.add :base, 'has expired'
      end
    end

    def expired?
      expired_this_year? || expired_before_this_year?
    end

    def expired_before_this_year?    
      expiration_year < Time.now.year
    end

    def expired_this_year?
      expiration_year == Time.now.year && 
      expiration_month <= Time.now.month
    end
end