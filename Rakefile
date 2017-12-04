require "pry"
require "./lib/config_settings"
require "./lib/homebrew_install"
require "./lib/default_shell_settings"
require "./lib/vim_settings.rb"

conf = ConfigSettings.new

task default: :all
task :all => [:zsh_install, :vim_install, :ag_install]

task :zsh_install => [:zsh, :zsh_completions, conf.zshrc_path] do
  DefaultShellSetting.setting(conf.zsh_install_path)
end

task :vim_install => [:dein]

task :dein => [:vim] do
  VimInstall.dein(conf.dotfiles_dir,conf.app) 
end

task :vim => [conf.vimrc_path, :lua ] do
  if File.exists?(conf.vim_clone_path)
    VimInstall.update(conf.vim_clone_path,conf.app)
  else
    VimInstall.build(conf.vim_clone_path,conf.app)
  end
  VimInstall.install(conf.vim_clone_path)
end

task :ag_install do
  HomebrewInstall.install("the_silver_searcher")
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

file conf.zshrc_path => '.zshrc' do
  cp '.zshrc', conf.zshrc_path
end

file conf.zshrc_home_path do
  ln_s conf.zshrc_path, conf.zshrc_home_path, force: :true
end

file conf.vimrc_path => '.vimrc' do
  cp '.vimrc', conf.vimrc_path
  ln_s conf.vimrc_path, conf.vimrc_home_path, force: :true unless File.exists?(conf.vimrc_home_path)
end

namespace :upgrade do
  task :all => [:zsh_upgrade, :vim_upgrade, :ag_upgrade]
  task :zsh_upgrade => [:zsh, :zsh_completions, conf.zshrc_path] do
    DefaultShellSetting.setting(conf.zsh_install_path)
  end

  task :vim_upgrade => [:dein_upgrade]

  task :dein_upgrade => [:vim] do
    VimInstall.dein(conf.dotfiles_dir,conf.app) 
  end

  task :vim => [conf.vimrc_path, :lua ] do
    if File.exists?(conf.vim_clone_path)
      VimInstall.update(conf.vim_clone_path,conf.app)
    else
      VimInstall.build(conf.vim_clone_path,conf.app)
    end
    VimInstall.install(conf.vim_clone_path)
  end

  task :ag_upgrade do
    HomebrewInstall.upgrade("the_silver_searcher")
  end

  task :lua do
    HomebrewInstall.upgrade("lua")
  end

  task :zsh do
    HomebrewInstall.upgrade("zsh")
  end

  task :zsh_completions do
    HomebrewInstall.upgrade("zsh-completions")
  end
end
