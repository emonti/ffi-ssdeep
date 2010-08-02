# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'

task :default => 'spec:run'

PROJ.name = 'ffi-ssdeep'
PROJ.authors = 'Eric Monti'
PROJ.email = 'emonti@trustwave.com'
PROJ.description = 'FFI bindings for the ssdeep library "libfuzzy" for fuzzy hash comparisons'
PROJ.url = 'http://github.com/SpiderLabsResearch/ffi-ssdeep'
PROJ.version = File.open("version.txt","r"){|f| f.readline.chomp}
PROJ.readme_file = 'README.rdoc'

PROJ.spec.opts << '--color'
PROJ.rdoc.opts << '--line-numbers'
PROJ.notes.tags << "X"+"XX" # muhah! so we don't note our-self

# exclude rcov.rb and external libs from rcov report
PROJ.rcov.opts += [
  "--exclude",  "rcov", 
  "--exclude",  "ffi", 
]

depend_on 'ffi', '>= 0.6.0'

# EOF
