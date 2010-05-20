module Dwe

  # DW Engine Helper class.
  #
  class Engine

    class << self

      INDEX_INFO_KEYS = %w{levels: nodes: leaves: name: version:}

      def info
        info = Dwe::Loader.instance.engine.index.index_props.to_s.split(' ')
        res = {}
        INDEX_INFO_KEYS.map do |k|
          res[k.gsub(':', '')] = info[info.index(k)+1]
        end
        res
      end

      def telemetric_objects
        Dwe::Loader.instance.engine.getDrawableTelemetric.to_a
      end

      def index_nodes
        Dwe::Loader.instance.engine.index.nodes
      end

      def engine
        Dwe::Loader.instance.engine
      end

    end
    
  end
end
