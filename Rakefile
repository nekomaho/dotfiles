require "open3"
task :all => [:zsh, :zsh_completions, :dot_zshrc] do

end

task :zsh do
  HomebrewInstall.install("zsh")
end

task :zsh_completions do

end

task :dot_zshrc do

end

class  HomebrewInstall
  include Rake::DSL
  def self.install(app)
    check(app) ? sh("brew install #{app}") : puts("skip install #{app}")
  end 
  def self.check(app)
    o, e, s = Open3.capture3("brew info #{app}")
    o =~ /Not installed/
  end 
end
