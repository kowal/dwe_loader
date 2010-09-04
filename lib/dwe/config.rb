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
      STDERR.puts "#{self.name}.setup ... #{pp @@conf rescue @@conf.inspect}"

      # Load main DWE jars
      if conf['main_jars']
        conf['main_jars'].each { |jar| require jar }
      end

      # conditionally load common jars
      # They shouldn't be loaded when we're on java container (i.e. Tomcat),
      # On java app. server, they usually have special place like common/lib.
      unless java_container? && conf['common_jars']
        conf['common_jars'].each { |jar| require jar }
      end

      # load main DWE classes
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

    def self.config_file_path
      "#{java_container? ? conf['java_container_path'] : ''}#{File.join(conf['config_file'])}"
    end

    # Return true if we're running on java web server container (lik tomcat)
    #
    def self.java_container?
      (defined?($servlet_context) &&
        $servlet_context.class.ancestors.include?(Java::JavaxServlet::ServletContext))
    end

  end
end