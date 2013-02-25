Pony.options = {:to => 'charlie@charliepark.org', :from => 'charlie@charliepark.org', :subject => 'Fat Fingers report'}

post '/oops' do
  @bad_email = params[:email]
  @message = "Someone tested `#{@bad_email}` at the Fat Fingers demo page, and it apparently didn't work well.\n\n\n'#{@bad_email}.'clean_up_typoed_email => #{@bad_email.clean_up_typoed_email}."
  Pony.mail(:body => @message)
  redirect to '/oops'
end

get '/oops' do
  erb :oops
end

get '/:email?' do
  @broken_examples = [" test@something.com", "TEST@SOMETHING.COM", "te st@something.com", "te'st@something.com", "test\#@something.com", "test@#something.com", "test@#something.com", "test@@something.com", "test@aho.com", "test@ahoo.com", "test@ahoo.com", "test@comacast.net", "test@comcastn.et", "test@comcat.net", "test@gamil.co.uk", "test@gamil.com", "test@gmaal.co.uk", "test@gmaal.com", "test@gmai.co.uk", "test@gmai.com", "test@gmailc.om", "test@gmaill.co.uk", "test@gmaill.com", "test@gmal.co.uk", "test@gmal.com", "test@gmali.co.uk", "test@gmali.com", "test@gmial.co.uk", "test@gmial.com", "test@gmil.co.uk", "test@gmil.com", "test@gmila.co.uk", "test@gmila.com", "test@gnail.co.uk", "test@gnail.com", "test@hotmaill.com", "test@hptmail.com", "test@htomali.com", "test@sbcgloba.net", "test@something,com", "test@something..com", "test@something.c0m", "test@something.cm", "test@something.cmo", "test@something.cmo", "test@something.co,", "test@something.co,", "test@something.co<", "test@something.coim", "test@something.cok", "test@something.colm", "test@something.com\"", "test@something.com'", "test@something.com,", "test@something.com.", "test@something.com\\", "test@something.comj", "test@something.comm", "test@something.comme", "test@something.comn", "test@something.con", "test@something.conm", "test@something.coom", "test@something.coom", "test@something.copm", "test@something.cpm", "test@something.et", "test@something.ne", "test@something.nett", "test@something.nt", "test@something.nte", "test@something.ocm", "test@something.og", "test@something.ogr", "test@something.om", "test@something.or", "test@something.orgg", "test@something.vom", "test@something.xom", "test@somethingc.om", "test@somethingcom", "test@somethingnet", "test@somethingorg", "test@yaho.com", "test@yahooc.om", "test@yahooo.com", "test@yao.com", "test@yaooo.com", "test@yhao.com", "test@yhaoo.com", "test@yho.com", "test@yhooo.com"]
  @not_broken_examples = ["te.st@gmail.com", "test\+spamfilter@gmail.com", "test@gm.com", "test@gmail.couk", "test@something.cn", "test@something.co", "test@something.coop", "test@something.gr", "test@something.net"]
  if params[:email] and params[:email].length > 0
    @email = URI::decode(params[:email])
    Pony.mail(:body => "Someone ran an e-mail through the Fat Fingers demo; #{@email} => #{@email.clean_up_typoed_email}")
  else
    @email = @broken_examples.sample
  end
  erb :index
end

enable :inline_templates

__END__

