#!/usr/bin/env ruby
require 'thor'
require "./lib/homebrew_install"
require "./lib/homebrew/brewapp"
require "./lib/file/file"

class UpgradeCLI < Thor
  package_name "Upgrade .files"

  desc 'install' ,'install all applications'
  def install
    before_actions
    brew_install
  end

  desc 'update' ,'update all applications'
  def update
    before_actions
    brew_update
  end

  desc 'brew_install app_name' ,'install brew applications'
  def brew_install(app=nil)
    Homebrew::BrewAppInstaller.setup(app)
  end

  desc 'brew_update app_name' ,'update brew applications'
  def brew_update(app=nil)
    Homebrew::BrewAppUpdater.setup(app)
  end

  private

  def before_actions
    Files::DirectoryCreator.create!
    Files::FileCopier.copy!
  end
end

UpgradeCLI.start
