Sequel::Model.plugin :json_serializer
class Dow < Sequel::Model
  many_to_many :movies, left_key: :dow_id, right_key: :movie_id, join_table: :dows_movies

  def validate
    super
    errors.add(:name, "must be present") if name.empty?
    errors.add(:dow, "must be present") if dow.nil?
  end

end