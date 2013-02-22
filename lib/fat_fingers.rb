class String

  # Internal: Check a string for misspelled TLDs and misspelled domains from popular e-mail providers.
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
    downcase.gsub(/(\s|\#|\'|\"|\\)*/, "")
    .gsub(/(\,|\.\.)/, ".")
    .gsub(/c\.om$/, ".com")
    .gsub(/n\.et$/, ".net")
    .gsub(/\.com(.)*$/, ".com")
    .gsub(/\.co[^op]$/, ".com")
    .gsub(/\.*$/, "")
    .gsub(/\.c*(c|i|l|m|n|o|p|0)*m+o*$/,".com")
    .gsub(/\.(c|v|x)o+(m|n)$/,".com")
    .gsub(/\.n*t*e*t*$/, ".net")
    .gsub(/\.og*r*g*$/, ".org") #require the o, to not false-positive .gr e-mails
    .gsub(/@coma*cas*t.net/,"@comcast.net")
    .gsub(/@sbcgloba.net/, "@sbcglobal.net")
    .gsub(/@g(n|m)*i*a*m*l*i*l*a*\./,"@gmail.")
    .gsub(/@y*a*h*a*o*\./,"@yahoo.")
    .gsub(/@h(o|p)*to*m*i*a*l*i*l*a*\./,"@hotmail.")
    .gsub(/([^\.])(com|org|net)$/, '\1.\2')
    
  end

end