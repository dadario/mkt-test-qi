# frozen_string_literal: true

class ProcessController < ApplicationController
  before_action :find_service, only: :index

  def index
    session[:service] = @service.id
    session[:questions] = Question.select(:id).map(&:id)
    ExternalService.update_status(@service, 'processing')
  end

  def finished
    @service = Service.find(session[:service])
    @service.update_attribute(status: :completed)
    ExternalService.send_result(@service)

    session.delete(:service)
    session.delete(:questions)
  end

  private

  def find_service
    @service = Service.find_by_external_code(params[:external_code])
  end
end
