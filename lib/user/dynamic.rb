module Dynamic


  attr_accessor :dynamic

  attr_accessor :dynamic_url

  def getUserDynamic(user_id)

    if user_id != nil

      user_dal = User.new

      user_info = user_dal.userInfo(user_id)

      if user_info != nil



      else

        self.setErrorCode(10004)

      end


    end

  end

  def userDynamic(user_id)

    if user_id != nil

      self.dynamic_url = $app_url.to_s+'dynamic/user_dynamic?user_id='+user_id.to_s


    end

  end

end