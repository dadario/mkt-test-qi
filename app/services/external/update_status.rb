# frozen_string_literal: true

module External
  module UpdateStatus
    def update_status(status = 'processing')
      path = "/v1/oasis-portal/requests/#{service.external_code}"
      Typhoeus.post("#{ENV['GATEWAY_HOST']}#{path}",
                    body: { status: status },
                    headers: { 'Content-type' => 'application/json',
                               'Authorization' => "Bearer #{access_token}" })
    end
  end
end
