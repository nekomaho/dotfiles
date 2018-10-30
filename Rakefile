require "pry"
require "./lib/config_settings"
require "./lib/homebrew_install"
require "./lib/default_shell_settings"
require "./lib/vim_settings.rb"

conf = ConfigSettings.new

desc 'install all'
task default: :install

desc 'install each application'
task :install => [:make_dir, :zsh_install, :vim_install, :ag_install, :ctags_install, :nodebrew, :tmux]

desc 'install related zsh'
task :zsh_install => [:zsh, :zsh_completions, conf.zshrc_home_path] do
  DefaultShellSetting.setting(conf.zsh_install_path)
end

desc 'insatll releated vim'
task :vim_install => [:dein]

desc 'insatll related ctags'
task :ctags_install => [:ctags, conf.ctags_home_path]

desc 'install dein that plugin of vim'
task :dein => [:vim] do
  VimInstall.dein(conf.dotfiles_dir,conf.app)
end

desc 'install vim'
task :vim => [conf.vimrc_home_path, :lua ] do
  if File.exists?(conf.vim_clone_path)
    VimInstall.update(conf.vim_clone_path,conf.app)
  else
    VimInstall.build(conf.vim_clone_path,conf.app)
  end
end

desc 'install relaated silver bullet(ag)'
task :ag_install do
  HomebrewInstall.install_or_upgrade("the_silver_searcher")
end

desc 'install tmux'
task :tmux  => [conf.tmux_home_path ] do
  HomebrewInstall.install_or_upgrade("tmux")
end

desc 'install nodebrew'
task :nodebrew do
  HomebrewInstall.install_or_upgrade("nodebrew")
end

desc 'install lua that need vim'
task :lua do
  HomebrewInstall.install_or_upgrade("lua")
end

desc 'install zsh'
task :zsh do
  HomebrewInstall.install_or_upgrade("zsh")
end

desc 'install zsh_completions'
task :zsh_completions do
  HomebrewInstall.install_or_upgrade("zsh-completions")
end

desc 'insall ctags that source code tagging system'
task :ctags do
  HomebrewInstall.install("universal-ctags", options: { install_name: "--HEAD universal-ctags/universal-ctags/universal-ctags" })
end

desc 'make need directory'
task :make_dir => [conf.dotfiles_dir, conf.src, conf.app, conf.qfixhowm_path, conf.ctags_d_path]
directory conf.dotfiles_dir
directory conf.src
directory conf.app
directory conf.qfixhowm_path
directory conf.ctags_d_path

file conf.zshrc_home_path => conf.zshrc_path do
  ln_s conf.zshrc_path, conf.zshrc_home_path, force: :true
end

file conf.zshrc_path => '.zshrc' do
  cp '.zshrc', conf.zshrc_path
end

file '.zshrc'

file conf.vimrc_home_path => conf.vimrc_path do
  ln_s conf.vimrc_path, conf.vimrc_home_path, force: :true
end

file conf.vimrc_path => '.vimrc' do
  cp '.vimrc', conf.vimrc_path
end

file '.vimrc'

file conf.ctags_home_path => conf.ctags_path do
  ln_s conf.ctags_path, conf.ctags_home_path, force: :true
end

file conf.ctags_path => 'default.ctags' do
  cp 'default.ctags', conf.ctags_path
end

file 'default.ctags'

file conf.tmux_home_path => conf.tmux_conf_path do
  ln_s conf.tmux_conf_path, conf.tmux_home_path, force: :true
end

file conf.tmux_conf_path => '.tmux.conf' do
  cp '.tmux.conf', conf.tmux_conf_path
end

file '.tmux.conf'

namespace :upgrade do
  desc 'upgrade all application'
  task :all => ["rake:make_dir", :zsh_upgrade, :vim_upgrade, "rake:ag_install", :ctags_upgrade, "rake:nodebrew", "rake:tmux"]

  desc 'upgrade zsh releated application'
  task :zsh_upgrade => ["rake:zsh", "rake:zsh_completions", conf.zshrc_home_path] do
    DefaultShellSetting.setting(conf.zsh_install_path)
  end

  desc 'upgrade vim releated application'
  task :vim_upgrade => [:dein_upgrade]

  desc 'upgrade ctags application'
  task :ctags_upgrade => [conf.ctags_home_path] do
    HomebrewInstall.upgrade("universal-ctags")
  end

  desc 'upgrade dein that plugin of vim'
  task :dein_upgrade => [:vim] do
    VimInstall.dein(conf.dotfiles_dir,conf.app)
  end

  desc 'upgrade vim releated application'
  task :vim => [conf.vimrc_home_path, "rake:lua" ] do
    if File.exists?(conf.vim_clone_path)
      VimInstall.update(conf.vim_clone_path,conf.app)
    else
      VimInstall.build(conf.vim_clone_path,conf.app)
    end
  end
end
