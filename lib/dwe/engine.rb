module Dwe

  # DW Engine Helper class.
  #
  class Engine

    class << self

      INDEX_INFO_KEYS = %w{levels: nodes: leaves: name: version:}

      def info
        info = engine.index.index_props.to_s.split(' ')
        res = {}
        INDEX_INFO_KEYS.map do |k|
          res[k.gsub(':', '')] = info[info.index(k)+1]
        end
        res
      end

      def init
        loader_instance
      end

      def telemetric_objects
        engine.getDrawableTelemetric.to_a
      end

      def index_nodes
        engine.index.nodes
      end

      # returns [dwe.engine.DataWarehouseEngine] DW engine instance
      def engine
        loader_instance.engine
      end

      private

      def loader_instance
        Dwe::Loader.instance
      end
    end
    
  end
end
