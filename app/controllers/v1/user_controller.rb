class V1::UserController < ApplicationController


  #用户剩余任务数

  def mission

    user_id = params['user_id']

    user_module = UserModule.new

    array = Hash.new

    if user_id != nil

      user_module.get_user_mission(user_id)

    else

      user_module.setErrorCode 101

    end

    array['user'] = user_module

    echoJson(array)

  end

  #用户简历  创建简历URL地址

  def resume_url

    user_id = params['user_id']

    user_module = UserModule.new

    array = Hash.new

    if user_id != nil

      user_module.createResumeUrl(user_id)

    else

      user_module.setErrorCode 101

    end

    array['resume'] = user_module


    echoJson(array)

  end


  #用户设备信息

  def device

    #用户ID

    user_id = params['user_id']

    #设备ID  1为IOS 2为WP 3为安卓

    dict_device_id = params['dict_device_id']

    #用户允许推送的ID

    device_id = params['device_id']

    #用户设备的名称

    device_name = params['device_name']

    #用户设备版本

    device_version = params['device_version']

    user_module = UserModule.new

    if user_id != nil and dict_device_id != nil and device_name != nil and device_version

      user_module.saveUserDevice(user_id, dict_device_id, device_id, device_name, device_version)

    else

      user_module.setErrorCode 101

    end


    echoJson(user_module)

  end

  #用户登录

  def login

    phone = params[:phone]

    password = params[:password]

    userModule = UserModule.new

    if phone.to_i > 0 and password.to_s != ''

      userModule.userLogin(phone, password)

    else

      userModule.setErrorCode(101)

    end

    echoJson(userModule)


  end

  #用户注册

  def register

    user_id = params['user_id']

    password = params['password']

    name = params['name']

    userModule = UserModule.new

    if user_id.to_i > 0 and password.to_s != '' and name != nil

      userModule.userRegister(user_id, password, name)

    else

      userModule.setErrorCode(101)

    end

    echoJson(userModule)


  end

  #获取个人信息

  def info

    user_id = params[:user_id]

    userModule = UserModule.new

    array = Hash.new

    if user_id.to_i > 0

      userModule.userInfo(user_id)

    else

      userModule.setErrorCode(101)

    end

    array['user'] = userModule

    echoJson(array)

  end


  #获取用户的积分

  def integral

    user_id = params['user_id']

    array = Hash.new

    userModule = UserModule.new

    if user_id != nil

      userModule.getUserIntegral(user_id)

    else

      userModule.setErrorCode 101

    end

    array['user'] = userModule

    echoJson(array)

  end

  #用户匹配职位数

  def user_position_number

    user_id = params['user_id']

    userModule = UserModule.new

    if user_id != nil

      userModule.getPositionNumberByResume(user_id)

    else

      userModule.setErrorCode 101

    end

    echoJson(userModule)


  end


  #修改头像

  def update_photo

    user_id = params[:user_id]

    userModule = UserModule.new

    if user_id.to_i > 0

      array = Hash.new

      userModule.updateUserPhoto(user_id, params[:images])

      array['user'] = userModule

    else

      userModule.setErrorCode 101

    end

    echoJson(array)


  end


  #修改昵称

  def update_nickname

    user_id = params['user_id']

    user_nickname = params['nickname']

    user_module = UserModule.new

    if user_id != nil and user_nickname != nil

      user_module.updateUserNickName(user_id, user_nickname)

    else

      user_module.setErrorCode 101

    end

    echoJson(user_module)


  end


  #忘记密码  修改密码

  def forget_update_password

    user_module = UserModule.new

    phone = params['phone']

    new_password = params['password']

    repeat_password = params['repeat_password']

    if phone != nil and new_password != nil and repeat_password != nil

      user_module.saveNewPassword(phone, new_password, repeat_password)

    else

      user_module.setErrorCode 101

    end


    echoJson(user_module)

  end

  #应用内部修改密码

  def update_password

    user_module = UserModule.new

    user_id = params['user_id']

    old_password = params['old_password']

    new_password = params['new_password']

    repeat_password = params['repeat_password']

    if user_id != nil and old_password != nil and new_password != nil and repeat_password != nil

      user_module.saveNewPasswordByUserID(user_id, old_password, new_password, repeat_password)

    else

      user_module.setErrorCode 101

    end

    echoJson(user_module)

  end

  #用户申请过的职位列表

  def user_position_apply_list

    user_id = params['user_id']

    user_module = UserModule.new

    if user_id != nil

      user_module.getUserPositionApply(user_id)

    else

      user_module.setErrorCode 101

    end

    echoJson(userModule)

  end


  #职位收藏

  def position_collect

    user_id = params[:user_id]

    userModule = UserModule.new

    if user_id.to_i > 0

      userModule.getUserCollect(user_id)

    else

      userModule.setErrorCode(101)

    end


    echoJson(userModule)


  end

  #获取初始密码

  def get_initial_password

    phone = params[:phone]

    userModule = UserModule.new

    if phone != nil

      userModule.createInitialPassword(phone)

    else

      userModule.setErrorCode(101)

    end


    echoJson(userModule)

  end

  #检查初始密码

  def check_password

    phone = params['phone']

    password = params['password']

    user_module = UserModule.new

    if phone != nil and password != nil

      user_module.validationInitialPassword(phone, password)
    else

      user_module.setErrorCode(101)

    end

    echoJson(user_module)

  end


  #获取简历

  def get_resume

    user_id = params[:user_id]

    user_module = UserModule.new

    array = Hash.new

    if user_id != nil

      user_module.getInfoResumeByUserId(user_id)

    else
      user_module.setErrorCode(101)
    end

    array['resume'] = user_module

    echoJson(array)


  end

  #获取预览简历URL地址

  def get_resume_perview_url

    user_id = params[:user_id]

    user_module = UserModule.new

    array = Hash.new

    if user_id != nil

      user_module.getResumePerviewUrl(user_id)

    else

      user_module.setErrorCode(101)
    end

    array['resume'] = user_module


    echoJson(array)

  end


  #获取完善简历URL地址

  def get_resume_perfect_url

    user_id = params[:user_id]

    user_module = UserModule.new

    array = Hash.new

    if user_id != nil

      user_module.getUserResumePerfectUrl(user_id)

    else

      user_module.setErrorCode(101)
    end

    array['resume'] = user_module


    echoJson(array)

  end


  #获取用户通讯录

  def getUserPhoneBook

    user_id = params['user_id']

    phone_book = params['phone_book']

    user_module = UserModule.new

    if user_id != nil and phone_book != nil

      user_module.deal_phone(user_id, phone_book)

    else

      user_module.setErrorCode(101)

    end


    echoJson(user_module)

  end

  #插入未激活账号

  def user_inactive

    phone = params['phone']

    name = params['name']

    source = params['source']

    user_module = UserModule.new

    if phone != nil and name != nil and source != nil

      user_module.userInactiveAccountAll(phone, name, source)

    else

      user_module.setErrorCode 101

    end


    echoJson(user_module)

  end

  #获取用户动态内容

  def getUserDynamic


  end

  #用户登出接口

  def logout

    user_id = params['user_id']

    user_module = UserModule.new

    if user_id != nil

      Token.where('user_id = '+user_id.to_s).delete_all

      user_module.res = 1.to_s

    else

      user_module.setErrorCode 101

    end


    echoJson(user_module)

  end


  #添加黑名单

  def backlist

    user_id = params['user_id']

    fid = params['fid']

    user_module = UserModule.new

    if user_id != nil and fid != nil

      user_module.addUserBackList(user_id, fid)

    else

      user_module.setErrorCode 101

    end


    echoJson(user_module)

  end


  #用户获取二维码

  def code

    user_id = params['user_id']

    user_module = UserModule.new

    if user_id != nil

      user_module.getUserCodeUrl(user_id)

    else

      user_module.setErrorCode 101

    end

    echoJson(user_module)

  end


  #我的钱包URL地址

  def pay_url

    user_id = params['user_id']

    user_module = UserModule.new

    if user_id != nil

      user_module.getUserPayUrl(user_id)

    else

      user_module.setErrorCode 101

    end

    echoJson(user_module)

  end


  #个人首页点击投递记录和收藏 地址

  def user_apply_url

    user_id = params['user_id']

    user_module = UserModule.new

    if user_id != nil

      user_module.getUserApplyUrl(user_id)

    else

      user_module.setErrorCode 101

    end


    echoJson(user_module)


  end


  #个人首页  我的好友 调用接口  返回我的好友web 地址

  def user_friend_url

    user_id = params['user_id']

    user_module = UserModule.new

    if user_id != nil

      user_module.getUserFriendUrl(user_id)

    else

      user_module.setErrorCode 101

    end


    echoJson(user_module)

  end

  #个人首页  HR特权 WEB地址

  def user_hr_url

    user_id = params['user_id']

    user_module = UserModule.new

    if user_id != nil

      user_module.getUserHrUrl(user_id)

    else

      user_module.setErrorCode 101

    end


    echoJson(user_module)

  end

  #用户忘记密码  申请验证码

  def apply_password_check

    phone = params['phone']

    user_module = UserModule.new

    if phone != nil

      user_module.sendPasswordCheck(phone)

    else

      user_module.setErrorCode 101

    end


    echoJson(user_module)

  end

  #忘记密码  将手机号码与验证码进行验证

  def forget_password_check

    phone = params['phone']

    password = params['password']

    user_module = UserModule.new

    if phone != nil and password != nil

      user_module.checkForgetPassword(phone, password)


    else

      user_module.setErrorCode 101

    end


    echoJson(user_module)

  end

end