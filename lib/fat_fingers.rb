class String

  # Internal: Check a given string for misspelled TLDs and misspelled domains from popular e-mail providers.
  #
  # Examples
  #
  #   "joe@gmail.cmo".clean_up_typoed_email
  #   # => "joe@gmail.com"
  #
  #   "joe@yaho.com".clean_up_typoed_email
  #   # => "joe@yahoo.com"
  #
  # Returns the cleaned String.
  def clean_up_typoed_email
    downcase.
    remove_mailto.
    remove_invalid_characters.
    fix_transposed_periods.
    remove_period_around_at_sign.
    handle_different_country_tlds.
    fix_coms_with_appended_letters.
    clean_up_funky_coms.
    clean_up_funky_nets.
    clean_up_funky_orgs.
    clean_up_gmail.
    clean_up_googlemail.
    clean_up_hotmail.
    clean_up_aol.
    clean_up_yahoo.
    clean_up_other_providers.
    clean_up_known_coms.
    add_a_period_if_they_forgot_it
  end

protected

  def remove_mailto
    gsub(/\Amailto:/, "")
  end

  def remove_invalid_characters
    gsub(/(\s|\#|\'|\"|\\)*/, "").
    gsub(/(\,|\.\.)/, ".").
    gsub("@@", "@")
  end

  def fix_transposed_periods
    gsub(/c\.om$/, ".com").
    gsub(/n\.et$/, ".net")
    # can't do "o.gr" => ".org", as ".gr" is a valid TLD
  end

  def remove_period_around_at_sign
    gsub(/(\.@|@\.)/, "@")
  end

  def handle_different_country_tlds
    gsub(/\.(o\.uk|couk|co\.um)$/, ".co.uk").
    gsub(/\.(cojp|co\.lp)$/, ".co.jp")
  end

  def fix_coms_with_appended_letters
    gsub(/\.co[mn]\.com/, ".com").
    gsub(/\.com\.$/, ".com").
    gsub(/\.com(?!cast|\.|@).{1,3}$/, ".com"). # fix up to three extra letters after .com as long as they're not .comcast or .com.* (and as long as they're not before the @)
    gsub(/\.co[^op]$/, ".com")
  end

  def clean_up_funky_coms
    gsub(/\.c*(c|ci|coi|l|m|n|o|op|cp|0|9)*m+o*$/,".com").
    gsub(/\.(c|v|x|f)o+(m|n)$/,".com")
  end

  def clean_up_funky_nets
    gsub(/\.(nte*|n*et*)$/, ".net")
  end

  def clean_up_funky_orgs
    gsub(/\.og?r?g{0,2}$/, ".org") # require the o, to not false-positive .gr e-mails
  end

  def clean_up_googlemail
    gsub(/@go{0,3}g{0,2}o?le?[mn]?[ail]{1,2}m?[aikl]{0,3}\./,"@googlemail.")
  end

  def clean_up_gmail
    gsub(/@g[nm]{0,2}s?[ail]{1,2}[aiklmou]{0,3}\.(?!gov)/,"@gmail.") # match a broad variety of mispellings of gmail, but not if it's .gov
  end

  def clean_up_hotmail
    gsub(/@h(i|o|p)?y?t?o?a?m?n?t?[aikl]{1,3}l?\./,"@hotmail.")
  end

  def clean_up_yahoo
    gsub(/@(ya|yh|ua|ah)+h*a*o+\./,"@yahoo.")
  end

  def clean_up_aol
    gsub(/@(ol|ao|ail)\./,"@aol.")
  end

  def clean_up_other_providers
    gsub(/@co?(m|n)a?cas?t{0,2}\./,"@comcast.").
    gsub(/@sbc?gl?ob[al]{0,2}l?\./, "@sbcglobal.").
    gsub(/@ver?i?z?on\./,"@verizon.").
    gsub(/@icl{0,2}oud\./,"@icloud.").
    gsub(/@outl?ook?\./,"@outlook.")
  end

  def clean_up_known_coms
    gsub(/(aol|googlemail|gmail|hotmail|yahoo|icloud|outlook)\.(co|net|org)$/, '\1.com')
  end

  def add_a_period_if_they_forgot_it
    gsub(/([^\.])(com|org|net)$/, '\1.\2')
  end

end