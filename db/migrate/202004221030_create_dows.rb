Sequel.migration do
  change do
    create_table(:dows) do
      primary_key :id
      String :name, :null => false
      Integer :dow, :null => false
      foreign_key :movie_id
    end
  end
end