gem 'minitest'
require 'minitest/autorun'
#require 'fat_fingers'
require './lib/fat_fingers.rb'

class StringTest < MiniTest::Unit::TestCase
  def setup
    @good_gmail = "test@gmail.com"
    @bad_gmail = [
      "test@gmai.com",
      "test@gmaii.com",
      "test@gmal.com",
      "test@gmaal.com",
      "test@gmaol.com",
      "test@gmaul.com",
      "test@gmil.com",
      "test@gmial.com",
      "test@gmali.com",
      "test@gmila.com",
      "test@gmaill.com",
      "test@gamil.com",
      "test@gnail.com",
      "test@gmailc.om",
      "test.@gmail.com",
      "test.@gmail.co",
      "test@gmail.net"
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
      "test@gmail.co.um",
      "test@gmail.o.uk",
      "test@gmail.couk"
      ]

    @good_googlemail = "test@googlemail.com"
    @bad_googlemail = [
      "test@googlemai.com",
      "test@googlemaii.com",
      "test@googlemal.com",
      "test@googlemaal.com",
      "test@googlemil.com",
      "test@googlemial.com",
      "test@googlemali.com",
      "test@googlemila.com",
      "test@googlemaill.com",
      "test@googleamil.com",
      "test@googlenail.com",
      "test@googlemailc.om",
      "test.@googlemail.com",
      "test.@googlemail.co",
      "test.@gogglemaii.com",
      "test.@gogglemail.com",
      "test.@gogolemail.com",
      "test.@goooglemail.com",
      "test@goooglemail.net"
      ]

    @good_yahoo = "test@yahoo.com"
    @bad_yahoo = [
      "test@aho.com",
      "test@ahoo.com",
      "test@ahoo.com",
      "test@uahoo.com",
      "test@yaho.com",
      "test@yahooo.com",
      "test@yhao.com",
      "test@yhaoo.com",
      "test@yho.com",
      "test@yhooo.com",
      "test@yao.com",
      "test@yaooo.com",
      "test@yahooc.om",
      "test@yahoo.co",
      "test@yahoo.net"
      ]

    @good_hotmail = "test@hotmail.com"
    @bad_hotmail = [
      "test@hotamail.com",
      "test@htmail.com",
      "test@hotmaill.com",
      "test@hotmaik.com",
      "test@hoymail.com",
      "test@hptmail.com",
      "test@hitmail.com",
      "test@hotnail.com",
      "test@htomali.com",
      "test@homtail.com",
      "test@hotmail.co",
      "test@hotmail.net"
      ]

    @good_aol = "test@aol.com"
    @bad_aol = [
      "test@aol.cm",
      "test@ail.cm",
      "test@ol.com",
      "test@ao.com",
      "test@aol.co",
      "test@aol.net"
    ]

    @good_com = "test@something.com"
    @bad_com = [
      "test@somethingc.om",
      "test@something.coom",
      "test@something.comm",
      "test@something.comme",
      "test@something.co,", # assume that someone entering this in *meant* to type in '.com'
      "test@something.co.",
      "test@something.co<",
      "test@something.co>",
      "test@something.cmo",
      "test@something.cm",
      "test@something.om",

      "test@something.c0m",
      "test@something.coim",
      "test@something.cok",
      "test@something.colm",
      "test@something.clom",
      "test@something.comj",
      "test@something.comn",
      "test@something.con",
      "test@something.conm",
      "test@something.coom",
      "test@something.copm",
      "test@something.cpm",
      "test@something.ocm",
      "test@something.vom",
      "test@something.xom",

      "test@something.com'",
      "te'st@something.com",
      "test@something.com\"",
      "test@something.com\\",
      "test@something.com,",
      "test@something.com.",
      "test@something,com",
      "test@\#something.com",
      "test@#something.com",
      "test@@something.com",
      "test\#@something.com",
      "test@something..com",
      "test@somethingcom",
      "test.@something.com",
      "test@.something.com",

      "te st@something.com",
      " test@something.com",
      "test@something.com ",
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
      "test@comcastt.net",
      "test@comcat.net",
      "test@concast.net",
      "test@cmcast.net"
      ]

    @good_sbcglobal = "test@sbcglobal.net"
    @bad_sbcglobal = [
      "test@sbcgloball.net",
      "test@sbcgloba.net",
      "test@sbcglobl.net",
      "test@sbcgobal.net",
      "test@sbglobal.net"
      ]

    @good_icloud = "test@icloud.com"
    @bad_icloud = [
      "test@icoud.com",
      "test@icloud.co",
      "test@icloud.net"
      ]

    @good_outlook = "test@outlook.com"
    @bad_outlook = [
      "test@outloo.com",
      "test@outlook.co",
      "test@outlook.net"
      ]

    @good_verizon_net = "test@verizon.net"
    @bad_verizon_net = [
      "test@verizon.net",
      "test@veizon.net",
      "test@verion.net",
      "test@verzon.net"
      ]

    @good_tld_jp = "test@something.co.jp"
    @bad_tld_jp = [
      "test@something.co.lp",
      "test@something.cojp"
      ]


    # test that good address don't trip as false-positives

    @good_gm = "test@gm.com"
    @good_gmail_with_dots = "te.st@gmail.com"
    @good_gmail_with_plus = "test+spamfilter@gmail.com"
    @good_tld_cn = "test@something.cn"
    @good_tld_co = "test@something.com.co"
    @good_random_co = "test@something.co"
    @good_tld_gr = "test@something.gr"
    @good_tld_coop = "test@something.coop"
    @good_aol_com = "test@aol.com"
    @good_att_net = "test@att.net"
    @good_facebook_com = "test@facebook.com"
    @good_gmx_com = "test@gmx.com"
    @good_googlemail_com = "test@googlemail.com"
    @good_hotmail_co_uk = "test@hotmail.co.uk"
    @good_live_com = "test@live.com"
    @good_mac_com = "test@mac.com"
    @good_mail_com = "test@mail.com"
    @good_me_com = "test@me.com"
    @good_msn_com = "test@msn.com"
    @good_yahoo_co_uk = "test@yahoo.co.uk"
    @good_ya_ru = "test@ya.ru"
    @good_ymail_com = "test@ymail.com"
    @good_mil = "test@army.mil"
    @good_comcastbiz_net = "test@anything.comcastbiz.net"

    @all_tlds_fat_fingers_works_with = %w(ac ad ae af ag ai al am an ao aq ar as at au aw ax az ba bb bd be bf bg bh bi bj bm bn bo br bs bt bv bw by bz ca cc cd cf cg ch ci ck cl cn co cr cs cu cv cx cy cz dd de dj dk dm do dz ec ee eg eh er es eu fi fjfk fm fo fr ga gb gd ge gf gg gh gi gl gm gn gp gq gr gs gt gu gw gy hk hm hn hr ht hu id ie il im in io iq ir is it je jm jo jp ke kg kh ki km kn kp kr kw ky kz la lb lc li lk lr ls lt lu lv ly ma mc md me mg mh mk ml mn mp mq mr ms mt mu mv mw mx my mz na nc nf ng ni nl no np nr nu nz pa pe pf pg ph pk pl pm pn pr ps pt pw py qa re ro rs ru rw sa sb sc sd se sg sh si sj sk sl sm sn so sr ss st su sv sx sy sz tc td tf tg th tj tk tl tm tn to tp tr tt tv tw tz ua ug uk us uy uz va vc ve vg vi vn vu wf ws ye yt yu za zm zw aero asia biz cat com coop info int jobs mobi museum name net org post pro tel travel xxx edu gov mil)
    @tlds_fat_fingers_gets_tripped_on = %w(cm et ne om)
  end

  def cases
    [ "aol", "aol_com", "att_net", "com", "comcast", "comcastbiz_net", "facebook_com", "googlemail", "gm", "gmail", "gmail_with_dots", "gmail_with_plus", 
      "gmx_com", "googlemail_com", "hotmail", "hotmail_co_uk", "icloud", "intl_gmail", "live_com", "mac_com", "mail_com", "me_com", 
      "mil", "msn_com", "net", "org", "outlook", "random_co", "sbcglobal", "tld_cn", "tld_co", "tld_coop", "tld_gr", "tld_jp", 
      "verizon_net", "ya_ru", "yahoo", "yahoo_co_uk", "ymail_com" ]
  end

  def test_that_emails_get_fixed
    i = 1
    cases.each do |test|
      if eval("@bad_"+test)
        eval("@bad_"+test).each do |email|
          unless email.clean_up_typoed_email == (processed = eval("@good_"+test))
            puts "#{i} - Failed on '#{email}'"
          end
          assert_equal eval("@good_"+test), email.clean_up_typoed_email
          i += 1
        end
      end
    end
  end

  def test_that_good_emails_do_not_get_broken
    cases.each do |test|
      assert_equal eval("@good_"+test), eval("@good_"+test).clean_up_typoed_email
    end
  end

  def test_that_tlds_do_not_get_broken
    @all_tlds_fat_fingers_works_with.each do |tld|
      assert_equal "test@something.#{tld}", "test@something.#{tld}".clean_up_typoed_email
    end
  end

  def test_the_four_obscure_tlds_fat_fingers_doesnt_work_with
    @tlds_fat_fingers_gets_tripped_on.each do |tld|
      refute_equal "test@something.#{tld}", "test@something.#{tld}".clean_up_typoed_email
    end
  end
end