Sequel.migration do
  change do
    create_table(:movies) do
      primary_key :id
      String :name, :null => false
      String :description, :null => true
      String :img_url
    end
  end
end