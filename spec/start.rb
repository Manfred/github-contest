$:.unshift File.expand_path('../../lib', __FILE__)
require 'observation'
require 'plsa'

require 'rubygems' rescue nil
require 'test/spec'

$:.unshift File.expand_path('../helpers', __FILE__)
require 'fixtures'
