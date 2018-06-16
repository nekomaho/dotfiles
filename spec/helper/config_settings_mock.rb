module ConfigSettingMock
  refine ConfigSettings do
    def config_file
      @config_file = 'spec/lib/yml/rakefile_test.yml'
    end

    def home
      @home = 'spec/lib/tmp'
    end
  end
end
