# frozen_string_literal: true

# Mock cognito uri response
module WebmockHelper
  def stub_cognito_uri
    jwk = JWT::JWK.new(OpenSSL::PKey::RSA.new(2048), "optional-kid")
    payload = { data: "data" }
    headers = { kid: jwk.kid }

    keys_body = { keys: [jwk.export] }.to_json
    stub_request(:any, URI(TokenService::URL)).to_return(body: keys_body, status: 200, headers: {})

    @token = JWT.encode(payload, jwk.keypair, "RS256", headers)
  end
end
