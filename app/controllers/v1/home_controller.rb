class V1::HomeController < ApplicationController


  def index

    user_id = params['user_id']

    #首页内容（显示用户简历综合评分，待点评好友人数，可进行面试补贴的个数，当用户为HR时有待评价应聘者的个数）

    user_module = UserModule.new

    if user_id != nil

      user_module = UserModule.new

      user_module.userInfoAndHomepage(user_id)

    else

      user_module.setErrorCode 101

    end

    #response.headers['Content-Type'] = 'application/json;charset=utf-8'


    echoJson(user_module)

  end


  def indexs

    user_id = params['user_id']

    #首页内容（显示用户简历综合评分，待点评好友人数，可进行面试补贴的个数，当用户为HR时有待评价应聘者的个数）

    user_module = UserModule.new

    if user_id != nil

       user_module = UserModule.new

       user_module.userInfo(user_id)

       self.user = user_module

       self.getTodayTaskListArray(user_id)

       self.today_award(user_id)

    else

      user_module.setErrorCode 101

    end

    #response.headers['Content-Type'] = 'application/json'

    echoJson(user_module)


  end

  #获取可评价的好友列表

  def friend

    user_id = params['user_id']

    user_module = UserModule.new

    if user_id != nil

      user_module.getUserFriendList(user_id)

    else

      user_module.setErrorCode 101

    end

    #response.headers['Content-Type'] = 'application/json'

    echoJson(user_module)


  end



  #HR面试补贴

  def hr_interview

    user_id = params['user_id']

    user_module = UserModule.new

    if user_id != nil

      user_module.getHRInterviewList(user_id)

      user_module.getUserResumeUrl(user_id)

    else

      user_module.setErrorCode 101

    end

    #response.headers['Content-Type'] = 'application/json'

    echoJson(user_module)


  end



  #用户动态

  def dynamic

    user_id = params['user_id']

    user_module = UserModule.new

    if user_id != nil

      user_module.userDynamic(user_id)

    else

      user_module.setErrorCode 101

    end

    #response.headers['Content-Type'] = 'application/json'

    echoJson(user_module)

  end

  def test

    phone = params['phone']

    user_module = UserModule.new

    user_module.checkPhone(phone)

  end

end