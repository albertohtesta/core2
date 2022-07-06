# frozen_string_literal: true

# authenticate cognito user
class TokenService < CognitoService
  ISS = "https://cognito-idp.#{ENV.fetch("AWS_REGION", nil)}.amazonaws.com/#{CognitoService::POOL_ID}".freeze
  URL = "https://cognito-idp.#{ENV.fetch("AWS_REGION",
                                         nil)}.amazonaws.com/#{CognitoService::POOL_ID}/.well-known/jwks.json".freeze

  attr_reader :error

  def verify
    begin
      JWT.decode(@user_object[:token], nil, true,
                 { iss: ISS, verify_iss: true, algorithms: ["RS256"], jwks: jwt_config })
    rescue StandardError => e
      @error = e
      return false
    end
    true
  end

  private

  def verification_uri
    @verification_uri ||= URI(URL)
  end

  def jwt_config
    resp = Net::HTTP.get_response(verification_uri)
    @jwt_config ||= JSON.parse(resp.body, symbolize_names: true)
  end
end
