require 'pry'

# load .rb files under lib directory
Dir[File.expand_path('lib/') << '/**.rb' ].each do|file|
  require 'rake'
  require file
end

Dir[File.expand_path('spec/helper/') << '/**.rb' ].each do|file|
  require file
end
