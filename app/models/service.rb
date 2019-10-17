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
      score: (right_answers * 100) / total_questions,
      summary: 'Avaliação Comportamental',
      link: 'https://trabalheconosco.vagas.com.br/vagas',
      completionDate: created_at.strftime("%Y-%m-%d"),
      expires_at: (created_at + 1.year).strftime("%Y-%m-%d")
    }
  end

  def send_message
    ExternalService.send_message(self)
  end

  def send_result
    ExternalService.send_result(self)
  end

  private

  def define_status
    self.status = :created
  end
end
