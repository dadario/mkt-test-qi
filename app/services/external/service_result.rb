# frozen_string_literal: true

module External
  module ServiceResult
    def send_result
      path = "/v1/oasis-portal/requests/#{service.external_code}/results"
      Typhoeus.post("#{ENV['GATEWAY_HOST']}#{path}",
                    body: { result_data: service.result_data }.to_json,
                    headers: { 'Content-type' => 'application/json',
                               'Authorization' => "Bearer #{access_token}" })
    end
  end
end
