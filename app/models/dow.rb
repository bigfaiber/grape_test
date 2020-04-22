class Dow < Sequel::Model
  many_to_one :movie

  def validate
    super
    errors.add(:name, "must be present") if name.empty?
    errors.add(:dow, "must be present") if dow.nil?
  end
end