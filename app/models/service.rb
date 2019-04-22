# frozen_string_literal: true

class Service < ApplicationRecord
  before_create :define_status
  after_create :send_message

  has_many :answers

  def already_answered?
    answers.any?
  end

  def result_data
    total_questions = Question.count
    right_answers = answers.select(&:corret?).size
    { total: (right_answers * 100) / total_questions }
  end

  private

  def define_status
    self.status = :created
  end

  def send_message
    ExternalService.send_message(self)
  end
end
