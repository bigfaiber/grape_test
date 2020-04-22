Sequel.migration do
  change do
    create_table(:bookings) do
      primary_key :id
      DateTime :date, :null => false
      String :client_id, :null => false
      foreign_key :movie_id
    end
  end
end