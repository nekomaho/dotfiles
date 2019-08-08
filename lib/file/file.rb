require 'fileutils'

module Files
  HOME = "#{ENV["HOME"]}".freeze

  class DirectoryCreator
    DIRS = {
      dotfiles_dir:     "#{Files::HOME}/.dotfiles",
      src:              "#{Files::HOME}/src",
      app:              "#{Files::HOME}/app",
      qfixhowm_path:    "#{Files::HOME}/.qfixhowm",
      ctags_d_path:     "#{Files::HOME}/.ctags.d",
      tmux_plugin_path: "#{Files::HOME}/.tmux/plugins/tpm"
    }.freeze

    class << self
      def create!
        new.create!
      end
    end

    def create!
      DIRS.each do |_, dir|
        puts "make dir #{dir}"
        FileUtils.mkdir_p(dir)
      end
    end
  end

  class FileCopier
    FileComponent = Struct.new(:filename, :file_entity_path, :symlink_path)
    FILES = {
      # type: [filename, file entity path, symlink]
      zshrc:         FileComponent.new('.zshrc',        "#{DirectoryCreator::DIRS[:dotfiles_dir]}/.zshrc",        "#{Files::HOME}/.zshrc"),
      vimrc:         FileComponent.new('.vimrc',        "#{DirectoryCreator::DIRS[:dotfiles_dir]}/.vimrc",        "#{Files::HOME}/.vimrc"),
      tmux:          FileComponent.new('.tmux.conf',    "#{DirectoryCreator::DIRS[:dotfiles_dir]}/.tmux.conf",    "#{Files::HOME}/.tmux.conf"),
      agignore:      FileComponent.new('.agignore',     "#{DirectoryCreator::DIRS[:dotfiles_dir]}/.agignore",     "#{Files::HOME}/.agignore"),
      ctags:         FileComponent.new('default.ctags', "#{DirectoryCreator::DIRS[:dotfiles_dir]}/default.ctags", "#{DirectoryCreator::DIRS[:ctags_d_path]}/default.ctags"),
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
