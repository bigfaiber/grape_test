Sequel.migration do
  up do
    add_column :bookings, :quantity, Integer
  end

  down do
    drop_column :bookings, :quantity
  end
end