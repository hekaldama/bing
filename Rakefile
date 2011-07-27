# -*- ruby -*-

require 'rubygems'
require 'hoe'

Hoe.plugin :isolate

Hoe.spec 'bing' do
  developer('Adam Avilla', 'adam@avil.la')

  self.extra_deps << ['net-http-persistent', '1.8' ]

  self.extra_dev_deps << ['minitest'] unless RUBY_VERSION =~ /1.9/
end

# vim: syntax=ruby
