module ConfigSettingHelper
  def test_config_setting(**args)
    ConfigSettings.class_eval do
      alias_method :__backup_config_file, :config_file
      alias_method :__backup_home, :home

      def config_file
        @config_file = 'spec/lib/yml/rakefile_test.yml'
      end

      def home
        @home = 'spec/tmp'
      end
    end
  end

  def config_setting_teardown
    ConfigSettings.class_eval do
      alias_method :config_file, :__backup_config_file
      alias_method :home, :__backup_home
    end
  end
end
