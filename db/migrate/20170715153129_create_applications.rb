class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :address
      t.string :applicant
      t.datetime :expirationdate
      t.string :locationdescription
      t.string :status
      t.integer :objectid
    end
  end
end
