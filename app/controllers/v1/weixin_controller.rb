class V1::WeixinController < ApplicationController

  def share

    user_id = params['user_id']

    string = params['string']

    string_split = string.split('_')

    result = Hash.new

    #说明用户是邀请好友 还是 提高竞争力


    case string

      when 'wechat_invite'

        result['title'] = '邀请好友'

        result['content'] = $new_app_url+'weixin/index?user_id='+user_id.to_s+'&type=1'

    end

    if string_split[1] == 'invite'


    else

      result['title'] = '小怒告诉你,邀请你的好友来怒赞点评,可以积攒你的人品,还不快试试!!!'

      result['content'] = $new_app_url+'weixin/index?user_id='+user_id.to_s+'&type=1'

    end

    render :json => result

  end


end
