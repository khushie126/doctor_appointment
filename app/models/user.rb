class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   include Devise::JWT::RevocationStrategies::JTIMatcher
def generate_jwt
  JWT.encode({id: id, exp: 60.days.from_now.to_i}, Rails.application.secret_key_base)
end
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
   enum :role, [:doctor, :patient, :medcal_unit]

end

