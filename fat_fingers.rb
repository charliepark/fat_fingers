# Just put the following 8 lines into your app.
# If using Rails, create a file, "string.rb"
# in your config/initializers/ directory and put these lines in it.

class String
  def clean_up_typoed_email
    gsub(/\.c?m?o?m?$/, ".com")
    .gsub(/\.n?t?e?t?$/, ".net")
    .gsub(/\.o?g?r?g?$/, ".org")
    .gsub(/@coma?cas?t.net/,"@comcast.net")
    .gsub(/@g([m]*?[a]*?[m]*?[l]*?[i]*?[l]*?)\./,"@gmail.")
    .gsub(/@ya?h[o]*\./,"@yahoo.")
  end
end

# In your users_controller.rb file, in the 'create' method,
# clean up e-mails by doing something like this before saving the user:
# @user.email = params[:user][:email].downcase.clean_up_typoed_email


# Below is the unit test for Fat Fingers.
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
      "test@gamil.cm",

      "test@gmai.om",
      "test@gmal.om",
      "test@gmil.om",
      "test@gmali.om",
      "test@gmaill.om",
      "test@gamil.om"
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
      "test@yahooo.cm",

      "test@yaho.om",
      "test@yahooo.om"
      ]

    @good_net = "test@something.net"
    @bad_net = [
      "test@something.nt",
      "test@something.ne",
      "test@something.et",
      "test@something.nte"
      ]

    @good_org = "test@something.org"
    @bad_org = [
      "test@something.or",
      "test@something.og",
      "test@something.gr",
      "test@something.rg",
      "test@something.ogr"
      ]

    @good_comcast = "test@comcast.net"
    @bad_comcast = [
      "test@comacast.net",
      "test@comcat.net"
      ]

  end

  def test_that_emails_get_fixed
    @bad_gmail.each do |email|
      assert_equal @good_gmail, email.clean_up_typoed_email
    end
    @bad_intl_gmail.each do |email|
      assert_equal @good_intl_gmail, email.clean_up_typoed_email
    end
    @bad_yahoo.each do |email|
      assert_equal @good_yahoo, email.clean_up_typoed_email
    end
    @bad_net.each do |email|
      assert_equal @good_net, email.clean_up_typoed_email
    end
    @bad_org.each do |email|
      assert_equal @good_org, email.clean_up_typoed_email
    end
    @bad_comcast.each do |email|
      assert_equal @good_comcast, email.clean_up_typoed_email
    end
  end

end