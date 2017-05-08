class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table(:divisions) do |t|
      t.column(:name, :string)

      t.timestamps
    end
    create_table(:employees) do |t|
      t.column(:first_name, :string)
      t.column(:last_name, :string)
      t.column(:division_id, :integer)
      t.column(:project_id, :integer)

      t.timestamps
    end
    create_table(:projects) do |t|
      t.column(:name, :string)

      t.timestamps
    end
  end
end
