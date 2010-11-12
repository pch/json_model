$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require "bundler"
Bundler.setup

require "json_model"
require "active_model"
require File.dirname(__FILE__) + '/fixtures.rb'