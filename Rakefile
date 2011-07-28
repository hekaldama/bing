# -*- ruby -*-

require 'rubygems'
require 'hoe'

Hoe.plugin :isolate

require 'isolate/rake'

Hoe.spec 'bing' do
  developer('Adam Avilla', 'adam@avil.la')

  self.testlib = :minitest

  self.extra_deps << ['net-http-persistent', '1.8']
  self.extra_deps << ['json', '~> 1.4.6']

  self.extra_dev_deps << ['minitest']
  self.extra_dev_deps << ['webmock']
  self.extra_dev_deps << ['ZenTest']

  # make sure we use the gemmed minitest on 1.9
  self.test_prelude = 'gem "minitest"'
end

desc "run irb with bing loaded and happy"
task :irb do
  sh "irb -Ilib -rbing -rbing/location"
end

desc 'run autotest'
task :autotest do
  sh "rake isolate:sh[autotest]"
end

# vim: syntax=ruby
