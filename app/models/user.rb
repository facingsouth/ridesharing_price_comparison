class User < ActiveRecord::Base
  validates :name, :email, :password, :presence => true
  validates :email, length: {in:4..30}
  has_secure_password

  has_many :searches
  has_many :historicals, through: :searches

  def last_7days_searches
    searches.includes(:historicals).where("created_at > ?", DateTime.now - 7)
  end

  def num_of_searches
    searches.count
  end

  def most_frequent_origin
    searches.select("origin, COUNT(origin) as num").group("origin").order("num DESC").limit(1)
  end

  def most_frequent_destination
    searches.select("destination, COUNT(destination) as num").group("destination").order("num DESC").limit(1)
  end
end
