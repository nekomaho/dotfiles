require 'open3'

class  HomebrewInstall
  extend Rake::DSL

  class << self
    def install(app)
      Bundler.with_original_env do
        check(app) ? sh("brew install #{app}") : puts("skip install #{app}")
      end
    end

    def check(app)
      Bundler.with_original_env do
        Open3.capture3("brew info #{app}")[0] =~ /Not installed/
      end
    end

    def upgrade(app)
      Bundler.with_original_env do
        upgrade_check(app) ? sh("brew upgrade #{app}") : puts("skip upgrade #{app}")
      end
    end

    def upgrade_check(app)
      Bundler.with_original_env do
        Open3.capture3("brew outdated #{app}")[0] =~ /#{app}/
      end
    end
  end
end
