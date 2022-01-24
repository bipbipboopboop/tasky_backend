class User < ApplicationRecord
  has_many :task

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :recoverable,
         jwt_revocation_strategy: JwtDenylist

end