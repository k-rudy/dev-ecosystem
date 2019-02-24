Hanami::Model.migration do
  change do
    create_table :taxes do
      primary_key :id
      foreign_key :operation_id, null: false

      column :type, String, null: false
      column :interest, Float, null: false
      column :description, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
