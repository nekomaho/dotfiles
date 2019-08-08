require "./lib/setting_dir"

module Tmux
  class PluginInstaller
    class << self
      def setup
        new.setup
      end
    end

    def setup
      unless Dir.exists?(SettingDir::DIRS[:tmux_plugin_path])
        puts 'stup tmux plugin'
        Github.new('tmux-plugins/tpm').yield_self do |github|
          github.clone_dir(SettingDir::DIRS[:tmux_plugin_path])
          github.clone
        end
      end
    end
  end
end
