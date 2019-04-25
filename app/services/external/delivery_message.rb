# frozen_string_literal: true

module External
  module DeliveryMessage
    def send_message
      mail_body = <<~MAIL
        <pre>
        Olá #{service.applicant_name},
         Você foi convidado pela empresa #{service.company_name} à participar
        de um teste de QI para a vaga de "#{service.job_title}"
        </pre>
         <a href="https://mkt-test-app.herokuapp.com/#{service.external_code}" target="_blank">Vamos lá?</a>
      MAIL

      attributes = {
        subject: 'Teste para ser respondido',
        body: mail_body,
        target: 'applicant'
      }

      path = "/v1/oasis-portal/requests/#{service.external_code}/messages"
      Typhoeus.post("#{ENV['GATEWAY_HOST']}#{path}",
                    body: attributes.to_json,
                    headers: { 'Content-Type' => 'application/json',
                               'Authorization' => "Bearer #{access_token}" })
    end
  end
end
