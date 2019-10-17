# frozen_string_literal: true

module External
  module DeliveryMessage
    def send_message
      mail_body = <<~MAIL
<p>
  Olá #{service.applicant_name},
</p>
<p>
  Você foi convidado(a) para participar de um processo de avaliação: <br />
  <b>Descrição da Oportunidade:</b> #{service.job_title}
</p>
<p>
  Para participar, basta se cadastrar, aceitar o convite e fazer sua avaliação.<br />
  É rápido e muito simples!
</p>
<p>
  <a href="https://mkt-test-app.herokuapp.com/#{service.external_code}" target="_blank">Clique aqui!</a>
</p>
<p>
  Sucesso!<br />
  Equipe JobCoach Empresas
</p>
<p>
  Atenção: Você só estará participando deste processo se Aceitar o convite no Painel do JobCoach Empresas.
</p>
<small>
  Esta é uma mensagem automática. Por favor, não responda este e-mail.
</small>
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
