require 'sequel'

Sequel.migration do
  change do
    create_table(:posts) do
      primary_key :id
      foreign_key :owner_id, :accounts

      String :title, null: false
      String :content, text: true
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
