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
  self.extra_dev_deps << ['git']
  self.extra_dev_deps << ['webmock']
  self.extra_dev_deps << ['ZenTest']

  # make sure we use the gemmed minitest on 1.9
  self.test_prelude = 'gem "minitest"'
end

desc 'run autotest'
task :autotest do
  sh "rake isolate:sh[autotest]"
end

desc "run irb with bing lib in path."
task :irb do
  ARGV.clear
  $: << "lib"

  require 'irb'
  require 'bing'

  IRB.start
end

desc "create Manifest.txt with git-ls-files."
task :create_manifest do
  sh "git ls-files > Manifest.txt"
end

namespace :git do

  desc "Generate a changelog for a given release."
  task :changelog do
    begin
      require 'rubygems'
      require 'git'
    rescue LoadError
    end

    from     = ENV['since']
    to       = ENV['until'] || 'HEAD'
    codes    = {"!" => :major, "+" => :minor, "-" => :bug}
    $changes = Hash.new {|h,k| h[k] = Array.new}

    def changelog_section(code)
      name = {
        :major => "major enhancement(s)",
        :minor => "minor enhancement(s)",
        :bug   => "bug fix(s)",
        :huh?  => "unknown",
      }[code]

      puts "* #{$changes[code].size} #{name}:"
      puts
      $changes[code].sort.each do |line|
        puts "  * #{line}"
      end
      puts
    end

    git = Git.open(".")
    git.log(nil).between(from, to).each do |log|
      log.message.each_line do |msg|
        if msg.match(/^([#{Regexp.escape(codes.keys.join)}])\s*(.*)/)
          code, line = codes[$1], $2
          $changes[code] << line
        else
          next if msg =~ /git-svn-id|^\s*$/
          $changes[:huh?] << msg
        end
      end
    end

    changelog_section :major
    changelog_section :minor
    changelog_section :bug
    changelog_section :huh?
  end

end

# vim: syntax=ruby
