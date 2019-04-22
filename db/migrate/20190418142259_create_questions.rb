# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :description
      t.string :options
      t.string :right_answer
      t.timestamps
    end
  end
end
