require "./lib/vim_settings"
require "./lib/setting_dir"

class Vim
  VIM_CLONE_PATH = "#{SettingDir::DIRS[:src]}/vim".freeze

  class Installer
    class << self
      def make
        new.make
      end
    end

    def make
      puts 'install dein'
      VimInstall.dein(SettingDir::DIRS[:dotfiles_dir], SettingDir::DIRS[:app])
      if File.exists?(VIM_CLONE_PATH)
        puts 'vim update'
        VimInstall.update(VIM_CLONE_PATH, SettingDir::DIRS[:app])
      else
        puts 'vim build'
        VimInstall.build(VIM_CLONE_PATH, SettingDir::DIRS[:app])
      end
    end
  end
end
