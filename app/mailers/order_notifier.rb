class OrderNotifier < ActionMailer::Base
  default from: "#{ENV["GMAIL_USERNAME"]}@#{ENV["GMAIL_DOMAIN"]}"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order_id)
    @order = Order.find(order_id)

    mail to: @order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order_id)
    @order = Order.find(order_id)

    mail to: @order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
