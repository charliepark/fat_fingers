task :default => [:test]

desc "Run the tests"
task :test do
  ruby "test/test_fat_fingers.rb"
end

desc "Move, Increment, Build, Push"
task :gem do
  require 'fileutils'

  gems = Dir["./*.gem"]
  gems.each{|g| FileUtils.mv(g, 'old_gems')}

  lines = []
  file = File.open("./fat_fingers.gemspec", "r")
  file.each_line do |line|
    if line.include?("s.version")
      version_array = line.split('"')[1].split(".")
      version_array[2] = (version_array[2].to_i + 1).to_s
      @new_version = version_array.join(".")
      line = '  s.version      = "'+@new_version+'"'+"\n"
      puts "Upgrading gem to version "+@new_version
    end
    lines << line
  end
  file.close
  File.open("./fat_fingers.gemspec", "w") {|file| file.write(lines.join) }

  system "gem build fat_fingers.gemspec"

  system "gem push fat_fingers-#{@new_version}.gem"
end