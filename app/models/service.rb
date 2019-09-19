# frozen_string_literal: true

class Service < ApplicationRecord
  before_create :define_status

  has_many :answers

  def already_answered?
    answers.any?
  end

  def result_data
    total_questions = Question.count
    right_answers = answers.select(&:corret?).size
    {
      score: ((right_answers * 100.0) / total_questions).round(2),
      summary: 'A simple description about this test',
      link: 'http://localhost:3000/link.pdf',
      completionDate: created_at.strftime("%Y-%m-%d"),
      expires_at: (created_at + 3.months).strftime("%Y-%m-%d")
    }
  end

  def send_message
    ExternalService.send_message(self)
  end

  private

  def define_status
    self.status = :created
  end

end
