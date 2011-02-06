require 'geo_magic/radius'

module GeoMagic
  class Radius < Point
    class RandomPoints
      attr_reader :radius
      
      def initialize radius, number
        @radius = radius
        @number = number
      end
      
      def within
        radius.random_points_within number
      end
    end
  end
end