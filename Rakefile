begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "dwe_loader"
    gem.summary = "Entry point for JAVA STDW engine."
    gem.description = "Entry point for JAVA STDW engine. Allows to use STDW engine from any JRuby application."
    gem.email = "marek.kowalcze@gmail.com"
    gem.homepage = ""
    gem.authors = ["Marek Kowalcze"]
    gem.files = FileList['lib/**/*.rb']
    gem.require_path = 'lib'
    gem.test_files = []
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

desc 'rebuild the gem'
task :rebuild => :build do
  puts "Rebuilding the gem.."  
  begin
    system('gem uninstall dwe_loader')
    version_file = File.open("VERSION", "rb")
    system("gem install pkg/dwe_loader-#{version_file.read}.gem")
  rescue
    puts "something went wrong..."
  end
end