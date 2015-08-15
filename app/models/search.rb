class Search < ActiveRecord::Base
  validates :origin, :destination, presence: true
  validates :origin, :destination, length: { in: 1..100 }

  validate :waypoint_must_can_be_found

  def get_data
    data = []
    public_transit = PublicTransit.new(self.origin, self.destination, "transit")
    data << public_transit.data_parser
    driving = PublicTransit.new(self.origin, self.destination, "driving")
    data << driving.data_parser
    data += Uber.new.uber_type_price_distance(self.origin, self.destination)
    data
  end

  def waypoint_must_can_be_found
    public_transit = PublicTransit.new(self.origin, self.destination, "transit")
    error_status = public_transit.data_parser[:status]
    if error_status
      errors.add(:origin, error_status)
      errors.add(:destination, error_status)
    end
  end
end