@@ layout
<!DOCTYPE html>
<html>
  <head>
    <style type="text/css">
      /* from Eric Meyer: v1.0 | 20080212 */
      html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, font, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td{background:transparent;border:0;font-size:100%;font-weight:inherit;margin:0;outline:0;padding:0;text-decoration:none;vertical-align:baseline}
      body{line-height:1}
      ol, ul{list-style:none}
      blockquote, q{quotes:none}
      blockquote:before,blockquote:after,q:before,q:after{content:'';content:none}
      /* remember to define focus styles! */
      :focus{outline:0}
      /* remember to highlight inserts somehow! */
      ins{text-decoration:none}
      del{text-decoration:line-through}
      table{border-collapse:collapse;border-spacing:0}
      /* end of Eric Meyer's CSS Reset */
      a{color:inherit;opacity:.5;text-decoration:none;}
      body{font-size:20px;font-family:'Arial Rounded MT Bold','Miso','helvetica neue', sans-serif;margin:100px auto;text-align:center;width:960px;}
      form{margin:20px 0;}
      #examples a{border-bottom:1px solid #ccc;color:red;font-size:16px;line-height:30px;display:inline-block;text-decoration:none;width:200px}
      #examples{clear:both;margin:80px auto;padding-top:20px;width:800px}
      h2{font-size:20px;}
      p.result{font-size:40px}
      .email{background: #ccc;border-radius:10px;padding:10px;}
      .example-title{padding:40px 0 20px}
      .give-it-a-shot{background:#ccc;border:none;font-size:30px;width:480px}
      .header-text{background:#222;color:#fff;font-size:50px;line-height:80px;margin:0;padding:30px 0;}
      .looks-good-try-again{background:#333;color:#fff;margin-top:4px;padding:20px 0 10px}
      .microcopy{font-size:14px;padding:0 0 10px}
      .oh-snap-button{background:#222;border-color:gray;border-radius:10px;border-width:1px;box-shadow:0 2px 10px #000;color:#ccc; cursor: pointer;font-size:16px;padding:10px 30px}
      .oh-snap-report-it{background:#444;color:#fff;margin-top:4px;padding:20px 0 10px}
      .result-email{background:rgba(255,255,255,0.2)}
      .test-email{background:rgba(255,255,255,0.2)}
      .title-action{font-size:24px;line-height:40px}
    </style>
  </head>
  <body>
    <%= yield %>
  </body>
</html>

@@ index
    <p class='header-text'>Running <span class="test-email email"><%= @email %></span><br>
      through <a href='http://rubygems.org/gems/fat_fingers'>Fat Fingers</a><br>
      gives us <span class="result-email email"><%= @email.clean_up_typoed_email %></span></p>

    <div class="looks-good-try-again">
      <h3 class='title-action'>Look good? Try another!</h3>
      <p>Enter an e-mail to see how Fat Fingers would handle it: <form action='/'><input class='give-it-a-shot' name='email' autofocus /></form>
      <p class="microcopy">Examples: <a href="../?email=test@something.cpm">test@something.cpm</a>, <a href="../?email=test@gmal.com">test@gmal.com</a>, <a href="../?email=test@yahoo.cmo">test@yahoo.cmo</a></p>
    </div>
    <div class="oh-snap-report-it">
      <h3 class='title-action'>Look broken? Report it!</h3>
      <p>Just poke this button and we&rsquo;ll get the bad news:</p>
      <form action="/oops">
        <input type="hidden" name="email" value="<%= @email %>">
        <button class="oh-snap-button">Oh, sad.<br>Fat Fingers seems to handle <br>'<%= @email %>' poorly.</button>
      </form>
    </div>

  <div id="examples">
    <h2 class='example-title'>Examples That Fat Fingers Should Fix</h2>
    <% @broken_examples.shuffle.each do |email| %><%= "<a href='../?email=#{email.gsub('+', '%2B')}'>#{email}</a>" %><% end %>

    <h2 class='example-title'>Examples That Fat Fingers Should Leave Alone</h2>
    <% @not_broken_examples.shuffle.each do |email| %><%= "<a href='../?email=#{email.gsub('+', '%2B')}'>#{email}</a>" %><% end %>
  </div>


@@ oops
  <p>Oh, man. Sorry that didn&rsquo;t work right. Thanks for reporting it.</p>

  <p style="padding-top:20px">If you have any additional comments,<br>
    just e-mail them to charlie@charliepark.org.</p>

  <p style="padding-top:20px">Or you can always try to <a href="https://github.com/charliepark/fat_fingers">fork the code at GitHub</a><br >
    and tweak it on your own, if you like.</p>

  <p style="padding-top:20px">Thanks again.</p>

  <p style="padding-top:40px">Want to <a href="/">try another e-mail</a>?</p>
