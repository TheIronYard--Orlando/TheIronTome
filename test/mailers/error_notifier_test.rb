require 'test_helper'

class ErrorNotifierTest < ActionMailer::TestCase
  test "failed" do
    mail = ErrorNotifier.failed
    assert_equal "Failed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
