class ErrorNotifier < ActionMailer::Base
  default from: "#{ENV["GMAIL_USERNAME"]}@#{ENV["GMAIL_DOMAIN"]}"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_notifier.failed.subject
  #
  def failed
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
