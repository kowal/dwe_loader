# Dwe configuration class, reads from config/dwe.yml by default
#
# Usage:
#   Dwe::Config.instance[:key] # => value
#

module Dwe
  class Config

    DWE_CLASSES = {
      'dwe.management' => 'SimpleManager',
      'dwe.config'     => 'ConfigFactory' }

    # Example usage
    #   Dwe::Config.setup("config.yml") { |conf| conf[RAILS_ENV] }
    #  @opts
    #    :include_java =>  { Dwe => { 'dwe.config' => 'ConfigFactory' , ... } }
    #
    def self.setup(conf_file, env, opts={})
      @@conf = YAML::load_file(conf_file)[env]

      if @@conf['external_jars']
        @@conf['external_jars'].each do |jar|
          require jar
        end
      end
      
      JavaClassLoader.include_java_classes(Dwe, DWE_CLASSES)

      # optioanlly load selcted DWE classes      
      if opts[:include_java]
        opts[:include_java].each_pair do |base_class, classes_to_include|
          JavaClassLoader.include_java_classes(base_class, classes_to_include)
        end
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