# -*- ruby -*-

require 'rubygems'
require 'hoe'

Hoe.plugin :isolate
Hoe.plugin :minitest

Hoe.spec 'isolate-git' do
  developer 'Brian Henderson', 'henderson.bj@gmail.com'

  dependency "isolate", "~> 3.2.2"
end

$:.unshift 'lib'
require 'isolate/git'

# vim: syntax=ruby
