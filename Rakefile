require "pry"
require "./lib/config_settings"
require "./lib/homebrew_install"
require "./lib/default_shell_settings"
require "./lib/vim_settings.rb"

conf = ConfigSettings.new

task default: :all
task :all => [:zsh_install, :vim_install]

task :zsh_install => [:zsh, :zsh_completions, conf.zshrc_path] do
  DefaultShellSetting.setting(conf.zsh_install_path)
end

task :vim_install => [:dein] do
  VimInstall.install(conf.vim_clone_path)
end

task :dein => [:vim] do
  VimInstall.dein(conf.dotfiles_dir,conf.app) 
end

task :vim => [conf.vimrc_path, :lua ] do
  if File.exists?(conf.vim_clone_path)
    VimInstall.update(conf.vim_clone_path,conf.app)
  else
    VimInstall.install(conf.vim_clone_path,conf.app)
  end
end

task :lua do
  HomebrewInstall.install("lua")
end

task :zsh do
  HomebrewInstall.install("zsh")
end

task :zsh_completions do
  HomebrewInstall.install("zsh-completions")
end

directory conf.dotfiles_dir
directory conf.src
directory conf.app
directory conf.qfixhowm_path

file conf.zshrc_path => conf.dotfiles_dir do
  cp '.zshrc', conf.zshrc_path
end

file conf.zshrc_path do
  ln_s conf.zshrc_path, conf.zshrc_home_path, force: :true
end

file conf.vimrc_path => conf.dotfiles_dir do
  cp '.vimrc', conf.vimrc_path
end

file conf.vimrc_path do
  ln_s conf.vimrc_path, conf.vimrc_home_path, force: :true
end
