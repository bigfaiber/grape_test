Sequel::Model.plugin :json_serializer
class Booking < Sequel::Model
  many_to_one :movie

  def validate
    super
    errors.add(:date, "must be present") if date.nil?
    errors.add(:client_id, "must be present") if client_id.nil?
    errors.add(:quantity, "must be present") if quantity.nil?
    errors.add(:quantity, "must be an integer") unless quantity.is_a? Integer
  end
end