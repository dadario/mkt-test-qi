# frozen_string_literal: true

module ApplicationHelper
  def next_question?
    !session[:questions].blank?
  end

  def next_question
    nil unless next_question?
    Question.find(session[:questions].shift)
  end
end
