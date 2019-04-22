# frozen_string_literal: true

class AnswersController < ApplicationController
  include ApplicationHelper
  before_action :set_service

  def create
    Answer.create(answer_params.merge(service_id: @service.id,
                                      question_id: params[:question_id]))
    if next_question?
      redirect_to question_path(next_question)
    else
      redirect_to '/finished'
    end
  end

  def set_service
    @service = Service.find(session[:service])
  end

  def answer_params
    params.require(:answer).permit(:choosed)
  end
end
