gem 'minitest'
require 'minitest/autorun'
require './lib/fat_fingers.rb'

class StringTest < MiniTest::Unit::TestCase
  def setup

    # examples of email typos that should be fixed
    @replacement_examples = [
      # gmail.com
      { good: "test@gmail.com",
        bad: [
          "test@gmai.com",
          "test@gmaii.com",
          "test@gmal.com",
          "test@gmaal.com",
          "test@gmaol.com",
          "test@gmaul.com",
          "test@gmil.com",
          "test@gmsil.com",
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
      },
      # gmail.co.uk
      { good: "test@gmail.co.uk",
        bad: [
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
      },
      # googlemail.com
      { good: "test@googlemail.com",
        bad: [
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
      },
      # yahoo.com
      { good: "test@yahoo.com",
        bad: [
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
      },
      # hotmail.com
      { good: "test@hotmail.com",
        bad: [
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
          "test@hotmail.net",
          "test@hotmail.vcom"
        ]
      },
      # aol.com
      { good: "test@aol.com",
        bad: [
          "test@aol.cm",
          "test@ail.cm",
          "test@ol.com",
          "test@ao.com",
          "test@aol.co",
          "test@aol.net"
        ]
      },
      # comcast.net
      { good: "test@comcast.net",
        bad: [
          "test@comacast.net",
          "test@comcastn.et",
          "test@comcastt.net",
          "test@comcat.net",
          "test@concast.net",
          "test@cmcast.net"
        ]
      },
      # sbcglobal.net
      { good: "test@sbcglobal.net",
        bad: [
          "test@sbcgloball.net",
          "test@sbcgloba.net",
          "test@sbcglobl.net",
          "test@sbcgobal.net",
          "test@sbglobal.net"
        ]
      },
      # icloud.com
      { good: "test@icloud.com",
        bad: [
          "test@icoud.com",
          "test@icloud.co",
          "test@icloud.net",
          "test@iclod.com",
          "test@iclud.com",
          "test@icld.com"
        ]
      },
      # outlook.com
      { good: "test@outlook.com",
        bad: [
          "test@outloo.com",
          "test@outlook.co",
          "test@outlook.net"
        ]
      },
      # verizon.net
      { good: "test@verizon.net",
        bad: [
          "test@verizon.net",
          "test@veizon.net",
          "test@verion.net",
          "test@verzon.net"
        ]
      },
      # generic .com
      { good: "test@something.com",
        bad: [
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
          "test@something.ckm",
          "test@something.ocm",
          "test@something.vom",
          "test@something.xom",
          "test@something.fom",
          "test@something.con.com",
          "test@something.com.com",
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
          "TEST@SOMETHING.COM",
          "test@something.c9m",
          "mailto:test@something.com",
          "test@something.vcom",
          "test@something.xcom"
        ]
      },
      # generic .net
      { good: "test@something.net",
        bad: [
          "test@something.nt",
          "test@something.ne",
          "test@something.et",
          "test@something.nte",
          "test@something.nett",
          "test@something.net",
          "test@somethingnet"
        ]
      },
      # generic .org
      { good: "test@something.org",
        bad: [
          "test@something.or",
          "test@something.og",
          "test@something.ogr",
          "test@something.orgg",
          "test@somethingorg"
        ]
      },
      # generic .co.jp
      { good: "test@something.co.jp",
        bad: [
          "test@something.co.lp",
          "test@something.cojp"
        ]
      }
    ]


    # test that good address don't trip as false-positives
    @good_examples = [
      "test@gm.com",
      "te.st@gmail.com",
      "test.com@gmail.com",
      "test.comisky@gmail.com",
      "test+spamfilter@gmail.com",
      "test@gmx.com",
      "test@gao.gov",
      "test@gial.edu",
      "test@googlemail.com",
      "test@something.cn",
      "test@something.com.co",
      "test@something.co",
      "test@something.gr",
      "test@something.coop",
      "test@aol.com",
      "test@att.net",
      "test@facebook.com",
      "test@hotmail.co.uk",
      "test@live.com",
      "test@mac.com",
      "test@mail.com",
      "test@me.com",
      "test@msn.com",
      "test@yahoo.co.uk",
      "test@ya.ru",
      "test@ymail.com",
      "test@army.mil",
      "test@anything.comcast.com",
      "test@anything.comcastbiz.net",
      "test@dogmail.net",
      "test@engaol.net"
    ]


    @all_tlds_fat_fingers_works_with = %w(ac ad ae af ag ai al am an ao aq ar as at au aw ax az ba bb bd be bf bg bh bi bj bm bn bo br bs bt bv bw by bz ca cc cd cf cg ch ci ck cl cn co cr cs cu cv cx cy cz dd de dj dk dm do dz ec ee eg eh er es eu fi fjfk fm fo fr ga gb gd ge gf gg gh gi gl gm gn gp gq gr gs gt gu gw gy hk hm hn hr ht hu id ie il im in io iq ir is it je jm jo jp ke kg kh ki km kn kp kr kw ky kz la lb lc li lk lr ls lt lu lv ly ma mc md me mg mh mk ml mn mp mq mr ms mt mu mv mw mx my mz na nc nf ng ni nl no np nr nu nz pa pe pf pg ph pk pl pm pn pr ps pt pw py qa re ro rs ru rw sa sb sc sd se sg sh si sj sk sl sm sn so sr ss st su sv sx sy sz tc td tf tg th tj tk tl tm tn to tp tr tt tv tw tz ua ug uk us uy uz va vc ve vg vi vn vu wf ws ye yt yu za zm zw aero asia biz cat com coop info int jobs mobi museum name net org post pro tel travel xxx edu gov mil)
    @tlds_fat_fingers_gets_tripped_on = %w(cm et ne om)
  end


  def test_that_emails_get_fixed
    @replacement_examples.each do |example|
      example[:bad].each do |email|
        # puts "- Failed on '#{email}'. Expected #{example[:good]}" if example[:good] != email.clean_up_typoed_email
        assert_equal example[:good], email.clean_up_typoed_email
      end
    end
  end

  def test_that_false_positives_dont_get_tripped
    @good_examples.each do |email|
      assert_equal email, email.clean_up_typoed_email
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
