require 'fileutils'
require './lib/setting_dir'

module Files
  class DirectoryCreator
    class << self
      def create!
        new.create!
      end
    end

    def create!
      SettingDir::DIRS.each do |_, dir|
        puts "make dir #{dir}"
        FileUtils.mkdir_p(dir)
      end
    end
  end

  class FileCopier
    FileComponent = Struct.new(:filename, :file_entity_path, :symlink_path)
    FILES = {
      # type: [filename, file entity path, symlink]
      zshrc:    FileComponent.new('.zshrc',        "#{SettingDir::DIRS[:dotfiles_dir]}/.zshrc",        "#{SettingDir::HOME}/.zshrc"),
      vimrc:    FileComponent.new('.vimrc',        "#{SettingDir::DIRS[:dotfiles_dir]}/.vimrc",        "#{SettingDir::HOME}/.vimrc"),
      tmux:     FileComponent.new('.tmux.conf',    "#{SettingDir::DIRS[:dotfiles_dir]}/.tmux.conf",    "#{SettingDir::HOME}/.tmux.conf"),
      agignore: FileComponent.new('.agignore',     "#{SettingDir::DIRS[:dotfiles_dir]}/.agignore",     "#{SettingDir::HOME}/.agignore"),
      ctags:    FileComponent.new('default.ctags', "#{SettingDir::DIRS[:dotfiles_dir]}/default.ctags", "#{SettingDir::DIRS[:ctags_d_path]}/default.ctags"),
    }

    class << self
      def copy!
        new.copy!
      end
    end

    def copy!
      FILES.each do |_, file_component|
        puts "copy #{file_component.filename} to #{file_component.file_entity_path}"
        FileUtils.cp(file_component.filename, file_component.file_entity_path)
        puts "ln #{file_component.file_entity_path} to #{file_component.symlink_path}"
        FileUtils.ln_s(file_component.file_entity_path, file_component.symlink_path, force: true)
      end
    end
  end
end
