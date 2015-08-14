module Password

  def sendPasswordCheck(phone)

    if phone != nil

      user_info = User.where('user_phone like "'+phone.to_s+'" and dict_app_user_status_type = 0').take

      if user_info != nil

        #判断该手机是否已存在初始密码 如存在 进行更新， 不存在 进行插入

        ForgetPassword.where('phone like "'+phone.to_s+'"').delete_all

        password = rand(100000...999999)

        effective_time = Time.now.to_i + 2 * 86400

        effective_create_time = Time.now.to_i

        create = Hash.new

        create['phone'] = phone

        create['verification_code'] = password

        create['effective_time'] = effective_time

        create['effective_create_time'] = effective_create_time

        inital_password_info = ForgetPassword.create(create)

        #将初始密码以短信单形式发送

        message_module = MessageModule.new

        message_module.sendMessagePasswordCheck(phone, password)

        self.res = 1

      else

        self.setErrorCode(10009)

      end


    end

  end


  def checkForgetPassword(phone, password)

    if phone != nil and password != nil

      password_info = ForgetPassword.where('phone like "'+phone.to_s+'" and verification_code like "'+password.to_s+'"').take

      if password_info != nil

        ForgetPassword.where('phone like "'+phone.to_s+'"').delete_all

        self.res = 1

      else

        self.setErrorCode(50000)

      end

    end

  end

  #用户修改密码  再APP中的修改密码 来完成

  def saveNewPasswordByUserID(user_id,old_password, new_password, repeat_password)

    if user_id != nil and new_password != nil and repeat_password != nil and old_password != nil

      if new_password == repeat_password

        md5_old_password = Digest::MD5.hexdigest(old_password)

        user_info = User.where('id = '+user_id.to_s+'  and dict_app_user_status_type = 0 and user_password like "'+md5_old_password.to_s+'"').take

        if user_info != nil

          md5_password = Digest::MD5.hexdigest(new_password)

          update = Hash.new

          update['user_password'] = md5_password

          user_info.update(update)

          self.res = 1

        else

          self.setErrorCode(10010)

        end

      else

        self.setErrorCode(50001)

      end

    end

  end


  #用户修改密码 通过忘记密码 来设置

  def saveNewPassword(phone, new_password, repeat_password)

    if phone != nil and new_password != nil and repeat_password != nil

      if new_password == repeat_password

        user_info = User.where('user_phone like "'+phone.to_s+'"  and dict_app_user_status_type = 0').take

        if user_info != nil

          md5_password = Digest::MD5.hexdigest(new_password)

          update = Hash.new

          update['user_password'] = md5_password

          user_info.update(update)

          self.userLogin(phone,new_password)

        else

          self.setErrorCode(10010)

        end

      else

        self.setErrorCode(50001)

      end

    end

  end

end