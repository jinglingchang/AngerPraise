module Info


  attr_accessor :user_id

  attr_accessor :user_name

  attr_accessor :user_phone

  attr_accessor :photo_url

  attr_accessor :register_time

  attr_accessor :user_intergral

  attr_accessor :user_status_type

  attr_accessor :user_apply_url

  attr_accessor :hr_url

  attr_accessor :pay_url

  attr_accessor :user_friend_url

  attr_accessor :hirelib_code

  attr_accessor :position_number

  attr_accessor :mission_number

  attr_accessor :token

  attr_accessor :user_status

  attr_accessor :user


  def get_user_mission(user_id)

    user_task_all = 0

    user_task_today = 0

    if user_id != nil

      current_times = Time.mktime(Time.now.year, Time.now.month, Time.now.day).to_i

      user_task = UserTask.where('user_id = '+user_id.to_s+' and insert_time like "'+current_times.to_s+'"').take

      if user_task != nil

        if user_task['review_friend_string'] != nil

          string = user_task['review_friend_string']

          string_length = string.length

          string = string[1, string_length.to_i - 2]

          if string.to_s.index('|') != nil

            string_array = string.split('|')

            user_task_all = string_array.length

          else

            user_task_all = 1

          end

        else

          user_task_all = 0

        end


        if user_task['have_review_friend_string'] != nil

          strings = user_task['have_review_friend_string']

          strings_length = strings.length

          strings = strings[1, strings_length.to_i - 2]

          if string.to_s.index('|') != nil

            strings_array = strings.split('|')

            user_task_today = strings_array.length

          else

            user_task_today = 1

          end

        else

          user_task_today = 0

        end

      end

      user_info = User.where('id = '+user_id.to_s).take

      if user_info != nil

        user_task_all +=1

        if user_info['user_mission'].to_i == 1

          user_task_today+=1

        end

      end


      self.mission_number = user_task_all.to_i - user_task_today.to_i

    end

  end

  def get_user_name(user_id)

    if user_id != nil

      user_info = User.where('id ='+user_id.to_s).take

      if user_info['user_name'] == nil

        if user_info['dict_source_id'].to_i == 1

          #获取微信第三方信息库

          user_weixin_info = WeixinBinding.where('user_id = '+user_id.to_s).take

          if user_weixin_info != nil

            self.user_name = user_weixin_info['weixin_nickname']

          end

        end


      else

        self.user_name = user_info['user_name']

      end


    end

  end


  def hirelib_number(user_id)

    if user_id != nil

      max = 6

      self.hirelib_code = "0"*(max - user_id.to_s.length)+user_id.to_s

    end

  end

  #获取用户昵称

  def setUserName(userInfo)

    if userInfo != nil

      if userInfo.user_name != nil

        self.user_name = userInfo.user_name

      else

        if userInfo['dict_source_id'].to_i == 1

          user_weixin = WeixinBinding.where('user_id = '+userInfo.id.to_s).take

          if user_weixin != nil

            self.user_name = user_weixin['weixin_nickname']

          else

            self.user_name = ''

          end

        end

      end

    end

  end

  def getUserIntegral(user_id)

    if user_id != nil

      #获取所有的积分操作

      number = 0

      user_integrals = UserIntegralChange.where('user_id = '+user_id.to_s)

      if user_integrals != nil

        user_integrals.each do |v|

          if v['integral'].to_s.gsub!('-', '')

            number-=v['integral'].to_i

          else


            number+=v['integral'].to_i

          end

        end

      end

    end

    self.user_intergral = number.to_s

  end

  def userInfo(user_id)

    if user_id.to_i > 0

      userDal = User.new

      userInfo = userDal.userInfo(user_id)

      if userInfo != nil

        self.user_id = userInfo.id

        self.setUserName(userInfo)

        self.photo_url = self.getUserPhoto(user_id)

        self.hr_privilege = userInfo.hr_privilege

        self.hr_status(user_id)

        self.hirelib_number(user_id)

        self.getUserResumeUrl(user_id)

        self.get_user_mission(user_id)

        self.getUserIntegral(user_id)

        self.checkResumeByUserId(user_id)

        self.getPositionNumberByResume(user_id)

      else

        self.setErrorCode(10004)

      end


    end

  end


  def userInfoAndHomepage(user_id)

    if user_id != nil

      user_module = UserModule.new

      user_module.userInfo(user_id)

      self.user = user_module

      self.getTodayTaskListArray(user_id)

      self.today_award(user_id)

    end



  end

  def updateUserNickName(user_id, nickname)

    if user_id.to_i > 0 and nickname != ''

      userDal = User.new

      res = userDal.updateUserNickNameByUserId(user_id, nickname)

      if res == 1

        self.res = 1

      else

        self.setErrorCode(10004)

      end

    end

  end


  def countUserFriendAndInview(user_id)

    if user_id != nil


    end

  end


  def saveUserInfo(user_id)

    if user_id != nil

      #修改用户登录时间

      addUserLogin = Hash.new

      addUserLogin['user_id'] = user_id

      addUserLogin['login_time'] = Time.now.to_i

      UserLogin.create(addUserLogin)


    end


  end


  #将手机号码在雇主平台的用户库中查询，如存在，将该账户修改为HR特权账号

  def getPhoneHr(phone)

    if phone != nil

      info = EmployersAccount.where('phone like "'+phone.to_s+'"').take

      if info != nil

        info

      end


    end

  end


  #验证手机号码是否合法

  def checkPhone(phone)

    if phone != nil

      match = /^(13[0-9]|15[0|3|6|7|8|9]|18[0-9])\d{8}$/

      match_result = phone.match(match)

      if match_result != nil

        return 1

      else

        return 0

      end

    end

  end


  def updateUserStatus(user_id, status)

    if user_id != nil and status != nil

      user_info = User.where('id = '+user_id.to_s).take

      if user_info != nil

        update_hash = Hash.new

        update_hash['dict_app_user_status_type'] = status

        user_info.update(update_hash)

      end

    end


  end

  def getUserStatus(user_id)

    if user_id != nil

      user_info = User.where('id = '+user_id.to_s).take

      if user_info != nil

          self.user_status = user_info['dict_app_user_status_type']

      end


    end

  end


  def getUserPayUrl(user_id)

    if user_id != nil

      self.pay_url = $new_app_url.to_s+'pay/binding?user_id='+user_id.to_s

    end

  end


  def getUserApplyUrl(user_id)

    if user_id != nil

      self.user_apply_url = $new_app_url.to_s+'user/apply?user_id='+user_id.to_s

    end

  end

  def getUserFriendUrl(user_id)

    if user_id != nil

      self.user_friend_url = $new_app_url.to_s+'user/friend?user_id='+user_id.to_s

    end

  end

  def getUserHrUrl(user_id)

    if user_id != nil

      self.hr_url = $new_app_url.to_s+'hr/hr_privilege?user_id='+user_id.to_s

    end

  end

end