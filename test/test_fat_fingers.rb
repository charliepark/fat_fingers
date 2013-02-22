require 'minitest/autorun'
#require 'fat_fingers'
require './lib/fat_fingers.rb'

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
      "test@gmila.com",
      "test@gmaill.com",
      "test@gamil.com",

      "test@gmailc.om",
      "test@gmail.coom",
      "test@gmail.comm",
      "test@gmail.comme",
      "test@gmail.co,",
      "test@gmail.co<",

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
      "test@gmail.vom",
      "test@gmail.comn",
      "test@gmail.comj",
      "test@gmail.coim",
      "test@gmail.cpm",
      "test@gmail.colm",
      "test@gmail.conm",
      "test@gmail.coom",
      "test@gmail.c0m",
      "test@gnail.com",

      "te st@gmail.com",

      "test@gmail.com'",
      "te'st@gmail.com",
      "test@gmail.com\"",
      "test@gmail.com\\",
      "test@gmail.com,",
      "test@gmail.com.",
      "test@gmail,com",
      "test@#gmail.com",
      "test\#@gmail.com",
      "test@gmail..com",
      #"test@gmailcom",

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
      "test@something.nett",
      "test@something.net"
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

    @good_tld_coop = "test@something.coop"
    @bad_tld_coop = ["test@something.coop"]
  end

  def cases
    ["gmail", "intl_gmail", "yahoo", "hotmail", "net", "org", "comcast", "sbcglobal", "tld_cn", "tld_co", "tld_gr", "tld_coop"]
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