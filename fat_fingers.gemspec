Gem::Specification.new do |s|
  s.name         = "fat_fingers"
  s.version      = "0.1.3"
  s.date         = "2013-02-21"
  s.summary      = "Clean up e-mail strings when the user's made a typo (like 'gmail.cmo')."
  s.description  = "Makes sure users don't accidentally create an account for the wrong e-mail address. Because 'gmial' isn't actually what they meant to type. Similarly, 'yaho.com', or the strange-but-true '.c0m'. Not even making that one up. If you're concerned about false-positives, it's super-easy to check. There's only a single method. Also, it's fully-tested."
  s.author       = "Charlie Park"
  s.email        = "charlie@charliepark.org"
  s.files        = "lib/fat_fingers.rb"
  s.require_path = "lib"
  s.homepage     = "http://github.com/charliepark/fat_fingers"
  s.platform     =  Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.9.2"
  s.test_files   = "test/test_fat_fingers.rb"
end