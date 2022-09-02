require "test_helper"

class WelcomeMailerTest < ActionMailer::TestCase
  test "confirmation_notification" do
    mail = WelcomeMailer.confirmation_notification
    assert_equal "Confirmation notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
