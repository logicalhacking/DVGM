require 'rdoc/task'
     
desc 'generate API documentation to doc/rdocs/index.html'
     
Rake::RDocTask.new do |rd|
  rd.rdoc_dir = 'doc/rdocs'
  rd.main = 'README.md'
  rd.rdoc_files.include 'README.md', "config/**/*\.rb", "helpers/**/*\.rb", "script/**/*\.rb" 
     
  rd.options << '--inline-source'
  rd.options << '--line-numbers'
  rd.options << '--all'
  rd.options << '--fileboxes'
  rd.options << '--diagram'
end

