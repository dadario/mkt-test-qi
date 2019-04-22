# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.foreign_key :questions
      t.integer :service_id
      t.foreign_key :services
      t.string :choosed
      t.timestamps
    end
  end
end
