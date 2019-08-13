require "./lib/vim_settings"
require "./lib/setting_dir"

class Vim
  VIM_CLONE_PATH = "#{SettingDir::DIRS[:src]}/vim".freeze

  class Installer
    class << self
      def make(force: false)
        new.make(force: force)
      end
    end

    def make(force:)
      puts 'install dein'
      VimInstall.dein(SettingDir::DIRS[:dotfiles_dir], SettingDir::DIRS[:app])
      if need_build?
        puts 'vim build'
        VimInstall.build(VIM_CLONE_PATH, SettingDir::DIRS[:app])
      else
        case force
        when true
          puts 'vim update'
          VimInstall.force_update(VIM_CLONE_PATH, SettingDir::DIRS[:app])
        when false
          puts 'vim update'
          VimInstall.update(VIM_CLONE_PATH, SettingDir::DIRS[:app])
        end
      end
    end

    private

    def need_build?
      !File.exists?(VIM_CLONE_PATH)
    end
  end
end
