module GeoMagic 
  class PointsCenter
    attr_accessor :distance, :center

    def initialize distance, point
      raise ArgumentError, "First argument must be a GeoMagic::Distance, was #{distance}" if !distance.kind_of? GeoMagic::Distance
      # raise ArgumentError, "First argument must be a collection of GeoMagic::Point, was #{points}" if !points.
      self.distance = distance
      self.point = point
    end

    # return whether the distance between this point and a given center is within the given distance
    def of center
      GeoMagic::Vector.new(point, center).distance <= distance
    end
  end
end
