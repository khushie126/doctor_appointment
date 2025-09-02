# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
   skip_before_action :verify_signed_out_user, only: :destroy
   respond_to :json

  def create
  user = User.find_by(email: sign_in_params[:email])

  if user&.valid_password?(sign_in_params[:password])
    token = JWT.encode(
      { sub: user.id, exp: 7.days.from_now.to_i },
      Rails.application.credentials.devise_jwt_secret_key!,
      'HS256'
    )

    render json: {
      status: { code: 200, message: 'Logged in successfully' },
      data: { token: token, user: UserSerializer.new(user).serializable_hash[:data][:attributes] }
    }, status: :ok
  else
    render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unauthorized
  end
end
 private
  def respond_to_on_destroy

    if request.headers['Authorization'].present?
      Rails.logger.info "Authorization: #{request.headers['Authorization']}"

      token = request.headers['Authorization'].split(' ').last
     jwt_payload = JWT.decode(
       token,
          Rails.application.credentials.devise_jwt_secret_key!, 
           true,
             { algorithm: 'HS256' }
           ).first

    end

    render json: { status: { code: 200, message: "Logged out successfully" } }, status: :ok
  end

#  

# def respond_to_on_destroy
#   Rails.logger.info "Authorization: #{request.headers['Authorization']}"

#   if request.headers['Authorization'].present?
#     token = request.headers['Authorization'].split(' ').last
#     jwt_payload = JWT.decode(
#       token,
#       Rails.application.credentials.devise_jwt_secret_key!,
#       true,
#       algorithm: 'HS256'
#     ).first

#     current_user = User.find(jwt_payload['sub'])
#   end

#   if current_user
#     render json: { status: 200, message: 'Logged out successfully.' }, status: :ok
#   else
#     render json: { status: 401, message: "Couldn't find an active session." }, status: :unauthorized
#   end
# end


  # def respond_with(current_user, _opts = {})
  #    render json: {
  #     status: { 
  #       code: 200, message: 'Logged in successfully.',
  #       data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
  #     }
  #   }, status: :ok
  # end
  # def respond_to_on_destroy
  #   if request.headers['Authorization'].present?
  #     jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
  #     current_user = User.find(jwt_payload['sub'])
  #   end
    
  #   if current_user
  #     render json: {
  #       status: 200,
  #       message: 'Logged out successfully.'
  #     }, status: :ok
  #   else
  #     render json: {
  #       status: 401,
  #       message: "Couldn't find an active session."
  #     }, status: :unauthorized
  #   end
  # end
  

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  protected

  # Override to prevent Devise from trying to use flash
  def set_flash_message!(*args); end
end
