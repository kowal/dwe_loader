# Dwe configuration class, reads from config/dwe.yml by default
#
# Usage:
#   Dwe::Config.instance[:key] # => value
#

module Dwe
  class Config
    
    # Example usage
    #   Dwe::Config.setup("config.yml") { |conf| conf[RAILS_ENV] }
    #
    def self.setup(conf_file, env, opts={})
      @@conf = YAML::load_file(conf_file)[env]

      if @@conf['external_jars']
        @@conf['external_jars'].each do |jar|
          require jar
        end
      end

      # optioanlly load selcted DWE classes      
      if opts[:classes]
        JavaClassLoader.include_java_classes(Dwe, opts[:classes])
      end

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