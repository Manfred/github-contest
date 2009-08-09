$:.unshift File.expand_path('../../lib', __FILE__)
require 'observation'
require 'plsa'
require 'hash'

require 'rubygems' rescue nil
require 'test/unit'

$:.unshift File.expand_path('../../spec/helpers', __FILE__)
require 'tempfiles'

$:.unshift File.expand_path('../helpers', __FILE__)
require 'examples'