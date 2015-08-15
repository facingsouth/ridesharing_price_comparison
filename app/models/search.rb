class Search < ActiveRecord::Base
  validates :origin, :destination, presence: true
  validates :origin, :destination, length: { in: 1..100 }

  validate :waypoint_must_can_be_found

  has_many :historicals
  belongs_to :user

  before_create :to_uppercase

  def get_data
    data = []
    # Public transit data
    public_transit = PublicTransit.new(self.origin, 
                                       self.destination, 
                                       "transit")
    data << public_transit.data_parser

    # Diving data
    driving = PublicTransit.new(self.origin, 
                                self.destination, 
                                "driving")
    data << driving.data_parser

    # Taxi data
    t = Taxi.new
    data << t.data_parser(self.origin, 
                          self.destination, 
                          driving.data_parser[:duration], 
                          driving.data_parser[:distance])

    # Uber data
    data += Uber.new.uber_type_price_distance(self.origin, self.destination)
    [data, t.start_city]
  end

  def search_date
    created_at.to_date
  end

  def to_uppercase
    self.origin.upcase!
    self.destination.upcase!
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
