class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  def self.from_omniauth(auth)
    puts "AUTH: #{auth.inspect}"
    where(provider: auth.provider, uid: auth.uid).first_or_create do |account|
      account.provider = auth.provider
      account.uid = auth.uid
      account.login = auth.extra.raw_info.login
      account.email = auth.info.email
      account.password = Devise.friendly_token[0,20]
    end
  end

  has_one :registrant
end
