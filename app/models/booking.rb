class Booking < Sequel::Model
  many_to_one :movie

  def validate
    super
    errors.add(:date, "must be present") if date.nil?
    errors.add(:client_id, "must be present") if client_id.nil?
  end
end