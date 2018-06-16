module ConfigSettingHelper
  def config_file
    @config_file = 'spec/lib/yml/rakefile_test.yml'
  end

  def home
    @home = 'spec/lib/tmp'
  end
end

class ConfigSettings
  prepend ConfigSettingHelper
end
