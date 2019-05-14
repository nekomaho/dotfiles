require 'yaml'

module HomebrewInstall
  LOAD_FILE = './brewapp.yml'.freeze

  class HomebrewTaskGenerator
    def self.load(tasks=nil)
      return new(tasks) if tasks
      new
    end

    attr_reader :tasks

    def initialize(tasks=Tasks.load(LOAD_FILE))
      @tasks = Tasks.parse(tasks)
    end

    def install_or_upgrade
      tasks.each do |task|
        HomebrewInstall.install_or_upgrade(task.name)
      end
    end
  end

  class Tasks
    attr_reader :tasks_hash, :tasks
    class << self
      def load(yaml_file)
        YAML.load_file(yaml_file).each_with_object([]) do |app, tasks|
          tasks << { app[0] => app[1].nil? ? {} : app[1] }
        end
      end

      def parse(tasks_hash)
        new(tasks_hash)
      end
    end

    def initialize(tasks_hash)
      @tasks = tasks_hash.each_with_object([]) do |task, tasks|
        tasks << Task.create!(task.keys.first, task[task.keys.first])
      end
    end

    def to_h
      @tasks.each_with_object([]) do |task, array|
        array << { task.name => task.options }
      end
    end

    def each(&block)
      @tasks.each do |task|
        block.call(task)
      end
    end
  end

  class Task
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
