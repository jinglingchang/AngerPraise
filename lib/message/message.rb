module Send

  $message_get_url = 'http://115.231.94.156/message/send.php?'

  def sendMessageInviation(phone)

    url = ''

    #发送邀请短信

    message = 'phone='+phone+'&message=你的好友已在怒赞APP中邀请了你，请下载应用。对好友进行点评:'+url.to_s+'【hirelib】'

    response = Faraday.get $message_get_url + message.to_s

  end

  def sendMessagePassword(phone,inital_password)

    message = 'phone='+phone.to_s+'&message=你的怒赞初始密码:'+inital_password.to_s+'打死都不要告诉别人哦【怒赞】'

    response = Faraday.get $message_get_url + message.to_s


    p response

  end

  def sendMessagePasswordCheck(phone,inital_password)

    message = 'phone='+phone.to_s+'&message=验证码:'+inital_password.to_s+'打死都不要告诉别人哦【怒赞】'

    response = Faraday.get $message_get_url + message.to_s


    p response

  end

end