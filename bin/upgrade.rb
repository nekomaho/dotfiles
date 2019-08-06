#!/usr/bin/env ruby
require 'thor'
require "./lib/homebrew_install"
require "./lib/homebrew/brewapp"

class Upgrade < Thor
  package_name "Upgrade .files"

  desc 'brew_install app_name' ,'install brew applications'
  def brew_install(app=nil)
    Homebrew::BrewAppInstaller.setup(app)
  end

  desc 'brew_update app_name' ,'update brew applications'
  def brew_update(app=nil)
    Homebrew::BrewAppUpdater.setup(app)
  end
end

Upgrade.start
