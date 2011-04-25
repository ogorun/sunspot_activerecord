# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sunspot_activerecord/version"

Gem::Specification.new do |s|
  s.name        = "sunspot_activerecord"
  s.version     = SunspotActiverecord::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Olga Gorun"]
  s.email       = ["ogorun@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{active_record support for sunspot}
  s.description = %q{Simplified version of sunspot_rails gem to enable usage of sunspot+active_record -based models in not Rails projects}

  s.rubyforge_project = "sunspot_activerecord"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency 'sunspot'
  s.add_dependency 'activerecord', "~> 2.3.8"
end
