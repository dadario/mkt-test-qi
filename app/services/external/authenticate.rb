# frozen_string_literal: true

module External
  module Authenticate
    def authenticate!
      response = Typhoeus.post("#{ENV['GATEWAY_HOST']}/oauth/token",
                               body: { grant_type: 'client_credentials' },
                               headers: { 'Content-type' => 'application/x-www-form-urlencoded' },
                               userpwd: "#{ENV['CLIENT_ID']}:#{ENV['CLIENT_SECRET']}")
      json_body = JSON.parse(response.body)
      @expires_in = json_body['expires_in']
      @access_token = json_body['access_token']
      self
    end
  end
end
