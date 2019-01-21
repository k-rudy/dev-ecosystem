Hanami::Model.migration do
  change do
    create_table :operations do
      primary_key :id
      foreign_key :account_id, null: false

      column :date, Date, null: false
      column :document_number, Integer, null: false
      column :currency_code, String, null: false
      column :currency_rate, Float, null: false
      column :value, Float, null: false
      column :value_equivalent, Float, null: false
      column :type, String, null: false
      column :name, String, null: false
      column :details, 'jsonb'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
