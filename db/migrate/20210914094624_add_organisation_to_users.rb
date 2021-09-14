class AddOrganisationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :organisation, null: false, foreign_key: true
  end
end
