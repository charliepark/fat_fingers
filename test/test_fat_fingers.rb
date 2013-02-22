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
      "test@gnail.com",
      "test@gmailc.om"
      ]

    @good_intl_gmail = "test@gmail.co.uk"
    @bad_intl_gmail = [
      "test@gmai.co.uk",
      "test@gmal.co.uk",
      "test@gmaal.co.uk",
      "test@gmil.co.uk",
      "test@gmial.co.uk",
      "test@gmali.co.uk",
      "test@gmila.co.uk",
      "test@gmaill.co.uk",
      "test@gamil.co.uk",
      "test@gnail.co.uk",
      ]

    @good_yahoo = "test@yahoo.com"
    @bad_yahoo = [
      "test@aho.com",
      "test@ahoo.com",
      "test@ahoo.com",
      "test@yaho.com",
      "test@yahooo.com",
      "test@yhao.com",
      "test@yhaoo.com",
      "test@yho.com",
      "test@yhooo.com",
      "test@yao.com",
      "test@yaooo.com",
      "test@yahooc.om",
      ]

    @good_hotmail = "test@hotmail.com"
    @bad_hotmail = [
      "test@hotmaill.com",
      "test@hptmail.com",
      "test@htomali.com"
      ]

    @good_com = "test@something.com"
    @bad_com = [
      "test@somethingc.om",
      "test@something.coom",
      "test@something.comm",
      "test@something.comme",
      "test@something.co,",
      "test@something.co<",
      "test@something.cmo",
      "test@something.cm",
      "test@something.om",

      "test@something.ocm",
      "test@something.con",
      "test@something.cmo",
      "test@something.copm", 
      "test@something.xom",
      "test@something.vom",
      "test@something.comn",
      "test@something.comj",
      "test@something.coim",
      "test@something.cpm",
      "test@something.colm",
      "test@something.conm",
      "test@something.coom",
      "test@something.c0m",

      "test@something.com'",
      "te'st@something.com",
      "test@something.com\"",
      "test@something.com\\",
      "test@something.com,",
      "test@something.com.",
      "test@something,com",
      "test@#something.com",
      "test\#@something.com",
      "test@something..com",
      "test@somethingcom",

      "te st@something.com",
      "TEST@SOMETHING.COM"

      ]

    @good_net = "test@something.net"
    @bad_net = [
      "test@something.nt",
      "test@something.ne",
      "test@something.et",
      "test@something.nte",
      "test@something.nett",
      "test@something.net",
      "test@somethingnet"
      ]

    @good_org = "test@something.org"
    @bad_org = [
      "test@something.or",
      "test@something.og",
      "test@something.ogr",
      "test@something.orgg",
      "test@somethingorg"
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
    ["gmail", "intl_gmail", "yahoo", "hotmail", "com", "net", "org", "comcast", "sbcglobal", "tld_cn", "tld_co", "tld_gr", "tld_coop"]
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