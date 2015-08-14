module Login

  attr_accessor :hr_privilege

  attr_accessor :user

  def userLogin(phone, password)

    if phone.to_s != '' and password.to_s != ''

      userDal = User.new

      userResult = userDal.userLogin(phone, password)

      if userResult != nil

        if userResult.id.to_i > 0

          self.saveUserInfo(userResult.id)

          #判断用户当前状态为多少 如为类型为2或3时，说明用户使用初始密码进行登录,需判断该初始密码是否有效

          if userResult.dict_app_user_status_type.to_i == 2

            #验证初始密码是否过期

            self.validationInitialPasswordTime(phone, password)

          end

          if self.error == nil

            self.userInfoAndHomepage(userResult.id)

            user_module = UserModule.new

            self.token = user_module.createToken(userResult.id)

          end

        end

      else

        self.setErrorCode(10003)

      end

    end

  end

end