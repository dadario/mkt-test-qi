class AddExtraFieldServices < ActiveRecord::Migration[5.2]
  def change
      add_column :services, :applicant_id, :string
      add_column :services, :company_id, :string
      add_column :services, :recruiter_id, :string
  end
end
