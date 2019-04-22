# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  def corret?
    choosed == question.right_answer
  end
end
