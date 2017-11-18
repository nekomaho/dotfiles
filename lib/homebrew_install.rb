require "open3"

class  HomebrewInstall
  extend Rake::DSL

  def self.install(app)
    check(app) ? sh("brew install #{app}") : puts("skip install #{app}")
  end 

  def self.check(app)
    Open3.capture3("brew info #{app}")[0] =~ /Not installed/
  end 

  def self.upgrade(app)
    sh("brew upgrade #{app}")
  end 
end
