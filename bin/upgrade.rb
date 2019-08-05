#!/usr/bin/env ruby
require 'thor'
require "./lib/homebrew_install"
require "./lib/homebrew/brewapp"

class Upgrade < Thor
  package_name "Upgrade .files"

  desc 'all_brew_install' ,'install all brew applications'
  def all_brew_install
    Homebrew::BrewAppInstaller.setup(nil)
  end

  desc 'all_brew_update' ,'update all brew applications'
  def all_brew_update
    Homebrew::BrewAppUpdater.setup(nil)
  end

  desc 'brew_install app_name' ,'install brew applications'
  def brew_install(app)
    Homebrew::BrewAppInstaller.setup(app)
  end

  desc 'brew_update app_name' ,'update brew applications'
  def brew_update(app)
    Homebrew::BrewAppUpdater.setup(app)
  end
end

Upgrade.start
