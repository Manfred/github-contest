$:.unshift File.expand_path('../../lib', __FILE__)
require 'recommender'
require 'observation'
require 'users'
require 'plsa'
require 'hash'


require 'rubygems' rescue nil
require 'test/spec'

$:.unshift File.expand_path('../helpers', __FILE__)
require 'fixtures'
require 'tempfiles'
