require "pry"
require "./lib/config_settings"
require "./lib/homebrew_install"
require "./lib/default_shell_settings"

conf = ConfigSettings.new

task default: :all
task :all => [:zsh_install, :vim_install]

task :zsh_install => [:zsh, :zsh_completions, conf.zshrc_path] do
  DefaultShellSetting.setting(conf.zsh_install_path)
end

task :vim_install => [conf.vimrc_path]


task :zsh do
  HomebrewInstall.install("zsh")
end

task :zsh_completions do
  HomebrewInstall.install("zsh-completions")
end

file conf.zshrc_path => '.zshrc' do
  cp '.zshrc', conf.zshrc_path
end

file conf.zshrc_path do
  ln_s conf.zshrc_path, conf.zshrc_home_path, force: :true
end

file conf.vimrc_path => '.vimrc' do
  cp '.vimrc', conf.vimrc_path
end

file conf.vimrc_path do
  ln_s conf.vimrc_path, conf.vimrc_home_path, force: :true
end
