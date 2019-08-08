require 'open3'
require 'pry'

module HomebrewInstall
  class << self
    def install(app, options: {})
      install_name = options.fetch(:install_name, nil)
      install_name = app if install_name.nil?
      Bundler.with_original_env do
        return system("brew install #{install_name}") if check(app)
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
        return system("brew upgrade #{app}") if upgrade_check(app)
        puts("skip upgrade #{app}")
      end
    end

    def upgrade_check(app)
      Bundler.with_original_env do
        Open3.capture3("brew outdated #{app}")[0] =~ /#{app}/
      end
    end

    def update
      Bundler.with_original_env do
        puts('brew update')
        system('brew update')
      end
    end

    def install_or_upgrade(app)
      install(app)
      upgrade(app)
    end
  end
end
