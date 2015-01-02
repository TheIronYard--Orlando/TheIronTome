# vim: syntax=ruby
atom_feed do |feed|
  feed.title "Who bought #{@product.title}"

  feed.updated @latest_order.try(:updated_at)

  @product.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Order #{order.id}"
      entry.summary type: 'xhtml' do |x|
        x.p "Shipped to #{order.address}"
        x.table do
          x.tr do
            x.th 'Product'
            x.th 'Quantity'
            x.th 'Total Price'
          end
          order.line_items.each do |item|
            x.tr do
              x.td item.product.title
              x.td item.quantity
              x.td number_to_currency item.total_price
            end
          end
          x.tr do
            x.th 'total', colspan: 2
            x.th number_to_currency(order.line_items.map(&:total_price).sum)
          end
        end
        x.p "Paid by #{order.pay_type}"
      end
      entry.author do |author|
        author.name order.name
        author.email order.email
      end
    end
  end
end
