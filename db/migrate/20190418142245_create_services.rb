# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :external_code
      t.string :company_name
      t.string :recruiter_name
      t.string :applicant_name
      t.integer :job_id
      t.string :job_title
      t.string :status
      t.timestamps
    end
  end
end
