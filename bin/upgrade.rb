#!/usr/bin/env ruby
require 'thor'
require "./lib/homebrew_install"
require "./lib/homebrew/brewapp"
require "./lib/file/file"
require "./lib/vim/vim"
require "./lib/tmux/plugin"

class UpgradeCLI < Thor
  package_name "Upgrade .files"

  desc 'install' ,'install all applications'
  def install
    before_actions
    vim_make
    brew_install
    after_actions
  end

  desc 'update' ,'update all applications'
  def update
    before_actions
    vim_make
    brew_update
    after_actions
  end

  desc 'brew_install app_name' ,'install brew applications'
  def brew_install(app=nil)
    Homebrew::BrewAppInstaller.setup(app)
  end

  desc 'brew_update app_name' ,'update brew applications'
  def brew_update(app=nil)
    Homebrew::BrewAppUpdater.setup(app)
  end

  desc 'vim_make' ,'install and update vim'
  def vim_make
    Vim::Installer.make
  end

  private

  def before_actions
    Files::DirectoryCreator.create!
    Files::FileCopier.copy!
  end

  def after_actions
    Tmux::PluginInstaller.setup
  end
end

UpgradeCLI.start
