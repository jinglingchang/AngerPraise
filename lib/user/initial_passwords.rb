module InitialPasswords

  attr_accessor :validation_inital

  attr_accessor :phone

  attr_accessor :password

  attr_accessor :effective_time

  attr_accessor :effective_create_time

  def checkPasswordSendTime(phone)

    res = 0

    if phone != nil

      #获取用户获取初始密码时间

      user_inital = InitialPassword.where('phone like "'+phone.to_s+'"').take

      if user_inital != nil

        user_inital_create_time = user_inital['effective_create_time']

        current_time = Time.now.to_i

        if current_time-user_inital_create_time.to_i >=60

          res = 1

        end

      else

        res = 1

      end

    end

    res

  end


  #通过手机号码生成初始密码

  def createInitialPassword(phone)

    if phone != nil

      #获取该手机号码在用户表中是否存在，如存在则获取当前的用户状态，如状态大于2时，说明用户已进行过验证密码等操作

      user_dal = User.new

      user_info = user_dal.getUserPhone(phone)

      check_user_status = 1

      if user_info != nil

        if user_info['dict_app_user_status_type'] == 2

          check_user_status = 0

        end

        if user_info['dict_app_user_status_type'] == 3

          check_user_status = 0

        end

        if user_info['dict_app_user_status_type'] == 1

          check_user_status = 0

        end

      else

        check_user_status = 0

      end

      res = self.checkPasswordSendTime(phone)

      if res == 0

        self.setErrorCode(10008)

      else

        if check_user_status == 0

          #判断该手机是否已存在初始密码 如存在 进行更新， 不存在 进行插入

          InitialPassword.where('phone like "'+phone.to_s+'"').delete_all

          inital_password = rand(100000...999999)

          effective_time = Time.now.to_i + 2 * 86400

          effective_create_time = Time.now.to_i

          create = Hash.new

          create['phone'] = phone

          create['password'] = inital_password

          create['effective_time'] = effective_time

          create['effective_create_time'] = effective_create_time

          inital_password_info = InitialPassword.create(create)

          if inital_password_info != nil

            self.phone = phone

            self.password = inital_password

            self.effective_time =effective_time

            self.effective_create_time = effective_create_time

            #根据手机号码添加账号

            user_info = self.registerUserByPhone(phone.to_s, 2, inital_password)

            if user_info != nil

              self.user_id = user_info.id

              #生成用户TOKEN

              user_module = UserModule.new

              self.token = user_module.createToken(user_info.id)

            end

            #将初始密码以短信单形式发送

            message_module = MessageModule.new

            message_module.sendMessagePassword(phone, inital_password)

          end

        else

          self.setErrorCode(10001)


        end


      end


    end

  end


  #更新初始密码状态

  def updateInitialPasswordStatus(phone, initial_password)

    if phone != nil and initial_password != nil

      user_initial = InitialPassword.where('phone like "'+phone.to_s+'" and password like "'+initial_password.to_s+'"').take

      if user_initial != nil and self.phone.to_i > 0

        self.validation_inital = 1.to_s

        update = Hash.new

        update['status'] = 1

        user_initial.update(update)

      end

    end

  end

  #验证初始密码时间

  def validationInitialPasswordTime(phone, initial_password)

    if phone != nil and initial_password != nil

      user_initial = InitialPassword.where('phone like "'+phone.to_s+'" and password like "'+initial_password.to_s+'"').take

      if user_initial != nil

        current_time = Time.now.to_i

        effective_time = user_initial['effective_time']

        if effective_time.to_i >= current_time.to_i

          self.phone = phone

        else

          self.setErrorCode(10007)

        end

      else

        self.setErrorCode(10006)

      end


    end


  end


  def validationInitialPassword(phone, initial_password)

    if phone != nil and initial_password != nil

      self.validationInitialPasswordTime(phone,initial_password)

      if self.error == nil

        self.updateInitialPasswordStatus(phone,initial_password)

        user_info = User.where('user_phone like "'+phone.to_s+'"').take

        if user_info != nil

          self.updateUserStatus(user_info.id,3)

        end



      end

    end

  end

end