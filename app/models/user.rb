class User < ActiveRecord::Base


  self.table_name = 'user'

  def getUserPhone(phone)

    if phone.to_s != ''

      userInfo = User.where('user_phone like "'+phone.to_s+'"').take

      userInfo

    end

  end


  def updateUserNickNameByUserId(user_id, nickname)

    if user_id.to_i > 0 and nickname != ''

      userInfo = User.where('id = '+user_id.to_s).take

      if userInfo != nil

        userInfo.user_name = nickname

        userInfo.save

        return 1

      else

        return 0

      end

    end

  end


  def addUser(user_id, password,name)

    md5_password = Digest::MD5.hexdigest(password)

    userHash = Hash.new

    user_module = UserModule.new

    userHash['user_password'] = md5_password

    userHash['user_name'] = name

    user_info = User.where('id = '+user_id.to_s).take

    if user_info != nil

      hr = user_module.getPhoneHr(user_info['user_phone'])

      if hr != nil

        userHash['hr_privilege'] = 1

        userHash['employers_account_id'] = hr['id']

      end

      userHash['dict_app_user_status_type'] = 0

      user_info.update(userHash)

      user_info

    end

  end


  def userLogin(phone, password)

    if phone.to_s != '' and password.to_s != ''

      md5_password = Digest::MD5.hexdigest(password)

      userInfo = User.where('user_phone like "'+phone.to_s+'" and user_password like "'+md5_password.to_s+'"').take

      userInfo

    end

  end


  def userInfo(user_id)

    if user_id.to_i > 0

      userInfo = User.where('id = '+user_id.to_s).take

      userInfo

    end

  end



  def getUserQuality(user_id)

    if user_id != nil

      users = User.where('id = '+user_id.to_s).take

      if users != nil

        usersQuality = users['user_resume_quality']

        usersQuality = rand(1..70)

      else

        usersQuality = 0

      end

      usersQuality

    end

  end

end
