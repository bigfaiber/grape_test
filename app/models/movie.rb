Sequel::Model.plugin :json_serializer
class Movie < Sequel::Model
  many_to_many :dows, left_key: :movie_id, right_key: :dow_id, join_table: :dows_movies
  one_to_many :bookings

  def validate
    super
    errors.add(:name, "must be present") if name.empty?
  end
end