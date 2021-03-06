class ApplicationController < ActionController::API
  def current_user_id
    begin
      token = request.headers["Authorization"].split.last
      decoded_array = JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })
      payload = decoded_array.first
    rescue #JWT::DecodeError
      return nil
    end
    payload["user_id"]
  end

  def require_login
    render json: { error: 'Unauthorized' }, status: :unauthorized unless client_has_valid_token?
  end

  private
  def token(user_id)
    payload = { user_id: user_id }
    JWT.encode(payload, hmac_secret, 'HS256')
  end

  def hmac_secret
    ENV["API_SECRET_KEY"]
  end

  def client_has_valid_token?
    !!current_user_id
  end
end
