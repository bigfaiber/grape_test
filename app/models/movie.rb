class Movie < Sequel::Model
  one_to_many :dows
  one_to_many :bookings

  def validate
    super
    errors.add(:name, "must be present") if name.empty?
  end
end