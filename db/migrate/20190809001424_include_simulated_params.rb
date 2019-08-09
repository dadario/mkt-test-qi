class IncludeSimulatedParams < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :simulated, :boolean
  end
end
