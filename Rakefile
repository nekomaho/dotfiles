require "pry"
require "./lib/config_settings"
require "./lib/homebrew_install"
require "./lib/default_shell_settings"
require "./lib/vim_settings.rb"

conf = ConfigSettings.new

desc 'install all'
task default: :install

desc 'install each application'
task :install => [:make_dir, :zsh_install, :vim_install, :ag_install, :global_install, :nodebrew, :tmux]

desc 'install related zsh'
task :zsh_install => [:zsh, :zsh_completions, conf.zshrc_home_path] do
  DefaultShellSetting.setting(conf.zsh_install_path)
end

desc 'insatll releated vim'
task :vim_install => [:dein]

desc 'insatll related global'
task :global_install => [:global, :exuberant_ctags, :pygments]

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
  VimInstall.install(conf.vim_clone_path)
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

desc 'insall global that source code tagging system'
task :global do
  HomebrewInstall.install_or_upgrade("global")
end

desc 'install ctags taht source code tagging'
task :exuberant_ctags do
  HomebrewInstall.install_or_upgrade("exuberant-ctags")
end

desc 'install pygments that syntax highlight system'
task :pygments do
  HomebrewInstall.install_or_upgrade("pygments")
end

desc 'make need directory'
task :make_dir => [conf.dotfiles_dir, conf.src, conf.app, conf.qfixhowm_path]
directory conf.dotfiles_dir
directory conf.src
directory conf.app
directory conf.qfixhowm_path

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

file conf.tmux_home_path => conf.tmux_conf_path do
  ln_s conf.tmux_conf_path, conf.tmux_home_path, force: :true
end

file conf.tmux_conf_path => '.tmux.conf' do
  cp '.tmux.conf', conf.tmux_conf_path
end

file '.tmux.conf'

namespace :upgrade do
  desc 'upgrade all application'
  task :all => ["rake:make_dir", :zsh_upgrade, :vim_upgrade, "rake:ag_install", :global_upgrade, "rake:nodebrew", "rake:tmux"]

  desc 'upgrade zsh releated application'
  task :zsh_upgrade => ["rake:zsh", "rake:zsh_completions", conf.zshrc_home_path] do
    DefaultShellSetting.setting(conf.zsh_install_path)
  end

  desc 'upgrade vim releated application'
  task :vim_upgrade => [:dein_upgrade]

  desc 'upgrade global releated application'
  task :global_upgrade => ["rake:global", "rake:exuberant_ctags", "rake:pygments"]

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
    VimInstall.install(conf.vim_clone_path)
  end
end
