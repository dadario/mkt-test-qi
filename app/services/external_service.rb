# frozen_string_literal: true

class ExternalService
  include External::Authenticate
  include External::ServiceResult
  include External::DeliveryMessage
  include External::UpdateStatus

  attr_reader :service, :access_token, :expires_in

  def initialize(service)
    @service = service
  end

  class << self
    def update_status(service, status)
      new(service).authenticate!.update_status(status)
    end

    def send_message(service)
      new(service).authenticate!.send_message
    end

    def send_result(service)
      new(service).authenticate!.send_result
    end
  end
end
