# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ffi-ssdeep}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Monti"]
  s.date = %q{2010-07-13}
  s.description = %q{FFI bindings for the ssdeep library "libfuzzy" for fuzzy hash comparisons}
  s.email = %q{emonti@trustwave.com}
  s.extra_rdoc_files = ["History.txt", "LICENSE.txt", "README.rdoc", "version.txt"]
  s.files = ["History.txt", "LICENSE.txt", "README.rdoc", "Rakefile", "ffi-ssdeep-0.1.0.gem", "lib/ssdeep.rb", "lib/ssdeep/fuzzy_hash.rb", "spec/fuzzy_hash_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/ssdeep_spec.rb", "tasks/ann.rake", "tasks/doc.rake", "tasks/gem.rake", "tasks/git.rake", "tasks/post_load.rake", "tasks/rdoc.task", "tasks/rubyforge.rake", "tasks/setup.rb", "tasks/spec.rake", "tasks/svn.rake", "tasks/test.rake", "version.txt"]
  s.rdoc_options = ["--line-numbers", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{FFI bindings for the ssdeep library "libfuzzy" for fuzzy hash comparisons}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, [">= 0.6.0"])
    else
      s.add_dependency(%q<ffi>, [">= 0.6.0"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 0.6.0"])
  end
end
