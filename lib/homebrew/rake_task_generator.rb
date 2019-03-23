require 'yaml'

module HomebrewInstall
  LOAD_FILE = './brewapp.yml'.freeze

  module  RakeTaskGenerator
    def self.load
      RakeTasks.new(LOAD_FILE)
    end
  end

  class RakeTasks
    attr_reader :tasks

    def initialize(yaml_file)
      @tasks = YAML.load_file(yaml_file).each_with_object([]) do |app, tasks|
        tasks << RakeTask.create!(app[0], app[1].nil? ? {} : app[1])
      end
    end

    def to_h
      @tasks.each_with_object([]) do |task, array|
        array << { task.name => task.options }
      end
    end
  end

  class RakeTask
    def self.create!(app_name, options)
      new(app_name, options)
    end

    attr_reader :name, :options

    def initialize(app_name, options)
      @name = app_name.to_sym
      @options = options.transform_keys!(&:to_sym)
    end
  end
end
