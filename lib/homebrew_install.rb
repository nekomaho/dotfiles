require 'open3'

class  HomebrewInstall
  extend Rake::DSL

  class << self
    def install(app)
      Bundler.with_original_env do
        return sh("brew install #{app}") if check(app)
        puts("skip install #{app}")
      end
    end

    def check(app)
      Bundler.with_original_env do
        Open3.capture3("brew info #{app}")[0] =~ /Not installed/
      end
    end

    def upgrade(app)
      Bundler.with_original_env do
        return sh("brew upgrade #{app}") if upgrade_check(app)
        puts("skip upgrade #{app}")
      end
    end

    def upgrade_check(app)
      Bundler.with_original_env do
        Open3.capture3("brew outdated #{app}")[0] =~ /#{app}/
      end
    end
  end
end
