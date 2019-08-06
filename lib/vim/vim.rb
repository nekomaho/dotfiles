require "./lib/vim_settings"
require "./lib/file/file"

class Vim
  VIM_CLONE_PATH = "#{Files::DirectoryCreator::DIRS[:src]}/vim".freeze

  class Installer
    class << self
      def make
        new.make
      end
    end

    def make
      puts 'install dein'
      VimInstall.dein(Files::DirectoryCreator::DIRS[:dotfiles_dir], Files::DirectoryCreator::DIRS[:app])
      if File.exists?(VIM_CLONE_PATH)
        puts 'vim update'
        VimInstall.update(VIM_CLONE_PATH, Files::DirectoryCreator::DIRS[:app])
      else
        puts 'vim build'
        VimInstall.build(VIM_CLONE_PATH, Files::DirectoryCreator::DIRS[:app])
      end
    end
  end
end
