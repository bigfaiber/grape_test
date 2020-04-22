Sequel.migration do
  change do
    create_table(:dows) do
      primary_key :id
      String :name, :null => false
      Integer :dow, :null => false
    end
  end
end