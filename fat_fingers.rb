# Just put the following method into your app.
# If using Rails, create a file, "string.rb" in your
# config/initializers/ directory and put these 15 lines
# (including the "class String" and "end" lines) in it.

class String
  def clean_up_typoed_email
    downcase.gsub(/c\.om$/, ".com")
    .gsub(/n\.et$/, ".net")
    .gsub(/(\.|\,|\'|\"|\\)*$/, "")
    .gsub(/\.c*(c|i|l|m|n|o|p)*m+(j|n|o)*$/,".com")
    .gsub(/\.(c|v|x)o+(m|n)$/,".com")
    .gsub(/\.n*t*e*t*$/, ".net")
    .gsub(/\.og*r*g*$/, ".org") #require the o, to not false-positive .gr e-mails
    .gsub(/@coma*cas*t.net/,"@comcast.net")
    .gsub(/@sbcgloba.net/, "@sbcglobal.net")
    .gsub(/@gm*i*a*m*l*i*l*\./,"@gmail.")
    .gsub(/@y*a*h*a*o*\./,"@yahoo.")
    .gsub(/@h(o|p)tm*i*a*m*l*i*l*\./,"@hotmail.")
  end
end

# In your users_controller.rb file, in the 'create' method,
# clean up e-mails by doing something like this before saving the user:
# @user.email = params[:user][:email].clean_up_typoed_email


# Below are the unit tests for Fat Fingers.
# Simply run 'ruby fat_fingers.rb' in your Terminal to see the test results.

require 'minitest/autorun'

class StringTest < MiniTest::Unit::TestCase
  def setup
    @good_gmail = "test@gmail.com"
    @bad_gmail = [
      "test@gmai.com",
      "test@gmal.com",
      "test@gmaal.com",
      "test@gmil.com",
      "test@gmial.com",
      "test@gmali.com",
      "test@gmaill.com",
      "test@gamil.com",
      "test@gmailc.om",
      "test@gmail.coom",
      "test@gmail.comm",

      "test@gmai.cmo",
      "test@gmal.cmo",
      "test@gmil.cmo",
      "test@gmial.cmo",
      "test@gmali.cmo",
      "test@gmaill.cmo",
      "test@gamil.cmo",

      "test@gmai.cm",
      "test@gmal.cm",
      "test@gmil.cm",
      "test@gmial.cm",
      "test@gmali.cm",
      "test@gmaill.cm",
      "test@gamil.cm",

      "test@gmai.om",
      "test@gmal.om",
      "test@gmil.om",
      "test@gmial.om",
      "test@gmali.om",
      "test@gmaill.om",
      "test@gamil.om",

      "test@gmail.ocm",
      "test@gmail.con",
      "test@gmail.cmo",
      "test@gmail.copm", 
      "test@gmail.xom",
      "test@gmail.com,",
      "test@gmail.com.",
      "test@gmail.vom",
      "test@gmail.comn",
      "test@gmail.com'",
      "test@gmail.com\"",
      "test@gmail.com\\",
      "test@gmail.comj",
      "test@gmail.coim",
      "test@gmail.cpm",
      "test@gmail.colm",
      "test@gmail.conm",
      "test@gmail.coom",

      "TEST@GMAIL.COM"
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
      "test@aho.com",
      "test@ahoo.com",
      "test@ahoo.cm",

      "test@yaho.com",
      "test@yahooo.com",
      "test@yhao.com",
      "test@yhaoo.com",
      "test@yho.com",
      "test@yhooo.com",
      "test@yao.com",
      "test@yaooo.com",
      "test@yahooc.om",

      "test@yaho.cm",
      "test@yahooo.cm",
      "test@yhao.cm",
      "test@yhaoo.cm",
      "test@yho.cm",
      "test@yhooo.cm",
      "test@yao.cm",
      "test@yaooo.cm",

      "test@yaho.om",
      "test@yahooo.om",
      "test@yhao.om",
      "test@yhaoo.om",
      "test@yho.om",
      "test@yhooo.om",
      "test@yao.om",
      "test@yaooo.om"
      ]

    @good_hotmail = "test@hotmail.com"
    @bad_hotmail = [
      "test@hotmaill.com",
      "test@hptmail.com",
      "test@htomali.com"
      ]

    @good_net = "test@something.net"
    @bad_net = [
      "test@something.nt",
      "test@something.ne",
      "test@something.et",
      "test@something.nte",
      "test@something.nett"
      ]

    @good_org = "test@something.org"
    @bad_org = [
      "test@something.or",
      "test@something.og",
      "test@something.ogr",
      "test@something.orgg"
      ]

    @good_comcast = "test@comcast.net"
    @bad_comcast = [
      "test@comacast.net",
      "test@comcastn.et",
      "test@comcat.net"
      ]

    @good_sbcglobal = "test@sbcglobal.net"
    @bad_sbcglobal = [
      "test@sbcgloba.net"
      ]

    @good_tld_cn = "test@something.cn"
    @bad_tld_cn = ["test@something.cn"]

    @good_tld_co = "test@something.co"
    @bad_tld_co = ["test@something.co"]

    @good_tld_gr = "test@something.gr"
    @bad_tld_gr = ["test@something.gr"]
  end

  def cases
    ["gmail", "intl_gmail", "yahoo", "hotmail", "net", "org", "comcast", "sbcglobal", "tld_cn", "tld_co", "tld_gr"]
  end

  def test_that_emails_get_fixed
    cases.each do |test|
      eval("@bad_"+test).each do |email|
        assert_equal eval("@good_"+test), email.clean_up_typoed_email
      end
    end
  end

  def test_that_good_emails_do_not_get_broken
    cases.each do |test|
      assert_equal eval("@good_"+test), eval("@good_"+test).clean_up_typoed_email
    end
  end

end