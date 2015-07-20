class Product < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items
  has_attached_file :pdf
  
  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :image, styles: {thumb: '200X200#'}
  validates_attachment_content_type :image, content_type: /\Aimage/
  validates_attachment_content_type :pdf, content_type: 'application/pdf'

  validates :title, :description, presence: true #image_url removed
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true, length: { minimum: 10 }
  # validates :image_url, allow_blank: true, format: {
  #   with: %r{\.(gif|jpg|png)\Z}i,
  #   message: 'must be a URL for GIF, JPG or PNG image.'
  # }

# Paperclip validations available
# validates :avatar, :attachment_presence => true
# validates_with AttachmentPresenceValidator, :attributes => :avatar
# validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 1.megabytes
  scope :with_ratings, -> { joins('LEFT JOIN line_items ON products.id = line_items.product_id LEFT JOIN ratings ON line_items.id = ratings.line_item_id')
      .group('products.id') }

  scope :ordered_by_ratings, -> { with_ratings.order('AVG(ratings.stars) DESC') }
  # from http://stackoverflow.com/questions/29380941/ordering-data-from-table-by-average-rating-and-number-of-reviews-including-objec

  scope :ordered_by_n_ratings, -> { select("products.*, COUNT(ratings.id) ratings_count")
                                    .with_ratings.order('ratings_count DESC')}

  def self.latest
    Product.order(:updated_at).last
  end

  def translate_title_and_description(language)
    self.title = Yandex::API::Translate.do(title, language)['text'][0]
    self.description = Yandex::API::Translate.do(description, language)['text'][0]
  end

  def update_quantity(quantity)
    decrement! :inventory, quantity
  end

  private

  #ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
