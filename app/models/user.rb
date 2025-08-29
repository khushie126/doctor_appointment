class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   include Devise::JWT::RevocationStrategies::JTIMatcher
def generate_jwt
  JWT.encode(
    { sub: id, exp: 60.days.from_now.to_i },
    Rails.application.credentials.devise_jwt_secret_key!,
    'HS256'
  )
end

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
   enum :role, [:doctor, :patient, :medcal_unit]

   def jwt_payload
     super
   end
end

