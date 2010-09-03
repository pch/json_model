require "bundler"
Bundler.setup

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts  = %w(-fs --color)
  t.warning    = true
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('spec:rcov') do |t|
  t.spec_opts  = ["-cfs"]
  t.rcov = true
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov_opts = ['--exclude spec,/home']
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "json_model #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

gemspec = eval(File.read("json_model.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["json_model.gemspec"] do
  system "gem build json_model.gemspec"
  system "gem install json_model-#{JsonModel::VERSION}.gem"
end
