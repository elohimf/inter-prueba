require "rubygems"
require "bundler"
Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)
set :root, "..{File.dirname(__FILE__)}"
