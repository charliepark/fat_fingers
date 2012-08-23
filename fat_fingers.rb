# Just put the following 8 lines into your app.
# If using Rails, create a file, "string.rb"
# in your config/initializers/ directory and put these lines in it.

class String
  def clean_up_typoed_email
    gsub(/\.c?m?o?m?$/, ".com")
    .gsub(/\.n?t?e?t?$/, ".net")
    .gsub(/\.og?r?g?$/, ".org") #require the o, to not false-positive .gr e-mails
    .gsub(/@coma?cas?tn?.net/,"@comcast.net")
    .gsub(/@g([m]*?[a]*?[m]*?[l]*?[i]*?[l]*?c?)\./,"@gmail.")
    .gsub(/@ya?h?[o]*c?\./,"@yahoo.")
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
      "test@gmailc.om",

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
      "test@yho.com",
      "test@yhooo.com",
      "test@yao.com",
      "test@yaooo.com",
      "test@yahooc.om",

      "test@yaho.cm",
      "test@yahooo.cm",
      "test@yho.cm",
      "test@yhooo.cm",
      "test@yao.cm",
      "test@yaooo.cm",

      "test@yaho.om",
      "test@yahooo.om",
      "test@yho.om",
      "test@yhooo.om",
      "test@yao.om",
      "test@yaooo.om"
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
      "test@something.ogr"
      ]

    @good_comcast = "test@comcast.net"
    @bad_comcast = [
      "test@comacast.net",
      "test@comcastn.et",
      "test@comcat.net"
      ]
  end

  def test_that_emails_get_fixed
    ["gmail", "intl_gmail", "yahoo", "net", "org", "comcast"].each do |test|
      eval("@bad_"+test).each do |email|
        assert_equal eval("@good_"+test), email.clean_up_typoed_email
      end
    end
  end

  def test_that_good_emails_do_not_get_broken
    ["gmail", "intl_gmail", "yahoo", "net", "org", "comcast"].each do |test|
      assert_equal eval("@good_"+test), eval("@good_"+test).clean_up_typoed_email
    end
  end

end