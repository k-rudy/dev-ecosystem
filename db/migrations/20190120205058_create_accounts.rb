Hanami::Model.migration do
  change do
    create_table :accounts do
      primary_key :id
      foreign_key :user_id, null: false

      column :number, String, null: false
      column :currency_iso, String, null: false
      column :currency_code, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
