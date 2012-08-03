# Just put the following lines into your app.
# If using Rails, create a file, "string.rb"
# in your config/initializers/ directory and put these lines in it.

# In your users_controller.rb file, in the 'create' method,
# clean up e-mails by doing something like this before saving the user:
# @user.email = params[:user][:email].downcase.clean_up_typoed_email

class String
  def clean_up_typoed_email
    gsub(/\.cm?o?$/, ".com")
    .gsub("comcat.net","comcast.net")
    .gsub(/@g([m]*?[a]*?[m]*?[l]*?[i]*?[l]*?)\./,"@gmail.")
    .gsub(/@ya?h[o]*\./,"@yahoo.")
  end
end

# Below is the unit test for Scrubby.
# Simply run 'ruby fat_fingers.rb' in your Terminal to see the test results.

require 'minitest/autorun'

class StringTest < MiniTest::Unit::TestCase
  def setup
    @good_gmail = "test@gmail.com"
    @bad_gmail = [
      "test@gmai.com",
      "test@gmal.com",
      "test@gmil.com",
      "test@gmali.com",
      "test@gmaill.com",
      "test@gamil.com",

      "test@gmai.cmo",
      "test@gmal.cmo",
      "test@gmil.cmo",
      "test@gmali.cmo",
      "test@gmaill.cmo",
      "test@gamil.cmo",

      "test@gmai.cm",
      "test@gmal.cm",
      "test@gmil.cm",
      "test@gmali.cm",
      "test@gmaill.cm",
      "test@gamil.cm"
      ]

    @good_intl_gmail = "test@gmail.co.uk"
    @bad_intl_gmail = [
      "test@gmai.co.uk",
      "test@gmal.co.uk",
      "test@gmil.co.uk",
      "test@gail.co.uk",
      "test@gmali.co.uk",
      "test@gmaill.co.uk",
      "test@gamil.co.uk"
      ]

    @good_yahoo = "test@yahoo.com"
    @bad_yahoo = [
      "test@yaho.com",
      "test@yahooo.com",

      "test@yaho.cmo",
      "test@yahooo.cmo",

      "test@yaho.cm",
      "test@yahooo.cm"
      ]
  end

  def test_that_emails_get_fixed
    @bad_gmail.each do |email|
      assert_equal email.clean_up_typoed_email, @good_gmail
    end
    @bad_intl_gmail.each do |email|
      assert_equal email.clean_up_typoed_email, @good_intl_gmail
    end
    @bad_yahoo.each do |email|
      assert_equal email.clean_up_typoed_email, @good_yahoo
    end
  end

end