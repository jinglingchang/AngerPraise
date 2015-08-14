class ApplicationController < ActionController::API

  before_action :api_record


  def echoJson(object)

    if object != nil

      if $error_code != 0

        father_module  = FatherModule.new

        father_module.echoErrorCode $error_code

        object_module = father_module

      else

        object_module = object

      end

      render :json => object_module


    end

  end

  def require_token_authentication

    token = request.env['HTTP_AUTHORIZATION']

    if params['token'] != nil

      token = params['token']

    end

    user_module = UserModule.new

    if token == nil

      user_module.setErrorCode(102)

      echoJson(user_module)

    else

      #判断token是否合法

      user_token = Token.where('token_name like "'+token.to_s+'"').take

      if user_token != nil

        #判断TOKEN时间是否已过去

        params['user_id'] = user_token['user_id']

      else

        user_module.setErrorCode(104)

        echoJson(user_module)

      end

    end


  end

  def api_record

    $error_code = 0

    response.headers['Content-Type']= "application/json;charset=utf-8"

    path_info = request.env['PATH_INFO'].to_s.split('/')

    function_array = Array['user/login', 'user/get_password', 'user/apply_password_check', 'user/check_password', 'user/forget_password_check', 'user/forget_update_password','position/detail','company/detail']

    function_string = path_info[2]+'/'+path_info[3].to_s

    if function_string != nil  and function_string != ''

      if function_array.include?(function_string)

      else

        self.require_token_authentication

      end

    end


  end


  def filterNilHash(hash)

    if hash.length > 0

      hash.each do |k, v|

        if v == nil

          hash.delete(k)

        end

      end

      hash

    end

  end

end
