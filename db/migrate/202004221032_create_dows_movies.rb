Sequel.migration do
  change do
    create_table(:dows_movies) do
      Integer :movie_id, :null => false
      Integer :dow_id, :null => false
    end
  end
end