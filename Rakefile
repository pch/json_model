require 'rubygems'
require 'rake'
require 'spec/rake/spectask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "json_model"
    gem.summary = "ActiveRecord replacement for pure JSON models"
    gem.description = "ActiveRecord replacement for pure JSON models"
    gem.email = "piotr@chmolowski.pl"
    gem.homepage = "http://github.com/pchm/json_model"
    gem.authors = ["Piotr Chmolowski"]
    # gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

desc "Run all examples" 
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts  = ["-cfs"]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "json_model #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
