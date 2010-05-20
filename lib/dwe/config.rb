# Dwe configuration class, reads from config/dwe.yml by default
#
# Usage:
#   Dwe::Config.instance[:key] # => value
#

module Dwe
  class Config

    DEFAULT_DWE_CLASSES = {
      'dwe.core.misc' => %w{ Rect Point LocationComponent LocationDescriptor DWCalendar Identifier },
      'dwe.management' => 'SimpleManager',
      'dwe.config' => 'ConfigFactory' }

    # Example usage
    #   Dwe::Config.setup("config.yml") { |conf| conf[RAILS_ENV] }
    #
    def self.setup(conf_file, env)
      @@conf = YAML::load_file(conf_file)[env]
      @@conf['external_jars'].each { |jar| require jar } if @@conf['external_jars']
      
      JavaClassLoader.include_java_classes(Dwe, DEFAULT_DWE_CLASSES)

      # now we can load other stuff..
      require 'dwe/base_ruby_manager'
      require 'dwe/loader'
      require 'dwe/engine'
      require 'dwe/utils'
    end

    # Read config value from :key
    #
    def self.[](key)
      @@conf[key.to_s]
    end

    # Return all configuration
    #
    def self.conf
      @@conf
    end

  end
end