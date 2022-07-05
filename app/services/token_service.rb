# frozen_string_literal: true

# authenticate cognito user
class TokenService < CognitoService
  attr_reader :error

  def verify
    begin
      iss = "https://cognito-idp.#{ENV.fetch("AWS_REGION", nil)}.amazonaws.com/#{CognitoService::POOL_ID}"
      decoded_token = JWT.decode(@user_object[:token], nil, true,
                                 { iss:, verify_iss: true, algorithms: ["RS256"], jwks: jwt_config })
      puts decoded_token
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def verification_uri
    url = "https://cognito-idp.#{ENV.fetch("AWS_REGION",
                                           nil)}.amazonaws.com/#{CognitoService::POOL_ID}/.well-known/jwks.json"
    @verification_uri ||= URI(url)
  end

  def jwt_config
    resp = Net::HTTP.get_response(verification_uri)
    @jwt_config ||= JSON.parse(resp.body, symbolize_names: true)
  end
end
