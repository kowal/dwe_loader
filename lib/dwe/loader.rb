
module Dwe

  class Loader

    include Singleton

    attr_accessor :manager, :engine

    def initialize
      unless @manager
        @manager ||= BaseRubyManager.new
        @manager.init(config_file)
      end
      @engine ||= @manager.startApplication
    end

    def config_file     
      @config_file ||= java.io.File.new(File.join(Dwe::Config[:config_file]))
    end

  end
end