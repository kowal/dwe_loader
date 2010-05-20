
module Dwe

  # Dwe Utilities class
  #
  class Utils

    class << self

      # Change coordinates to model format
      #
      def coords_to_model(lat, lng)
        [map_config["lat_ratio"]*(lat - map_config["lat"]), map_config["lng_ratio"]*(lng - map_config["lng"])]
      end

      # Change coordinates to GUI format
      #
      def coords_to_gui(lat, lng)
        [(lat / map_config["lat_ratio"]) + map_config["lat"], (lng / map_config["lng_ratio"] + map_config["lng"])]
      end

      private

      def map_config
        Dwe::Config[:map]
      end

    end

  end

end