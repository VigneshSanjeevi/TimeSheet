class UserProvider < ApplicationRecord
    belongs_to :user
    def self.find_for_oauth(auth,sign)                               
        user = UserProvider.where(:provider => auth.provider, :uid => auth.uid).first
        unless user.nil?
            user.user
        else
            puts auth.info
            registered_user = User.where(:email => auth.info.email).first
            if sign == 1
            unless registered_user.nil?
                        UserProvider.create!(
                              provider: auth.provider,
                              uid: auth.uid,
                              user_id: registered_user.id
                              )
                              sign = 3
                registered_user
            else
                user = User.create!(                    
                            email: auth.info.email,
                            password: Devise.friendly_token[0,20],
                            )
                            sign = 3
                user_provider = UserProvider.create!(
                    provider:auth.provider,
                            uid:auth.uid,
                              user_id: user.id
                    )
                    sign = 3
                user
            end
        end
        end
    end    
end
