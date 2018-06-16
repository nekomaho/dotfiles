module ConfigSettingHelper
  def config_file
    @config_file = 'spec/lib/yml/rakefile_test.yml'
  end
end

class ConfigSettings
  prepend ConfigSettingHelper
end
