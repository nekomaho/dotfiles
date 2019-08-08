require "./lib/homebrew_install"

module Homebrew
  class BrewAppStrategy
    INSTALL_APP = [
      :the_silver_searcher,
      :tmux,
      :nodebrew,
      :lua,
      :fzf,
      :git,
      :zsh,
      :zsh_completions,
      :universal_ctags,
    ].freeze

    class << self
      def setup(app)
        return new.setup(app) if app.nil?
        raise "you must add #{app} to INSTALL_APP" unless INSTALL_APP.include?(app.to_sym)
      end
    end

    def setup
      raise 'Not Implicated'
    end
  end

  class BrewAppInstaller < BrewAppStrategy
    def setup(app)
      HomebrewInstall.update
      (app.nil? ? INSTALL_APP : app.to_sym).each do |install_app|
        case install_app
        when :universal_ctags
          universal_ctags_install
        else
          HomebrewInstall.install(install_app)
        end
      end
    end

    def universal_ctags_install
      HomebrewInstall.install("universal-ctags", options: { install_name: "--HEAD universal-ctags/universal-ctags/universal-ctags" })
    end
  end

  class BrewAppUpdater < BrewAppStrategy
    def setup(app)
      HomebrewInstall.update
      (app.nil? ? INSTALL_APP : app.to_sym).each do |install_app|
        HomebrewInstall.install_or_upgrade(install_app)
      end
    end
  end
end
