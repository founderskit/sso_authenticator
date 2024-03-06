module SsoAuthenticator
  class CallbacksController < ActionController::Base
    def callback
      code = params[:code]
      token = SsoAuthenticator::AuthorizationCode.exchange!(code)
      cookies[:sso_token] = SsoAuthenticator::SignedCookie.encrypt(token)
      redirect_to "/"
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Invalid code" }, status: :bad_request
    end
  end
end
