# frozen_string_literal: true

# Mock cognito uri response
module WebmockHelper
  def login_as(user)
    jwk = JWT::JWK.new(OpenSSL::PKey::RSA.new(2048), "optional-kid")
    payload = { username: user.uuid,
                user_attributes: [
                                  { name: "sub", value: user.uuid },
                                  { name: "email_verified", value: "true" },
                                  { name: "email", value: user.email }
                                ]
              }
    headers = { kid: jwk.kid }

    keys_body = { keys: [jwk.export] }.to_json
    stub_request(:any, URI(TokenService::URL)).to_return(body: keys_body, status: 200, headers: {})

    @token = JWT.encode(payload, jwk.keypair, "RS256", headers)
  end
end
