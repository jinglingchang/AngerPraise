module Register


  attr_accessor :userObject

  #添加用户未激活账号 （通讯录添加时）

  def addUserInactiveAccount(phone, name)

    if phone != nil and name != nil

      userDal = User.new

      userResult = userDal.getUserPhone(phone)

      if userResult == nil

        hash = Hash.new

        hash['user_phone'] = phone

        hash['user_name'] = name

        hash['user_status'] = 1

        hash['source'] = 'phone_inviation'

        user_info = User.create(hash)

      end

      user_info

    end

  end

  def addUserInactiveAccountBySource(phone, name, source)

    if phone != nil and name != nil

      userDal = User.new

      userResult = userDal.getUserPhone(phone)

      if userResult == nil

        hash = Hash.new

        hash['user_phone'] = phone

        hash['user_name'] = name

        hash['user_status'] = 1

        hash['source'] = source

        user_info = User.create(hash)

      else

        user_info = userResult

      end

      user_info

    end

  end


  def userInactiveAccountAll(phone, name, source)

    if phone != nil and name != nil

      user_info = self.addUserInactiveAccountBySource(phone, name, source)

      if user_info != nil

        self.createCodeByUserId(user_info.id)

        self.default_photo(user_info.id)

        self.user_id = user_info['id']

      else

        self.user_id = 0

      end

    end

  end

  #用户注册。更新新密码以及用户昵称

  def userRegister(user_id, password, name)

    if user_id.to_s != '' and password.to_s != '' and name != nil

      userDal = User.new

      userObject = userDal.addUser(user_id, password, name)

      #self.userObject = userObject

      if userObject != nil

        if userObject.id.to_i > 0

          #添加用户好友列表

          user_friend = UserEvaluation.where('user_id = '+userObject.id.to_s).take

          if user_friend == nil

            add_friend = Hash.new

            add_friend['user_id'] = userObject.id

            UserEvaluation.create(add_friend)

          end

          #判断是否有微信评价获得的奖励 并 进行解冻

          user_integral = UserIntegralChange.where('user_id = '+userObject.id.to_s+' and source like "weixin_inviation" and status = 0 ')

          if user_integral != nil

            if user_integral.length.to_i > 0

              updates = Hash.new

              updates['status'] = 1

              user_integral.update_all(updates)

            end

          end

          user_review_data = UserEvaluationDetail.where('by_evaluation_user_id = '+userObject.id.to_s)

          if user_review_data != nil

            user_review_data.each do |v|

              id = v['id']

              user_integrals = UserIntegralChange.where('user_evaluation_details_id = '+id.to_s)

              if user_integrals != nil

                if user_integrals.length.to_i > 0

                  updates = Hash.new

                  updates['status'] = 1

                  user_integrals.update_all(updates)

                end

              end

            end

          end


          self.default_photo(userObject.id)

          self.userInfoAndHomepage(userObject.id)

          #self.createCodeByUserId(userObject.id)
        end


      end


    end

  end

  #当用户填写手机时,并获取初始密码,验证码获取成功时,判断手机号码是否存在数据库中,如存在,进行更新密码操作,不存在进行添加用户账号操作

  def registerUserByPhone(phone, status, password)

    if phone != nil and status != nil

      result = self.checkPhone(phone)

      if result != 0

        #判断该手机号码是否已被注册，如手机号码存在并且用户状态为1时,该账户为微信或通讯录导入,将状态修改为2以及修改初始密码即可,将用户信息返回到前端

        user_info = User.where('user_phone = '+phone.to_s).take

        md5_password = Digest::MD5.hexdigest(password.to_s)

        if user_info == nil

          add_user_hash = Hash.new

          add_user_hash['user_phone'] = phone

          add_user_hash['dict_app_user_status_type'] =status

          add_user_hash['user_password'] = md5_password

          add_user_hash['user_register_time'] = Time.now.to_i

          user_info = User.create(add_user_hash)

          user_info

        else

          update_user_info = Hash.new

          if user_info['dict_app_user_status_type'].to_i == 1

            update_user_info['dict_app_user_status_type'] = 2

          end

          update_user_info['user_password'] = md5_password

          user_info.update(update_user_info)

          user_info

        end

      end

    end


  end

end

